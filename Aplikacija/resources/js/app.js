/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue  and Laravel.
 */
require("./bootstrap");

import router from "./routes";
import VueRouter from "vue-router";
import Vue from "vue";
import Vuex from 'vuex';
import ValidationErrors from "./components/shared/ValidationErrors";
import storeDefinition from "./store";
import Navigation from "./components/Navigation";


window.Vue = require("vue");

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i)
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))


const prod = process.env.NODE_ENV === "production";
const shouldSWDev = "serviceWorker" in navigator && !prod;
const shouldSW = "serviceWorker" in navigator;

if (shouldSW ) {
    navigator.serviceWorker.register("/service-worker-dev.js").then(() => {
        console.log("Service Worker Registered dev!");
    });

 }

Vue.use(VueRouter);
Vue.use(Vuex);

Vue.component("v-errors", ValidationErrors);
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const store = new Vuex.Store(storeDefinition);

window.axios.interceptors.response.use(
    response => {
        return response;
    },
    error => {
        if (401 === error.response.status) {
            store.dispatch("logout");
        }

        return Promise.reject(error);
    }
);
const app = new Vue({
    el: "#app",
    router,
    store,
    components:
    {
        Navigation
    },
    async beforeCreate() {
        this.$store.dispatch("loadStoredState");
        this.$store.dispatch("loadUser");
    }
});
