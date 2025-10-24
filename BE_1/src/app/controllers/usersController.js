const dbPromise = require("../../config/db");
const UserRole = require("../../constants/UserRole");
const bcrypt = require("bcrypt");
const saltRounds = 10;
const jwt = require("jsonwebtoken");

const getAllUsers = async function (req, res) {
    try {
        const db = await dbPromise;
        const [data] = await db.query(`Select *
                                       from users where role = 0`);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: "No users found"
            });
        }
        res.status(200).send({
            success: true,
            message: "Users found",
            data: data
        });
    } catch (err) {
        console.log(err);
        res.status(500).send({
            success: false,
            message: "Something went wrong with get all users api."
        });
    }
}
const getAllEmployee = async function (req, res) {
    try {
        const db = await dbPromise;
        const [data] = await db.query(`Select *
                                       from users
                                       where role = ? and is_delete = 0`, [1]);
        if (data.length === 0) {
            return res.status(404).send({
                success: false,
                message: "No users found"
            });
        }
        res.status(200).send({
            success: true,
            message: "Users found",
            data: data
        });
    } catch (err) {
        console.log(err);
        res.status(500).send({
            success: false,
            message: "Something went wrong with get all users api."
        });
    }
}

const getUserById = async function (req, res) {
    try {
        const userId = req.params.id;
        if (!userId) {
            return res.status(400).send({
                success: false,
                message: "No user id provided"
            });
        }
        const db = await dbPromise;
        const [user] = await db.query(`Select id,
                                              ho,
                                              ten,
                                              email,
                                              role,
                                              avata,
                                              phone,
                                              diachi,
                                              congty
                                       from users
                                       where id = ${userId}
                                         and is_delete = 0`);
        if (user.length === 0) {
            return res.status(404).send({
                success: false,
                message: "No users found"
            });
        }
        res.status(200).send({
            success: true,
            message: "Users found",
            data: user
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with get users by id api."
        })
    }
}

const registerUser = async function (req, res) {
    try {
        const {email, password, ho, ten, congty, diachi, phone ,role} = req.body;
        if (!email || !password) {
            return res.status(400).send({
                success: false,
                message: "Cần cung cấp email và mật khẩu"
            });
        }
        const db = await dbPromise;
        const [check] = await db.query(`Select email
                                        from users
                                        where email = ?`, [email]);
        if (check.length === 1) {
            return res.status(400).send({
                success: false,
                message: "Email đã tồn tại"
            });
        }
        bcrypt.hash(password, saltRounds, async function (err, hash) {
            const [result] = await db.query(`Insert into users (email, password, role, ho, ten, congty, diachi, phone, created_at)
                                             values (?, ?, ?, ?, ?, ?, ?, ?, NOW())`, [email, hash, role, ho, ten, congty, diachi, phone]);
            if (result.affectedRows === 0) {
                return res.status(404).send({
                    success: false,
                    message: "No users create"
                });
            }
        });
        res.status(200).send({
            success: true,
            message: "Users created successfully",
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with create users api."
        });
    }
}

const updateUser = async function (req, res) {
    try {
        const userId = req.params.id;
        if (!userId) {
            return res.status(400).send({
                success: false,
                message: "No user id provided"
            });
        }
        const keys = Object.keys(req.body);
        const values = Object.values(req.body);
        if (keys.length === 0) return res.status(400).send({
            success: false,
            message: "No fields to update"
        });
        const setClause = keys.map(function (key) {
            return key + " = ?";
        }).join(', ');
        console.log(setClause);
        console.log(values)
        const db = await dbPromise;
        const [result] = await db.query(`Update users
                                         set ${setClause}                                            
                                         where id = ${userId}`, [...values]);
        if (result.affectedRows === 0) {
            return res.status(404).send({
                success: false,
                message: "No existing users with this id"
            });
        }
        res.status(200).send({
            success: true,
            message: "User updated successfully",
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with update users by id api."
        })
    }
}

const deleteUser = async function (req, res) {
    try {
        const userId = req.params.id;
        if (!userId) {
            return res.status(400).send({
                success: false,
                message: "No user id provided"
            });
        }
        const db = await dbPromise;
        const [result] = await db.query(`Update users
                                         set is_delete  = ?,
                                             deleted_at = NOW()
                                         where id = ?
                                           and is_delete = 0`, [1, userId]);
        if (result.affectedRows === 0) {
            return res.status(404).send({
                success: false,
                message: "users has been deleted",
            });
        }
        res.status(200).send({
            success: true,
            message: "User deleted successfully",
        });
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with delete users by id api."
        });
    }
}

const handleLogin = async function (req, res) {
    try {
        const {email, password} = req.body;
        if (!email || !password) {
            return res.status(400).send({
                success: false,
                message: "Cần cung cấp cả email và mật khẩu"
            });
        }
        const db = await dbPromise;
        const [user] = await db.query(`Select id, email, role, avata, phone, password
                                       from users
                                       where email = ?`, [email]);
        if (user.length === 0) {
            return res.status(400).send({
                success: false,
                message: "Email hoặc mật khẩu không đúng"
            });
        }

        const token = jwt.sign(
            {
                id: user[0].id,

            },
            process.env.JWT_SECRET,
            {
                expiresIn: process.env.JWT_EXPIRATION
            }
        )

        const validPassword = await bcrypt.compare(password, user[0].password);
        if (validPassword) {
            return res.status(200).send({
                success: true,
                message: "Đăng nhập thành công",
                token: token
            })
        } else {
            return res.status(400).send({
                success: false,
                message: "Email hoặc mật khẩu không đúng"
            })
        }
    } catch (e) {
        console.log(e);
        res.status(500).send({
            success: false,
            message: "Something went wrong with HandleLogin users api."
        })
    }
}


module.exports = {
    getAllUsers, getUserById, updateUser, registerUser, deleteUser, handleLogin, getAllEmployee
}