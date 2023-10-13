const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  id: mongoose.Schema.Types.ObjectId,
  phoneNumber: String,
  firstName: String,
  lastName: String,
  email: String,
  password: String,
  tags: [mongoose.Schema.Types.ObjectId],
  role: mongoose.Schema.Types.ObjectId,
  createdAt: Date,
});

const User = mongoose.model("User", userSchema, "users");

module.exports = User;
