<template>
    <div class="mreza poravnanje">
        <div class="background_image">
            <div class="register">
                  <div class="box"> <h5 class="heading">
                               Prijavi se<span class="dot">.</span>
                                <div class="half_border"></div>
                            </h5></div>
                <form>
                    <div class="form-group input-div ">
                        <input
                            type="text"
                            autocomplete="off"
                            name="email"
                            class="input-field form-control"
                            v-model="email"
                            required
                            :class="[{ 'is-invalid': errorFor('email') }]"
                        />
                        <label for="email" class="input-label">E-mail</label>
                        <v-errors :errors="errorFor('email')"></v-errors>
                    </div>
                    <div class="invalid-feedback">{{ this.errors }}</div>
                    <div class="input-div form-group">
                        <input
                            type="password"
                            autocomplete="off"
                            name="password"
                            class="input-field form-control"
                            v-model="password"
                            required
                            :class="[{ 'is-invalid': errorFor('password') }]"
                        />
                        <label for="email" class="input-label">Lozinka</label
                        ><v-errors :errors="errorFor('password')"></v-errors>
                    </div>

                    <button
                        type="submit"
                        class="btn btn-primary btn-lg btn-block"
                        :disabled="loading"
                        @click.prevent="login"
                    >
                        Prijava
                    </button>

                    <hr />

                    <div>
                        Nemate jos nalog?
                        <router-link
                            :to="{ name: 'registration' }"
                            class="font-weight-bold"
                            >Kreirajte novi.</router-link
                        >
                    </div>

                    <div>
                        Zaboravili ste lozinku?
                        <router-link
                            :to="{ name: 'forgot' }"
                            class="font-weight-bold"
                            >Resetujte lozinku.</router-link
                        >
                    </div>
                </form>
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
            email: null,
            password: null,
            loading: false
        };
    },
    methods: {
        async login() {
            this.loading = true;
            this.errors = null;

            try {
                await axios.get("/sanctum/csrf-cookie");
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
<style  scoped>
    .half_border{
        right:70%;
    }
</style>