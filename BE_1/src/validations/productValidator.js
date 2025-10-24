const {body} = require('express-validator');
const {validationResult} = require('express-validator');

const createProductValidator = [
    body('name').isString().notEmpty().withMessage('Name is required'),
    body('image').isString().notEmpty().withMessage('Image is required'),
    body('price').isFloat({gt: 0}).withMessage('Price must be greater than 0'),
    body('oldprice').isFloat({gt: 0}).withMessage('Old price must be greater than 0'),
    body('description').isString().withMessage('Description is required'),
    body('quantity').isInt({min: 0}).withMessage('Quantity must be >= 0'),
    body('brand_id').isInt().withMessage('Brand id must be integer'),
    body('category_id').isInt().withMessage('Category id must be integer'),
];

// const validate = function(req, res, next) {
//     const errors = validationResult(req);
//     if (!errors.isEmpty()) {
//         return res.status(400).send({errors: errors.array()});
//     }
//     next();
// }

module.exports = createProductValidator;