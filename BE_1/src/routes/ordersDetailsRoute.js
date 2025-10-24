const ordersDetailsController = require("../app/controllers/ordersDetailsController");
const jwtMiddleware = require("../middlewares/jwtMiddleware");
const UserRole = require("../constants/UserRole");

function ordersDetailsRoute (app) {
    app.post("/api/orders_details/create", ordersDetailsController.insertOrderDetail);
    app.get("/api/orders_details/get-od-by-orderId/:id", ordersDetailsController.getOrderDetailsByUserId);
    app.get("/api/orders_details/get-od-by-orderIdd/:id", ordersDetailsController.getOrderDetailsByOrderID);
    app.patch("/api/orders_details/update/:id", ordersDetailsController.updateOrderDetails);
    app.patch("/api/orders_details/updateAD/:id", ordersDetailsController.updateOrderDetailsForAD);
    app.delete("/api/orders_details/delete/:id", ordersDetailsController.deleteOrderDetails);
}

module.exports = ordersDetailsRoute;