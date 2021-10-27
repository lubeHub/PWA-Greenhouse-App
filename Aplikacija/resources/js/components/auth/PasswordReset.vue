<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-6">
                <div class="card card-default">
                    <div class="card-header">New Password</div>
                    <div class="card-body">
                        <form>
                            <div class="form-group">
                                <label for="email">E-mail</label>
                                <input
                                    type="email"
                                    id="email"
                                    class="form-control"
                                    placeholder="Unesite vasu email adresu"
                                    v-model="email"
                                    :class="[
                                        { 'is-invalid': errorFor('email') }
                                    ]"
                                />
                                <v-errors
                                    :errors="errorFor('email')"
                                ></v-errors>
                            </div>

                            <div class="form-group">
                                <label for="password ">Lozinka</label>
                                <input
                                    type="password"
                                    id="password"
                                    class="form-control"
                                    placeholder="Unesite vasu lozinku"
                                    v-model="password"
                                    :class="[
                                        { 'is-invalid': errorFor('password') }
                                    ]"
                                />
                                <v-errors
                                    :errors="errorFor('password')"
                                ></v-errors>
                            </div>

                            <div class="form-group">
                                <label for="email">Potvrdi lozinku</label>
                                <input
                                    type="password"
                                    id="password_confirmation"
                                    class="form-control"
                                    placeholder="Potvrdite vasu lozinku"
                                    v-model="password_confirmation"
                                    :class="[
                                        {
                                            'is-invalid': errorFor(
                                                'password_confirmation'
                                            )
                                        }
                                    ]"
                                />
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
                                Update
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
