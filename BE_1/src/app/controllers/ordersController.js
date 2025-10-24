const dbPromise = require("../../config/db");

const getAllOrder = async (req, res) => {
    try {
        const db = await dbPromise;
        const [data] = await db.query(`SELECT orders.id,
                                              orders.status,
                                              orders.note,
                                              orders.total,
                                              orders.created_at,
                                              orders.updated_at,
                                              users.ho,
                                              users.ten,
                                              users.diachi
                                       FROM orders
                                                JOIN users on users.id = orders.user_id`);
        if (data.length === 0) {
            return res.status(204).send({
                success: false,
                message: "No records found",
                data: data
            });
        }
        res.status(200).send({
            success: true,
            data: data
        });
    } catch (e) {
        res.status(500).send({
            success: false,
            message: e.message,
        });
    }
}

const updateTotalOrder = async (req, res) => {
    try {
        const db = await dbPromise;
        const [result] = await db.query(`UPDATE orders o
                                             JOIN (
                                             SELECT
                                             order_id,
                                             SUM (price * quantity) AS total
                                             FROM order_details
                                             GROUP BY order_id
                                             ) t
                                         ON o.id = t.order_id
                                             SET o.total = t.total;
        `);
        res.status(200).send({
            success: true,
            message: "Successfully updated the total order",
        });
    } catch (e) {
        res.status(500).send({
            success: false,
            message: e.message,
        });
    }
}

const createOrder = async function (req, res) {
    try {
        const {userId} = req.body;
        if (!userId) {
            return res.status(400).send({
                success: false,
                message: "No user id provided"
            });
        }
        const db = await dbPromise;
        const [result] = await db.query(`Insert into orders (user_id, created_at)
                                         values (?, NOW())`, [userId]);
        if (result.affectedRows === 0) {
            return res.status(404).send({
                success: false,
                message: "Something went wrong",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully created order",
        });
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with create order api",
        });
    }
}

const getOrderByIdUser = async function (req, res) {
    // status:
    // 0: Đang giao
    // 1: Đã giao
    // 3: Đang ở giỏ 
    try {
        const userId = req.params.id;
        if (!userId) {
            return res.status(400).send({
                success: false,
                message: "No user id provided"
            });
        }
        const db = await dbPromise;
        const [data] = await db.query(`Select *
                                       from orders
                                       where user_id = ? and status = ?`, [userId, 3]);
        if (data.length === 0) {
            return res.status(204).send({
                success: true,
                message: "Giỏ hàng rỗng!",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully get orders",
            data: data
        })
    } catch (e) {
        console.error(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with getting orders api",
        });
    }
}

const updateOrder = async function (req, res) {
    try {
        const orderId = req.params.id;
        const {status} = req.body;
        console.log(status);
        const keys = Object.keys(req.body);
        const values = Object.values(req.body);
        if (keys.length === 0) return res.status(400).send({
            success: false,
            message: "No field to update order",
        });
        const setClause = keys.map(function (key) {
            return key + " = ?";
        }).join(", ");
        const db = await dbPromise;
        const [result] = await db.query(`Update orders
                                         set status = ?,
                                             updated_at = NOW()
                                         where id = ${orderId}`, [status]);
        if (result.affectedRows === 0) {
            return res.status(404).send({
                success: false,
                message: "No order existing",
            });
        }
        res.status(200).send({
            success: true,
            message: "Successfully updated order",
        })
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with update order api",
        });
    }
}


module.exports = {
    createOrder, getOrderByIdUser, updateOrder, getAllOrder
}