<template>
    <div class=" letters">
        <nav class=" navbar navbar-dark navbar-expand-sm ">
            <div class="container-fluid">
                 
                <div class="navbar-header">
                   
                    <a class="navbar-brand" href="#"
                        >Diplomski rad<span class="dot" style="font-size:20px"
                            >.</span
                        ></a
                    > </div>
                    <button
                        type="button"
                        class="navbar-toggler"
                        data-toggle="collapse"
                        data-target="#navCollapse"
                    >
                          
                        <span class="navbar-toggler-icon">
                            <i class="fas fa-bars" style="color:#fff; font-size:28px;"></i></span> 
                         
                    </button>
               
                <div class="collapse navbar-collapse letters" id="navCollapse">
                    <ul class="nav navbar-nav mr-auto ">
                        <li class="nav-item" v-if="isLoggedIn">
                            <router-link
                                class="nav-link "
                                :to="{ name: 'live', params: { id: user.id } }"
                                >Trenutna mjerenja</router-link
                            >
                        </li>
                        
                        <li class="nav-item" v-if="isLoggedIn">
                            <router-link
                                class="nav-link "
                                :to="{ name: 'trend', params: { id: user.id } }"
                                >Trend mjerenja</router-link
                            >
                        </li>
                        <li
                            class="nav-item"
                            v-if="isLoggedIn && user.role == '1'"
                        >
                            <router-link
                                class="nav-link "
                                :to="{ name: 'admin' }"
                                >Prikaz korisnika</router-link
                            >
                        </li>
                    </ul>
                    <ul class="nav navbar-nav ml-auto letters">
                        <li class="nav-item" v-if="!isLoggedIn">
                            <router-link
                                class="nav-link "
                                :to="{ name: 'registration' }"
                                >Registruj se</router-link
                            >
                        </li>
                        <li class="nav-item" v-if="!isLoggedIn">
                            <router-link
                                class="nav-link "
                                :to="{ name: 'login' }"
                                >Prijavi se</router-link
                            >
                        </li>
                        <li class="nav-item" v-if="isLoggedIn">
                            <a class="nav-link" href="#"
                                >Zdravo,
                                <span class="blue-label">{{
                                    user.first_name
                                }}</span></a
                            >
                        </li>
                        <li class="nav-item" v-if="isLoggedIn">
                            <a class="nav-link" href="#" @click.prevent="logout"
                                >Odjavi se</a
                            >
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="bazicni-div">
            <router-view></router-view>
        </div>
    </div>
</template>
<script>
import { mapState } from "vuex";

export default {
    name: "Navigation",
    computed: {
        ...mapState({
            isLoggedIn: "isLoggedIn",
            user: "user"
        })
    },
    methods: {
        async logout() {
            try {
                axios.post("/logout");
                this.$store.dispatch("logout");
                this.$router.push({ name: "home" });
            } catch (error) {
                this.$store.dispatch("logout");
            }
        }
    }
};
</script>
<style scoped>
.bazicni-div {
    width: 100%;
    height: 100%;
    margin-top: 1.5%;
    background-color: #282a37;
}
.icon-bar{
    background-color:white;
}
</style>
