const dbPromise = require("../../config/db");

const getAllBrands = async function (req, res) {
    try {
        const db = await dbPromise;
        const [data] = await db.query(`Select id, name, image
                                       from brands`);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: 'No brands found.'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully get all brands.',
            data: data
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: 'Error while getting all brands api.'
        });
    }
}

const getBrandById = async function (req, res) {
    try {
        const brandId = req.params.id;
        if (!brandId) {
            return res.status(400).send({
                success: false,
                message: 'No id brand provide.'
            })
        }
        const db = await dbPromise;
        const [data] = await db.query(`Select id, name, image
                                       from brands
                                       where id = ?`, [brandId]);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: 'No brand found.'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully get brand by id.',
            data: data
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: 'Error while getting brand by id api.'
        });
    }
}

const createBrand = async function (req, res) {
    try {
        const {name, image} = req.body;
        const db = await dbPromise;
        const [result] = await db.query(`Insert into brands(name, image)
                                         values (?, ?)`, [name, image]);
        if (result.length === 0) {
            return res.status(400).send({
                success: false,
                message: 'Error while creating brand.'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully create a new brand.'
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: 'Error while creating brand api.'
        })
    }
}

const updateBrand = async function (req, res) {
    try {
        const brandId = req.params.id;
        if (!brandId) {
            return res.status(400).send({
                success: false,
                message: 'No id brand provide.'
            });
        }
        const field = req.body;
        const {name} = req.body;
        const keys = Object.keys(field);
        const values = Object.values(field);
        if (keys.length === 0) {
            return res.status(400).send({
                success: false,
                message: 'No fields to update.'
            });
        }
        const setClause = keys.map(function (key) {
            return key + " = ?";
        }).join(', ');

        const db = await dbPromise;
        const [result] = await db.query(`Update brands
                                         set name = ?                                       
                                         WHERE id = ?`, [name, brandId]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: 'No existing brand with this id.'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully updated brand.'
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: 'Error while updating brand api.'
        });
    }
}

const deleteBrand = async function (req, res) {
    try {
        const brandId = req.params.id;
        if (!brandId) {
            return res.status(400).send({
                success: false,
                message: 'No id brand provide.'
            });
        }
        const db = await dbPromise;
        const [result] = await db.query(`Delete
                                         from brands
                                         where id = ${brandId}`);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: 'No existing brand with this id.'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully deleted brand.',
            data: result
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: 'Error while deleting brand api.'
        });
    }
}

module.exports = {
    getAllBrands, getBrandById, updateBrand, createBrand, deleteBrand
}