const dbPromise = require("../../config/db");

const insertOrderDetail = async function (req, res) {
    try {
        const {orderId, id, variant_id, price, oldprice, quantity} = req.body;
        if (!orderId || !id || !price || !quantity || !oldprice) {
            return res.status(400).send({
                success: false,
                message: 'Please fill out the form of the order',
            });
        }
        const db = await dbPromise;
        if (!variant_id) {
            let [check] = await db.query(`Select product_id from orders_details where product_id = ? and order_id = ?`, [id, orderId]);
            if (check.length === 1) {
                let [result] = await db.query(`Update orders_details set quantity = quantity + ? where product_id = ? and order_id = ?`, [quantity, id, orderId]);
                if (result.affectedRows === 0) {
                    return res.status(400).send({
                        success: false,
                        message: 'Lỗi khi thêm sản phẩm đã có sẵn trong giỏ hàng. Product',
                    });
                }
                return res.status(200).send({
                    success: true,
                    message: 'Product already in the cart'
                });
            }
        }
        let [check] = await db.query(`Select variant_id from orders_details where variant_id = ? and order_id = ?`, [variant_id, orderId]);
        if (check.length === 1) {
            let [result] = await db.query(`Update orders_details set quantity = quantity + ? where variant_id = ? and order_id = ?`, [quantity, variant_id, orderId]);
            if (result.affectedRows === 0) {
                return res.status(400).send({
                    success: false,
                    message: 'Lỗi khi thêm sản phẩm đã có trong giỏ hàng. Variant'
                });
            }
            return res.status(200).send({
                success: true,
                message: 'Variant already in the cart'
            });
        }
        const [result] = await db.query(`Insert into orders_details (order_id, product_id, variant_id, price, oldprice, quantity, created_at)
                                         VALUES (?, ?, ?, ?, ?, ?, NOW())`, [orderId, id, variant_id, price, oldprice, quantity]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: "Something went wrong with create orders_details",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully created Order_Details",
        });
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with create orders_details api"
        });
    }
}

const getOrderDetailsByUserId = async function (req, res) {
    try {
        const status = 3; // Trạng thái giỏ hàng
        const userId = req.params.id;
        if (!userId) {
            return res.status(400).send({
                success: false,
                message: "Please provide a userId",
            });
        }
        const db = await dbPromise;
        const [data] = await db.query(`SELECT od.id   AS order_detail_id,
                                              od.quantity,
                                              od.price,
                                              od.oldprice,
                                              p.id    AS product_id,
                                              p.name  AS product_name,
                                              p.image AS product_image,
                                              v.id    AS variant_id,
                                              v.ram,
                                              v.storage,
                                              v.cpu,
                                              v.vga,
                                              v.monitor,
                                              o.id    AS order_id
                                       FROM orders_details od
                                                JOIN orders o ON od.order_id = o.id
                                                JOIN products p ON od.product_id = p.id
                                                LEFT JOIN products_variants v ON od.variant_id = v.id
                                       WHERE o.user_id = ? AND o.status = ?
                                       ORDER BY od.created_at DESC;`, [userId, status]);
        if (data.length === 0) {
            return res.status(204).send({
                success: true,
                message: "Giỏ hàng trống",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully getting orders details",
            data: data
        });
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with getting orders details api",
        });
    }
}

const getOrderDetailsByOrderID = async function (req, res) {
    try {
        const status = 0; // Trạng thái giỏ hàng
        const orderId = req.params.id;
        if (!orderId) {
            return res.status(400).send({
                success: false,
                message: "Please provide a userId",
            });
        }
        const db = await dbPromise;
        const [data] = await db.query(`SELECT od.id   AS order_detail_id,
                                              od.quantity,
                                              od.price,
                                              od.oldprice,
                                              p.id    AS product_id,
                                              p.name  AS product_name,
                                              p.image AS product_image,
                                              v.id    AS variant_id,
                                              v.ram,
                                              v.storage,
                                              v.cpu,
                                              v.vga,
                                              v.monitor,
                                              o.id    AS order_id
                                       FROM orders_details od
                                                JOIN orders o ON od.order_id = o.id
                                                JOIN products p ON od.product_id = p.id
                                                LEFT JOIN products_variants v ON od.variant_id = v.id
                                       WHERE o.id = ?
                                       ORDER BY od.created_at DESC;`, [orderId]);
        if (data.length === 0) {
            return res.status(204).send({
                success: true,
                message: "Giỏ hàng trống",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully getting orders details",
            data: data
        });
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with getting orders details api",
        });
    }
}

const updateOrderDetails = async function (req, res) {
    try {
        const ODs_id = req.params.id;
        const {quantity} = req.body;
        if (!ODs_id) {
            return res.status(400).send({
                success: false,
                message: "Please provide a order_id",
            });
        }
        const db = await dbPromise;
        const [result] = await db.query(`Update orders_details
                                         set quantity = quantity + ?
                                         where id = ?`, [quantity, ODs_id]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: "No existing orders_details with this id",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully updated order",
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with update orders_details api",
        });
    }
}

const updateOrderDetailsForAD = async function (req, res) {
    try {
        const ODs_id = req.params.id;
        const {quantity} = req.body;
        if (!ODs_id) {
            return res.status(400).send({
                success: false,
                message: "Please provide a order_id",
            });
        }
        const db = await dbPromise;
        const [result] = await db.query(`Update orders_details
                                         set quantity = ?
                                         where id = ?`, [quantity, ODs_id]);
        if (result.affectedRows === 0) {
            return res.status(400).send({
                success: false,
                message: "No existing orders_details with this id",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully updated order",
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with update orders_details api",
        });
    }
}

const deleteOrderDetails = async function (req, res) {
    try {
        const Ods_id = req.params.id;
        if (!Ods_id) {
            return res.status(400).send({
                success: false,
                message: "Please provide a Ods_id",
            });
        }
        const db = await dbPromise;
        const [result] = await db.query(`Delete
                                         from orders_details
                                         where id = ${Ods_id}`);
        if (result.affectedRows === 0) {
            return res.status(404).send({
                success: false,
                message: "No existing orders_details with this id",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully deleted order",
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with delete order api",
        })
    }
}

module.exports = {
    insertOrderDetail, getOrderDetailsByUserId, updateOrderDetails, deleteOrderDetails, getOrderDetailsByOrderID, updateOrderDetailsForAD
};