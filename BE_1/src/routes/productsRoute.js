const productsController = require('../app/controllers/productsController');
const UserRole = require('../constants/UserRole');
const JwtMiddleWare = require('../middlewares/jwtMiddleware');

function getProducts(app) {
    app.get('/api/products/get-all', productsController.getAllProducts);
    app.get('/api/products/get-by-id/:id', productsController.getProductById);

    app.get('/api/products/collections-spotlight/:slug', productsController.getSpotlightCollectionsProducts);
    app.get('/api/products/collections/:slug', productsController.getCollectionsProducts);

    app.get('/api/products/getProductsPurchaseByUserId/:id', productsController.getProductsPurchaseByUserId);
    app.get('/api/products/search', productsController.searchProducts);

    app.post('/api/products/create', productsController.createProduct);
    app.post('/api/variants/create', productsController.createVariant);
    app.patch('/api/products/update/:id', productsController.updateProduct);
    app.patch('/api/variant/update/:id', productsController.updateVariant);
    app.delete('/api/products/delete/:id', productsController.deleteProduct);
    app.delete('/api/variant/delete/:id', productsController.deleteVariant);

}

module.exports = getProducts;