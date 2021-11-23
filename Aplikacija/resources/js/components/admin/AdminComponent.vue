<template>
    <body class="align letters">
        <div class="grid align__item">
            <div class="background_image">
                <div class="register">
                    <div v-if="isLoggedIn && user.role == '1'">
                        <div v-if="!loading">
                            <h5 class="heading">
                                Podešavanje korisnika<span class="dot">.</span>
                            </h5>
                            <div
                                class="row p-3"
                                v-for="user in users"
                                :key="user.id"
                            >
                                <div class="ime col-md-8">
                                    {{ user.first_name }} {{ user.last_name }}
                                </div>

                                <div
                                    class="col-md-4 align-self-end d-flex flex-row-reverse"
                                >
                                    <router-link
                                        class="link"
                                        :to="{
                                            name: 'manage-user',
                                            params: { id: user.id }
                                        }"
                                        ><button class="btn" :id="user.id">
                                            Podesi
                                        </button></router-link
                                    >
                                </div>
                            </div>
                        </div>
                        <div v-else><data-loading></data-loading></div>
                    </div>
                    <div v-else><no-access-page></no-access-page></div>
                </div>
            </div>
        </div>
    </body>
</template>
<script>
import DataLoading from "../DataLoading.vue";
import { mapState } from "vuex";
import NoAccessPage from "../NoAccessPage.vue";
export default {
    name: "Admin",
    computed: {
        ...mapState({
            isLoggedIn: "isLoggedIn",
            user: "user"
        })
    },

    components: { DataLoading, NoAccessPage },

    data() {
        return {
            users: null,
            loading: false
        };
    },
    created() {
        this.loading = true;
        try {
            axios.get("/api/users").then(response => {
                this.users = response.data;
                this.loading = false;
            });
        } catch (error) {}
    }
};
</script>

<style lang="scss" scoped>
body {
    font-size: large;
}
.btn {
    width: 100px;
    height: 50px;
    color: white;
}
.ime {
    padding-top: 3.5%;
}

$base-bgcolor: #282a37;
$base-color: #7e8ba3;

body {
    background-color: $base-bgcolor;
    margin: 0;
    min-height: 100%;
}

$grid-max-width: 25rem;
$grid-width: 100%;

.grid {
    margin: 0 auto;
    max-width: $grid-max-width;
    width: $grid-width;
}
</style>
