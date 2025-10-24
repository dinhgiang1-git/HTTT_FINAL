const ordersController = require("../app/controllers/ordersController");
const jwtMiddleware = require("../middlewares/jwtMiddleware");
const UserRole = require("../constants/UserRole");

function ordersRoute(app) {
    app.post("/api/orders/create", ordersController.createOrder);
    app.get("/api/orders/get-all", ordersController.getAllOrder);
    app.get("/api/orders/get-order-by-user-id/:id", ordersController.getOrderByIdUser);
    app.patch("/api/orders/update/:id", ordersController.updateOrder);
}

module.exports = ordersRoute;