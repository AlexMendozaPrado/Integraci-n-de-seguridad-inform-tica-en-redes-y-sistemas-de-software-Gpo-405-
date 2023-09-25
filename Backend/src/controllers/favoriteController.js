const Favorite = require("../models/favoriteModel");

exports.createFavorite = async (req, res) => {
  try {
    const { organizationId, userId } = req.body;

    const newFavorite = new Favorite({
      organizationId,
      userId,
      createdAt: new Date(),
    });

    const savedFavorite = await newFavorite.save();

    res.status(200).json(savedFavorite);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not create favorite" });
  }
};

// Get all favorites
exports.getAllFavorites = async (req, res) => {
  try {
    const favorites = await Favorite.find();

    res.status(200).json(favorites);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not fetch favorites" });
  }
};

// Get a favorite by ID
exports.getFavoriteById = async (req, res) => {
  const { id } = req.params;
  try {
    const favorite = await Favorite.findById(id);

    if (!favorite) {
      return res.status(404).json({ error: "Favorite not found" });
    }

    res.status(200).json(favorite);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not fetch favorite" });
  }
};

// Delete a favorite by ID
exports.deleteFavorite = async (req, res) => {
  try {
    const { id } = req.params;

    const deletedfavorite = await Favorite.findByIdAndRemove(id);

    if (!deletedfavorite) {
      return res.status(404).json({ error: "Favorite not found" });
    }

    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Could not delete favorite" });
  }
};
