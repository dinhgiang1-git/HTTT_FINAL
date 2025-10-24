const dbPromise = require("../../config/db");
const e = require("express");

const getAllCategories = async function (req, res) {
    try {
        const db = await dbPromise;
        const [data] = await db.query(`SELECT *
                                       FROM categories`);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: 'No data categories.'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully retrieved categories.',
            data: data
        });
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Error getting categories api"
        });
    }
}

const getCategoryById = async function (req, res) {
    try {
        const categoryId = req.params.id;
        if (!categoryId) {
            return res.status(400).send({
                success: false,
                message: 'No category id provide.'
            });
        }
        const db = await dbPromise;
        const [data] = await db.query(`Select *
                                       from categories
                                       where id = ${categoryId}`);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: 'No data categories found with id .'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully retrieved categories by id.',
            data: data
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Error getting categories api"
        })
    }
}

const createCategory = async function (req, res) {
    try {
        const {name} = req.body;
        if (!name) {
            return res.status(400).send({
                success: false,
                message: 'No field update.'
            })
        }
        const db = await dbPromise;
        const [result] = await db.query(`Insert into categories (name)
                                         values (?)`, [name]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: 'Error in creating categories.'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully insert record into categories.',
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Error creating categories api."
        });
    }
}

const updateCategory = async function (req, res) {
    try {
        const categoryId = req.params.id;
        if (!categoryId) {
            return res.status(400).send({
                success: false,
                message: 'No category id provide.'
            });
        }
        const keys = Object.keys(req.body);
        const values = Object.values(req.body);
        if (keys.length === 0) {ß
            return res.status(400).send({
                success: false,
                message: 'No field provide to update.'
            });
        }
        const setCaluse = keys.map(function (key) {
            return key + " = ?";
        }).join(',');

        const db = await dbPromise;
        const [result] = await db.query(`Update categories
                                         set ${setCaluse}
                                         WHERE id = ${categoryId}`, [...values]);
        if (result.affectedRows === 0) {
            return res.status(404).send({
                success: false,
                message: 'No brand exists with id .'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully updated categories.'
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Error updating categories api"
        });
    }
}

const deleteCategory = async function (req, res) {
    try {
        const categoryId = req.params.id;
        if (!categoryId) {
            return res.status(400).send({
                success: false,
                message: 'No category id provide.'
            });
        }
        const db = await dbPromise;
        const [result] = await db.query(`Delete from categories where id = ${categoryId}`);
        if (result.affectedRows === 0) {
            return res.status(404).send({
                success: false,
                message: 'No data categories found with id .'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully deleted categories.'
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Error deleting categories api"
        })
    }
}

module.exports = {
    getAllCategories, getCategoryById, createCategory, updateCategory, deleteCategory
}