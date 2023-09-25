const File = require("../models/fileModel");

exports.createFile = async (req, res) => {
  try {
    const { organizationId, name, content } = req.body;

    const newFile = new File({
        organizationId,
        name,
        content,
        size: content.length,
        createdAt: new Date(),
    });

    const savedFile = await newFile.save();

    res.status(200).json(savedFile);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not create file" });
  }
};

// Get all Files
exports.getAllFiles = async (req, res) => {
  try {
    const Files = await File.find();

    res.status(200).json(Files);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not fetch files" });
  }
};

// Get a File by ID
exports.getFileById = async (req, res) => {
  const { id } = req.params;
  try {
    const File = await File.findById(id);

    if (!File) {
      return res.status(404).json({ error: "File not found" });
    }

    res.status(200).json(File);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not fetch file" });
  }
};

// Delete a File by ID
exports.deleteFile = async (req, res) => {
  try {
    const { id } = req.params;

    const deletedFile = await File.findByIdAndRemove(id);

    if (!deletedFile) {
      return res.status(404).json({ error: "File not found" });
    }

    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not delete file" });
  }
};
