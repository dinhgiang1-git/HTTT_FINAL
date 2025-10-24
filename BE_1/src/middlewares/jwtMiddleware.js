const dbPromise = require("../config/db");
const jwt = require("jsonwebtoken");

const requireRole = (requiredRoles) => async (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        if(!token) return res.status(401).send({
            success: false,
            message: 'Token không được cung cấp'
        });

        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const db = await dbPromise;
        const [user] = await db.query('Select role, is_delete from users where id = ?', [decoded.id])
        if (user.length === 0) {
            return res.status(404).send({
                success: false,
                message: 'Người dùng không tồn tại'
            });
        }
        if (user[0].is_delete === 1) {
            return res.status(401).send({
                success: false,
                message: "Người dùng đã bị xóa"
            });
        }
        const rolesArray = Array.isArray(requiredRoles) ? requiredRoles : [requiredRoles];
        if(!rolesArray.includes(user[0].role)) {
            return res.status(403).send({
                success: false,
                message: "Không có quyền truy cập"
            });
        }
        next();
    } catch (error) {
        console.log(error)
        res.status(401).send({
            success: false,
            message: "Token không hợp lệ hoặc đã hết hạn",
        });
    }
}

module.exports = requireRole;