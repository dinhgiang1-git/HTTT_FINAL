const dbPromise = require('../../config/db');

const getAllProducts = async function (req, res) {
    try {
        const db = await dbPromise;
        const [data] = await db.query(`SELECT products.id,
                                              products.name,
                                              products.image,
                                              products.description,
                                              products.buyturn,
                                              products.quantity,
                                              products.created_at,
                                              categories.name as categories_name,
                                              brands.name     as brands_name
                                       from products
                                                join categories on categories.id = products.category_id
                                                join brands on brands.id = products.brand_id
                                       where is_delete = ?`, [0]);
        if (!data) {
            res.status(404).send({
                success: false,
                message: 'No products'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully found all product',
            data: data
        });
    } catch (e) {
        console.error(e)
        res.status(500).send({
            success: false,
            message: 'Error in getAllProducts api',
            error: e
        });
    }
}

const getProductById = async function (req, res) {
    try {
        const productId = req.params.id;
        if (!productId) {
            res.status(400).send({
                success: false,
                message: 'User id is missing'
            })
        }
        const db = await dbPromise;
        //Lấy ra biến thể nhỏ nhất
        const [data] = await db.query(`SELECT p.id,
                                              p.name,
                                              p.image,
                                              p.description,
                                              b.name AS thuonghieu,
                                              v.id   AS variant_id,
                                              v.price,
                                              v.oldprice,
                                              v.color,
                                              v.quantity,
                                              v.ram,
                                              v.storage,
                                              v.cpu,
                                              v.vga,
                                              v.monitor
                                       FROM products p
                                                JOIN brands b ON p.brand_id = b.id
                                                JOIN products_variants v ON p.id = v.product_id
                                       WHERE p.id = ?
                                         AND v.is_delete = ?
                                       ORDER BY v.price ASC;`, [productId, 0]);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: 'No products found with this id'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully found product',
            data: data
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: 'Error in getProductById api',
            error: e
        });
    }
}

const createProduct = async function (req, res) {
    try {
        const {name, image, description, quantity, brand_id, category_id} = req.body;
        const db = await dbPromise;
        const [result] = await db.query("" +
            "Insert into products (name, image, description, quantity, brand_id, category_id, created_at)" +
            " values (?, ?, ?, ?, ?, ?, NOW())", [name, image, description, quantity, brand_id, category_id]);
        if (!result) {
            res.status(400).send({
                success: false,
                message: 'Error in createProduct',
            })
        }
        res.status(200).send({
            success: true,
            message: 'Successfully created product',
        })
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: 'Error in createProduct api',
        })
    }
}
const createVariant = async function (req, res) {
    try {
        const {product_id, price, oldprice, quantity, color, ram, storage, cpu, vga, monitor} = req.body;
        const db = await dbPromise;
        const [result] = await db.query("" +
            "Insert into products_variants (product_id, price, oldprice, quantity, color, ram, storage, cpu, vga, monitor, created_at)" +
            " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())", [product_id, price, oldprice, quantity, color, ram, storage, cpu, vga, monitor]);
        if (!result) {
            res.status(400).send({
                success: false,
                message: 'Error in createVariant',
            })
        }
        res.status(200).send({
            success: true,
            message: 'Successfully createVariant',
        })
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: 'Error in createVariant api',
        })
    }
}

const updateProduct = async function (req, res) {
    try {
        const productId = req.params.id;
        if (!productId) {
            return res.status(400).send({
                success: false,
                message: 'Products id is missing'
            })
        }
        const field = req.body;
        const keys = Object.keys(field);
        const values = Object.values(field);
        if (keys.length === 0) {
            return res.status(400).send({
                success: false,
                message: 'No fields to update'
            })
        }
        const setClause = keys.map(function (key) {
            return key + " = ?";
        }).join(', ');
        const db = await dbPromise;
        const [result] = await db.query(`Update products
                                         SET ${setClause},
                                             updated_at = NOW()
                                         WHERE id = ?`, [...values, productId]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: 'No existing product with this id.',
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully updated product',
        });
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: 'Error in updateProduct api',
        })
    }
}
const updateVariant = async function (req, res) {
    try {
        const variantId = req.params.id;
        if (!variantId) {
            return res.status(400).send({
                success: false,
                message: 'Variant id is missing'
            })
        }
        const field = req.body;
        const keys = Object.keys(field);
        const values = Object.values(field);
        if (keys.length === 0) {
            return res.status(400).send({
                success: false,
                message: 'No fields to update'
            })
        }
        const setClause = keys.map(function (key) {
            return key + " = ?";
        }).join(', ');
        const db = await dbPromise;
        const [result] = await db.query(`Update products_variants
                                         SET ${setClause},
                                             updated_at = NOW()
                                         WHERE id = ?`, [...values, variantId]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: 'No existing Variant with this id.',
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully updated Variant',
        });
    } catch (e) {
        res.status(500).send({
            success: false,
            message: e.message,
        })
    }
}

