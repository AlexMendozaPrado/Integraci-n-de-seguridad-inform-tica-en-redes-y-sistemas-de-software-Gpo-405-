const mongoose = require("mongoose");

const postSchema = new mongoose.Schema({
  id: mongoose.Schema.Types.ObjectId,
  organizationId: mongoose.Schema.Types.ObjectId,
  title: String,
  postType: mongoose.Schema.Types.ObjectId,
  content: String,
  filesIds: [mongoose.Schema.Types.ObjectId],
  createdAt: Date,
});

const Post = mongoose.model("Post", postSchema, "posts");

module.exports = Post;
