const categoriesController = require("../app/controllers/categoriesController");

function categoriesRoute(app) {
    app.get("/api/categories/get-all", categoriesController.getAllCategories);
    app.get("/api/categories/get-by-id/:id", categoriesController.getCategoryById);
    app.post("/api/categories/create", categoriesController.createCategory);
    app.patch("/api/categories/update/:id", categoriesController.updateCategory);
    app.delete("/api/categories/delete/:id", categoriesController.deleteCategory);
}

module.exports = categoriesRoute;