const deleteProduct = async function (req, res) {
    try {
        const productId = req.params.id;
        if (!productId) {
            return res.status(400).send({
                success: false,
                message: 'Product id is missing'
            })
        }
        const db = await dbPromise;
        const [result] = await db.query(`Update products
                                         set is_delete  = ?,
                                             deleted_at = NOW()
                                         WHERE id = ?`, [1, productId]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: 'No existing product with this id',
            })
        }
        res.status(200).send({
            success: true,
            message: 'Successfully deleted product',
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: 'Error in deleteProduct api',
        });
    }
}
const deleteVariant = async function (req, res) {
    try {
        const variantId = req.params.id;
        if (!variantId) {
            return res.status(400).send({
                success: false,
                message: 'Product id is missing'
            })
        }
        const db = await dbPromise;
        const [result] = await db.query(`Delete
                                         from products_variants
                                         WHERE id = ?`, [variantId]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: 'No existing variant with this id',
            })
        }
        res.status(200).send({
            success: true,
            message: 'Successfully deleted variant',
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: 'Error in variant api',
        });
    }
}

const getSpotlightCollectionsProducts = async (req, res) => {
    try {
        const slug = req.params.slug;
        if (!slug) {
            return res.status(400).send({
                success: false,
                message: 'Không cung cấp slug'
            });
        }
        let slugId = null;
        let clauseQuery = 'p.category_id = ?';
        switch (slug) {
            case 'spotlights':
                slugId = 1;
                clauseQuery = 'p.is_spotlight = ?';
                break;
            case 'gaming':
                slugId = 1;
                break;
            case 'vanphong':
                slugId = 2;
                break;
            case 'workstation':
                slugId = 4;
                break;
            default:
                slugId = null;
                break;
        }
        const db = await dbPromise;
        const [data] = await db.query(`
            SELECT p.id,
                   p.name,
                   p.image,
                   p.description,
                   b.name                   AS thuonghieu,
                   v.id                     as variant_id,
                   v.price,
                   v.oldprice,
                   v.quantity,
                   v.ram,
                   v.storage,
                   v.cpu,
                   v.vga,
                   v.monitor,
                   (SELECT COUNT(*)
                    FROM products_variants v2
                    WHERE v2.product_id = p.id
                      AND v2.is_delete = 0) AS total_variants
            FROM products p
                     JOIN brands b ON p.brand_id = b.id
                     JOIN products_variants v
                          ON v.id = (SELECT v2.id
                                     FROM products_variants v2
                                     WHERE v2.product_id = p.id
                                       AND v2.is_delete = 0
                                     ORDER BY v2.price ASC LIMIT 1)
            WHERE ${clauseQuery}
                LIMIT 5;`, [slugId]);
        if (data.length === 0) {
            return res.status(400).send({
                success: false,
                message: 'Không có sản phẩm nổi bật nào',
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully getting Spotlight products',
            data: data
        });
    } catch (e) {
        res.status(500).send({
            success: false,
            message: 'Error in getSpotlightProducts api',
        })
    }
}

const getCollectionsProducts = async (req, res) => {
    try {
        const slug = req.params.slug;
        if (!slug) {
            return res.status(400).send({
                success: false,
                message: 'Không cung cấp slug',
            });
        }
        let slugId = 0;
        let clauseQuery = 'p.category_id = ?';
        switch (slug) {
            case 'laptop-gaming':
                slugId = 1;
                break;
            case 'laptop-vanphong':
                slugId = 2;
                break;
            case 'laptop-workstation':
                slugId = 4;
                break;
            case 'macbook':
                slugId = 4;
                ``
                break;
            case 'spotlights':
                slugId = 1;
                clauseQuery = 'p.is_spotlight = ?';
                break;
            default:
                slugId = 0;
                break;
        }
        const db = await dbPromise;
        const [data] = await db.query(`
            SELECT p.id,
                   p.name,
                   p.image,
                   p.description,
                   p.created_at,
                   p.buyturn,
                   b.name                   AS thuonghieu,
                   v.id                     as variant_id,
                   v.price,
                   v.oldprice,
                   v.quantity,
                   v.ram,
                   v.storage,
                   v.cpu,
                   v.vga,
                   v.monitor,
                   (SELECT COUNT(*)
                    FROM products_variants v2
                    WHERE v2.product_id = p.id
                      AND v2.is_delete = 0) AS total_variants
            FROM products p
                     JOIN brands b ON p.brand_id = b.id
                     JOIN products_variants v
                          ON v.id = (SELECT v2.id
                                     FROM products_variants v2
                                     WHERE v2.product_id = p.id
                                       AND v2.is_delete = 0
                                     ORDER BY v2.price ASC LIMIT 1)
            WHERE ${clauseQuery};`, [slugId]);
        if (data.length === 0) {
            return res.status(400).send({
                success: false,
                message: 'Không có sản phẩm collections nào',
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully getting collections products',
            data: data
        });
    } catch (e) {
        res.status(500).send({
            success: false,
            message: 'Error in get collections api',
        })
    }
}

const getProductsPurchaseByUserId = async (req, res) => {
    try {
        const userId = req.params.id;
        if (!userId) {
            return res.status(400).send({
                success: false,
                message: 'Không cung cấp userId'
            });
        }
        const db = await dbPromise;
        const [data] = await db.query(`SELECT o.id                    AS order_id,
                                              o.status,
                                              o.updated_at,
                                              o.total                 AS order_total,
                                              od.id                   AS order_detail_id,
                                              od.quantity,
                                              p.id                    AS product_id,
                                              p.name                  AS product_name,
                                              p.image                 AS product_image,
                                              v.id                    AS variant_id,
                                              v.ram,
                                              v.cpu,
                                              v.vga,
                                              v.monitor,
                                              v.price,
                                              v.storage,
                                              (od.quantity * v.price) AS total_price
                                       FROM orders o
                                                JOIN orders_details od ON o.id = od.order_id
                                                JOIN products_variants v ON od.variant_id = v.id
                                                JOIN products p ON v.product_id = p.id
                                       WHERE o.user_id = ?
                                         AND o.status IN (0, 1)
                                       ORDER BY o.created_at DESC;`, [userId]);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: 'Không có sản phẩm nào được mua bởi người dùng này'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully getting products purchase',
            data: data
        });
    } catch (e) {
        return res.status(500).send({
            success: false,
            message: 'Error in getProductsPurchase API',
        });
    }
}

