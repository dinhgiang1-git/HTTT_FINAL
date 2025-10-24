import {createRouter, createWebHistory} from 'vue-router'

// Layout
import DefaultLayout from '../layouts/DefaultLayout.vue'

// Main Views
import Dashboard from '../views/Dashboard.vue'
import Footer from '../components/Footer.vue'
import Brand from '../views/Brand&Category/Brand.vue'
import Category from '../views/Brand&Category/Category.vue'
import Settings from '../views/Settings.vue'

// Auth Views
import Login from '../views/auth/Login.vue'
import Register from '../views/auth/Register.vue'
import Logout from '../views/auth/Logout.vue'
import Users from '../views/auth/Users.vue'
import Security from '../views/auth/Security.vue'
import Privacy from '../views/auth/Privacy.vue'
import Profile from '../views/auth/Profile.vue'
import Employee from "../views/Employee&Customer/Employee.vue";
import Customer from "../views/Employee&Customer/Customer.vue";
import Order from "../views/order/Order.vue";
import Product from "../views/product/Product.vue";

const routes = [
    // Layout-wrapped routes (with sidebar + topbar)
    {
        path: '/',
        component: DefaultLayout,
        children: [
            {
                path: '',
                name: 'dashboard',
                component: Dashboard,
                meta: {title: '📊 Dashboard'}
            },
            {
                path: 'folders',
                name: 'folders',
                component: Footer,
                meta: {title: 'Footer'}
            },
            {
                path: 'manager/brand',
                name: 'Brand',
                component: Brand,
                meta: {title: 'Brand'}
            },
            {
                path: 'manager/category',
                name: 'Category',
                component: Category,
                meta: {title: 'Category'}
            },
            {
                path: 'manager/employee',
                name: 'Employee',
                component: Employee,
                meta: {title: 'Employee'}
            },
            {
                path: 'manager/customer',
                name: 'Customer',
                component: Customer,
                meta: {title: 'Customer'}
            },
            {
                path: 'manager/order',
                name: 'Order',
                component: Order,
                meta: {title: 'Order'}
            },
            {
                path: 'manager/product',
                name: 'Product',
                component: Product,
                meta: {title: 'Product'}
            },
            {
                path: 'settings',
                name: 'settings',
                component: Settings,
                meta: {title: 'Settings'}
            }
        ]
    },

    // Auth layout-wrapped routes (sidebar still applies)
    {
        path: '/auth',
        component: DefaultLayout,
        children: [
            {
                path: 'profile',
                name: 'profile',
                component: Profile,
                meta: {title: '👤 Profile'}
            },
            {
                path: 'users',
                name: 'users',
                component: Users,
                meta: {title: '🔒 Users'}
            },
            {
                path: 'security',
                name: 'security',
                component: Security,
                meta: {title: '🛡️ Security'}
            },
            {
                path: 'privacy',
                name: 'privacy',
                component: Privacy,
                meta: {title: '🔒 Privacy'}
            }
        ]
    },

    // Public auth routes (no sidebar)
    {
        path: '/auth/login',
        name: 'login',
        component: Login,
        meta: {title: '🔐 Login'}
    },
    {
        path: '/auth/register',
        name: 'register',
        component: Register,
        meta: {title: '📝 Register'}
    },
    {
        path: '/auth/logout',
        name: 'logout',
        component: Logout,
        meta: {title: '🔒 Logout'}
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

// Update document title based on route meta title
router.afterEach((to) => {
    const nearestWithTitle = to.matched.slice().reverse().find(r => r.meta?.title)
    document.title = nearestWithTitle ? nearestWithTitle.meta.title : 'StarCode Kh'
})

export default router
