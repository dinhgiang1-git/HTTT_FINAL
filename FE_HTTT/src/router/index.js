import {createRouter, createWebHistory} from 'vue-router'
import AppLayout from "@/layouts/AppLayout.vue";
import HomeView from "@/views/HomeView.vue";
import Login from "@/views/auth/Login.vue";
import Register from "@/views/auth/Register.vue";
import UserDetail from "@/components/common/UserDetail.vue";
import ProductDetail from "@/components/product/ProductDetail.vue";
import CartDetail from "@/components/common/CartDetail.vue";
import Payment from "@/components/common/Payment.vue";
import Collections from "@/components/product/Collections.vue";
import Search from "@/components/common/Search.vue";

const routes = [
    {
        path: "/",
        component: AppLayout,
        children: [
            {
                path: "",
                name: "Home",
                component: HomeView
            },
            {
                path: "auth/login",
                name: "Login",
                component: Login
            },
            {
                path: "auth/register",
                name: "Register",
                component: Register
            },
            {
                path: "auth/account/:id",
                name: "Account",
                component: UserDetail
            },
            {
                path: "product/detail/:id",
                name: "ProductDetail",
                component: ProductDetail
            },
            {
                path: "products/collections/:slug",
                name: "Collections",
                component: Collections
            },
            {
                path: "cart/detail/:id",
                name: "CartDetail",
                component: CartDetail
            },
            {
                path: "payment",
                name: "Payment",
                component: Payment
            },
            {
                path: "search",
                name: "Search",
                component: Search
            }
        ]
    }
];

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL), routes
});

export default router;
