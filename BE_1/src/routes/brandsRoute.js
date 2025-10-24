const brandsController = require("../app/controllers/brandsController");
const jwtMiddleware = require("../middlewares/jwtMiddleware");
const userRole = require("../constants/UserRole");

function getBrands (app) {
    app.get("/api/brands/get-all", brandsController.getAllBrands);
    app.get("/api/brands/get-by-id/:id", brandsController.getBrandById);
    app.post("/api/brands/create", brandsController.createBrand);
    app.patch("/api/brands/update/:id", brandsController.updateBrand);
    app.delete("/api/brands/delete/:id", brandsController.deleteBrand);
}

module.exports = getBrands;