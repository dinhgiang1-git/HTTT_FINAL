const usersController = require("../app/controllers/usersController");
const jwtMiddleware = require("../middlewares/jwtMiddleware");
const userRole = require("../constants/UserRole");

function usersRoute(app) {

    app.get("/api/users/get-by-id/:id", usersController.getUserById);
    app.patch("/api/users/update/:id", usersController.updateUser);

    app.get("/api/users/get-all", usersController.getAllUsers);
    app.get('/api/employee/get-all', usersController.getAllEmployee);
    app.post("/api/users/create", usersController.registerUser);
    app.delete("/api/users/delete/:id", usersController.deleteUser)

    app.post("/auth/login", usersController.handleLogin);
}

module.exports = usersRoute;