const searchProducts = async function (req, res) {
    try {
        const keyword = req.query.query;
        if (!keyword) {
            return res.status(400).send({
                success: false,
                message: 'Không cung cấp keyword search'
            });
        }
        const db = await dbPromise;
        const [data] = await db.query(`SELECT p.id,
                                              p.name,
                                              p.image,
                                              p.description,
                                              b.name                   AS thuonghieu,
                                              v.id                     AS variant_id,
                                              v.price,
                                              v.oldprice,
                                              v.quantity,
                                              v.ram,
                                              v.storage,
                                              v.cpu,
                                              v.vga,
                                              v.monitor,
                                              (SELECT COUNT(*)
                                               FROM products_variants v2
                                               WHERE v2.product_id = p.id
                                                 AND v2.is_delete = 0) AS total_variants
                                       FROM products p
                                                JOIN brands b ON p.brand_id = b.id
                                                JOIN products_variants v ON v.product_id = p.id
                                                JOIN (SELECT product_id, MIN(price) AS min_price
                                                      FROM products_variants
                                                      WHERE is_delete = 0
                                                      GROUP BY product_id) cv
                                                     ON cv.product_id = p.id AND v.price = cv.min_price
                                       WHERE p.name LIKE CONCAT('%', ?, '%');`, [keyword]);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: 'Không tìm thấy sản phẩm nào'
            });
        }
        res.status(200).send({
            success: true,
            message: 'Successfully getting search product',
            data: data
        })
    } catch (e) {
        res.status(500).send({
            success: false,
            message: 'Error in search products API',
            error: e
        });
    }
}

module.exports = {
    getAllProducts,
    getProductById,
    createProduct,
    updateProduct,
    deleteProduct,
    getSpotlightCollectionsProducts,
    getCollectionsProducts,
    getProductsPurchaseByUserId,
    searchProducts,
    updateVariant,
    deleteVariant,
    createVariant,
}