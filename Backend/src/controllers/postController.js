const jwt = require("jsonwebtoken");
const Post = require("../models/postModel");
const Favorite = require("../models/favoriteModel");

exports.createPost = async (req, res) => {
  try {
    const { organizationId, title, postType, content, files } = req.body;

    const newPost = new Post({
      organizationId,
      title,
      postType,
      content,
      fileResults: files,
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
    const token = req.headers.authorization.split(" ")[1];
    const decoded = jwt.verify(
      token,
      "Advj-asdlfjoeKAasdjflkekalskldjkcvras-s"
    );
    const userId = decoded.sub._id;

    const favorites = await Favorite.find({ userId });

    const favoritesIds = favorites.map((favorite) => favorite.organizationId);

    const Posts = await Post.find({
      organizationId: { $in: favoritesIds },
    });

    res.status(200).json(Posts);
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
