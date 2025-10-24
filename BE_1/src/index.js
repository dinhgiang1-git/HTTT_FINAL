const express = require('express');
const app = express();
const port = 3000;
const path = require('path');
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config({
    path: path.join(__dirname, '.env'),
    quiet: true,
});

const productsRoute = require('./routes/productsRoute');
const brandsRoute = require('./routes/brandsRoute');
const categoryRoute = require('./routes/categoriesRoute');
const usersRoute = require('./routes/usersRoute');
const ordersRoute = require('./routes/ordersRoute');
const ordersDetailsRoute = require('./routes/ordersDetailsRoute');

app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.use(cors({
    origin: ['http://localhost:5173', 'http://localhost:5174'],
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

//Static file:
app.use(express.static(path.join(__dirname, 'public')));

//RouteInit:
productsRoute(app);
brandsRoute(app);
categoryRoute(app);
usersRoute(app);
ordersRoute(app);
ordersDetailsRoute(app);

app.listen(process.env.PORT, function () {

});