const User = require("../models/userModel");
const Organization = require("../models/organizationModel");
const { hashPassword } = require("../services/passwordService");

exports.createOrganization = async (req, res) => {
    try {
        const {
            email,
            phoneNumber
        } = req.body.contact

        const {
            name,
            description,
            password,
            logoUrl,
            address,
            contact,
            socialNetworks,
            tags,
            role
        } = req.body;

        const hashedPassword = await hashPassword(password);
        const newUser = new User({
            firstName: name,
            lastName: "",
            email,
            phoneNumber,
            password: hashedPassword,
            tags,
            role,
        });

        const savedUser = await newUser.save();

        const newOrganization = new Organization({
            userId: savedUser['_id'],
            name,
            address,
            contact,
            description,
            socialNetworks,
            logoUrl,
            tags,
            createdAt: new Date(),
            updatedAt: new Date()
        });

        const savedOrganization = await newOrganization.save();

        return res.status(200).json(savedOrganization);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: "Could not create organization" });
    }
};

// Get all organizations
exports.getAllOrganizations = async (req, res) => {
    try {
        // filters
        const { tags } = req.query;

        const organizations = await Organization.find({ tags: { $in: tags } });

        return res.status(200).json(organizations);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: "Could not fetch organizations" });
    }
};

// Get a organization by ID
exports.getOrganizationById = async (req, res) => {
  const { id } = req.params;
  try {
    const organization = await Organization.findById(id);

    if (!organization) {
      return res.status(404).json({ error: "Organization not found" });
    }

    res.status(200).json(organization);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: "Could not fetch organization" });
  }
};

// Update a organization by ID
exports.updateOrganization = async (req, res) => {
    try {
        const { id } = req.params;
        const {
            name,
            description,
            logoUrl,
            address,
            contact,
            socialNetworks,
            tags
        } = req.body;

        const updatedOrganization = await Organization.findByIdAndUpdate(
            id,
            { name, description, logoUrl, address, contact, socialNetworks, tags },
            { new: true }
        );

        if (!updatedOrganization) {
            return res.status(404).json({ error: "Organization not found" });
        }

        return res.status(200).json(updatedOrganization);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: "Could not update organization" });
    }
};

// Delete a organization by ID
exports.deleteOrganization = async (req, res) => {
    try {
        const { id } = req.params;

        const deletedorganization = await Organization.findByIdAndRemove(id);

        if (!deletedorganization) {
        return res.status(404).json({ error: "Organization not found" });
        }

        res.status(204).send();
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: "Could not delete organization" });
    }
};
