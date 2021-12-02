import VueRouter from "vue-router";
import Trend from "./components/users/TrendMeasurement";
import Admin from "./components/admin/AdminComponent";
import ManageUser from "./components/admin/ManageUser";
import Registration from "./components/auth/Registration";
import Reset from "./components/auth/PasswordReset";
import Login from "./components/auth/Login";
import Live from "./components/users/LiveMeasurement"
import Forgot from "./components/auth/ForgotPassword";
const routes = [

    {
        path: "/trend/:id",
        name: "trend",
        component: Trend,
        props:true
    },
    {
        path: "/live/:id",
        name: "live",
        component: Live,
        props:true
    },
    {
        path: "/auth/login",
        name: "login",
        component: Login
    },
    {
        path: "/auth/registration",
        name: "registration",
        component: Registration
    },
    {
        path: "/auth/reset-password/:token",
        name: "reset",
        component: Reset
    },
    {
        path: "/auth/forgot-password",
        name: "forgot",
        component: Forgot
    },
    {
        path: "/admin/manage-user/:id",
        name: "manage-user",
        component: ManageUser,
        props: true
    },
    {
        path: "/admin",
        name: "admin",
        component: Admin
    },
];


const router = new VueRouter({
    routes,
    mode:"history"
})

export default router;