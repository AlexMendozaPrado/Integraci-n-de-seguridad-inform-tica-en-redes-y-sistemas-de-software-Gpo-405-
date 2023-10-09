const jwt = require("jsonwebtoken");
const Post = require("../models/postModel");
const Favorite = require("../models/favoriteModel");
const Organization = require("../models/organizationModel");
const File = require("../models/fileModel");

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

    const { title, postType, content } = req.body;
    const files = req.files;

    const filePromises = files.map(async (file) => {
      const fileContentBase64 = file.buffer.toString("base64");

      const newFile = new File({
        organizationId: organizationFound._id,
        name: file.originalname,
        content: fileContentBase64,
        size: file.size,
        type: file.mimetype,
        createdAt: new Date(),
      });

      const savedFile = await newFile.save();
      return savedFile._id;
    });

    const filesIds = await Promise.all(filePromises);

    const newPost = new Post({
      organizationId: organizationFound._id,
      title,
      postType,
      content,
      filesIds,
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
