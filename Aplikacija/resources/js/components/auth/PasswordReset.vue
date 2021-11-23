<template>
    <body class="align letters">
        <div class="grid align__item">
            <div class="background_image">
                <div class="register">
                    <form>
                        <h5 class="heading">Promijeni lozinku<span class="dot">.</span></h5>
                        <div class="form-group input-div">
                         
                            <input
                                type="text"
                                id="email"
                                class="form-control input-field"
                                autocomplete="off"
                                required
                                v-model="email"
                                :class="[{ 'is-invalid': errorFor('email') }]"
                            />
                               <label for="email" class="input-label">E-mail</label>
                            <v-errors :errors="errorFor('email')"></v-errors>
                        </div>

                        <div class="form-group input-div ">
                           
                            <input
                                type="password"
                                id="password"
                                class="form-control input-field"
                                autocomplete="off"
                                required
                                v-model="password"
                                :class="[
                                    { 'is-invalid': errorFor('password') }
                                ]"
                            />
                             <label for="password" class="input-label">Lozinka</label>
                            <v-errors :errors="errorFor('password')"></v-errors>
                        </div>

                        <div class="form-group input-div ">
                           
                            <input
                                type="password"
                                id="password_confirmation"
                                class="form-control input-field"
                                autocomplete="off"
                                required
                                v-model="password_confirmation"
                                :class="[
                                    {
                                        'is-invalid': errorFor(
                                            'password_confirmation'
                                        )
                                    }
                                ]"
                            />
                             <label for="password_confirmation" class="input-label"
                                >Potvrdi lozinku</label
                            >
                            <v-errors
                                :errors="errorFor('password_confirmation')"
                            ></v-errors>
                        </div>

                        <button
                            type="submit"
                            class="btn btn-primary btn-lg btn-block"
                            :disabled="loading"
                            @click.prevent="resetPassword"
                        >
                            Promijeni lozinku
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</template>
<script>
import validationErrors from "../mixins/validationErrors";
import { logIn } from "../../auth";

export default {
    mixins: [validationErrors],
    data() {
        return {
            token: null,
            email: null,
            password: null,
            password_confirmation: null,
            loading: false
        };
    },
    methods: {
        async resetPassword() {
            this.loading = true;
            this.errors = null;
            try {
                await axios.get("/sanctum/csrf-cookie");
                await axios.post("/password/reset", {
                    token: this.$route.params.token,
                    email: this.email,
                    password: this.password,
                    password_confirmation: this.password_confirmation
                });

                await axios.post("/login", {
                    email: this.email,
                    password: this.password
                });

                logIn();
                this.$store.dispatch("loadUser");
                this.$router.push({ name: "home" });
            } catch (error) {
                this.errors = error.response && error.response.data.errors;
            }

            this.loading = false;
        }
    }
};
</script>
