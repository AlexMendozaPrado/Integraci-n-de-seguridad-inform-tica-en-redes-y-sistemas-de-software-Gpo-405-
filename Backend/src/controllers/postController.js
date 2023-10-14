const jwt = require("jsonwebtoken");
const Post = require("../models/postModel");
const Favorite = require("../models/favoriteModel");
const Organization = require("../models/organizationModel");
const User = require("../models/userModel");

exports.createPost = async (req, res) => {
  try {
    const token = req.headers.authorization.split(" ")[1];
    const decoded = jwt.verify(
      token,
      "Advj-asdlfjoeKAasdjflkekalskldjkcvras-s"
    );

    const userId = decoded.sub._id;

    const organizationFound = await Organization.findOne({ userId });

    if (!organizationFound) {
      return res.status(404).json({ error: "Organization not found" });
    }

    const { title, postType, content, videoUrl } = req.body;

    const newPost = new Post({
      organizationId: organizationFound._id,
      title,
      postType,
      content,
      videoUrl,
      createdAt: new Date(),
    });

    const savedPost = await newPost.save();

    res.status(200).json(savedPost);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not create post" });
  }
};

// Update a post by ID
exports.updatePost = async (req, res) => {
  try {
    const { id } = req.params;
    const { title, content } = req.body;

    const updatedPost = await Post.findByIdAndUpdate(
      id,
      { title, content },
      { new: true }
    );

    if (!updatedPost) {
      return res.status(404).json({ error: "Post not found" });
    }

    res.status(200).json(updatedPost);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not update post" });
  }
};

// Get all posts
exports.getAllPosts = async (req, res) => {
  try {
    const userId = jwt.verify(
      req.headers.authorization.split(" ")[1],
      "Advj-asdlfjoeKAasdjflkekalskldjkcvras-s"
    ).sub._id;

    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const skip = (page - 1) * limit;

    const favorites = await Favorite.find({ userId });
    const organizationIds = favorites.map(
      (favorite) => favorite.organizationId
    );

    const organizations = await Organization.find({
      _id: { $in: organizationIds },
    });
    const allTagsArray = [
      ...organizations.flatMap((org) => org.tags),
      ...(await User.findById(userId, "tags")).tags,
    ];

    const taggedOrganizations = await Organization.find({
      tags: { $in: allTagsArray },
    });

    const taggedOrganizationIds = taggedOrganizations.map((org) => org._id);


    const posts = await Post.find({
      $or: [
        { organizationId: { $in: organizationIds } },
        { organizationId: { $in: taggedOrganizationIds } },
        { organizationId: userId },
      ],
    })
      .skip(skip)
      .limit(limit);

    if (!posts.length)
      return res.status(200).json({ message: "No more posts available" });

    const allOrganizations = [...organizations, ...taggedOrganizations];
    const postsWithOrganizationInfo = posts.map((post) => {
      const organization = allOrganizations.find(
        (org) => org._id.toString() === post.organizationId.toString()
      );
      return { ...post._doc, organization };
    });

    res.status(200).json(postsWithOrganizationInfo);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not fetch posts" });
  }
};

// Get a post by ID
exports.getPostById = async (req, res) => {
  const { id } = req.params;
  try {
    const Post = await Post.findById(id);

    if (!Post) {
      return res.status(404).json({ error: "Post not found" });
    }

    res.status(200).json(Post);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not fetch post" });
  }
};

// Delete a post by ID
exports.deletePost = async (req, res) => {
  try {
    const { id } = req.params;

    const deletedPost = await Post.findByIdAndRemove(id);

    if (!deletedPost) {
      return res.status(404).json({ error: "Post not found" });
    }

    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not delete post" });
  }
};
