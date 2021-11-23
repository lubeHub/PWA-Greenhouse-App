<template>
    <body class="align letters">
        <div class="grid align__item">
            <div class="background_image">
                    <div class="register">
                       
                        <form>
                             <h5 class="heading">Registruj se<span class="dot">.</span></h5> 
                            <div class="input-div form-group">
                                <input
                                    type="text"
                                    autocomplete="off"
                                    name="first_name"
                                    class="input-field form-control"
                                    v-model="user.first_name"
                                    required
                                    :class="[
                                        { 'is-invalid': errorFor('first_name') }
                                    ]"
                                />
                                <label class="input-label" for="first_name"
                                    >Ime:</label
                                >
                                <v-errors
                                    :errors="errorFor('first_name')"
                                ></v-errors>
                            </div>
                            <div class="input-div form-group">
                                <input
                                    type="text"
                                    autocomplete="off"
                                    name="last_name"
                                    class="input-field form-control"
                                    v-model="user.last_name"
                                    required
                                    :class="[
                                        { 'is-invalid': errorFor('last_name') }
                                    ]"
                                />
                                <label class="input-label" for="last_name"
                                    >Prezime:</label
                                >

                                <v-errors
                                    :errors="errorFor('last_name')"
                                ></v-errors>
                            </div>
                            <div class="input-div form-group">
                                <input
                                    type="text"
                                    autocomplete="off"
                                    name="email"
                                    class="input-field form-control"
                                    v-model="user.email"
                                    required
                                    :class="[
                                        { 'is-invalid': errorFor('email') }
                                    ]"
                                />
                                <label for="email" class="input-label"
                                    >E-mail:</label
                                >
                                <v-errors
                                    :errors="errorFor('email')"
                                ></v-errors>
                            </div>

                            <div class="input-div form-group">
                                <input
                                    type="password"
                                    autocomplete="off"
                                    name="password"
                                    class="input-field form-control"
                                    v-model="user.password"
                                    required
                                    :class="[
                                        { 'is-invalid': errorFor('password') }
                                    ]"
                                />
                                <label for="password" class="input-label"
                                    >Lozinka:</label
                                >
                                <v-errors
                                    :errors="errorFor('password')"
                                ></v-errors>
                            </div>

                            <div class="input-div form-group">
                                <input
                                    type="password"
                                    autocomplete="off"
                                    name="password_confirmation"
                                    class="input-field form-control"
                                    required
                                    v-model="user.password_confirmation"
                                    :class="[
                                        {
                                            'is-invalid': errorFor(
                                                'password_confirmation'
                                            )
                                        }
                                    ]"
                                />
                                <label
                                    for="password_confirmation"
                                    class="input-label"
                                    >Potvrdite lozinku:
                                </label>
                                <v-errors
                                    :errors="errorFor('password_confirmation')"
                                ></v-errors>
                            </div>

                            <button
                                type="submit"
                                class="btn btn-primary btn-lg btn-block"
                                :disabled="loading"
                                @click.prevent="register"
                            >
                                Registracija
                            </button>

                            <hr />

                            <div>
                                Već imate nalog?
                                <router-link
                                    :to="{ name: 'login' }"
                                    class="font-weight-bold"
                                    >Ulogujte se</router-link
                                >
                            </div>
                        </form>
                    </div>
                </div>
            </div>
       
    </body>
</template>

<script>
import validationErrors from "../mixins/validationErrors";
import { logIn } from "./../mixins/auth";

export default {
    mixins: [validationErrors],
    data() {
        return {
            user: {
                first_name: null,
                last_name: null,
                email: null,
                password: null,
                password_confirmation: null
            },
            loading: false
        };
    },
    methods: {
        async register() {
            this.loading = true;
            this.errors = null;

            try {
                const response = await axios.post("/register", this.user);

                if (201 == response.status) {
                    logIn();
                    this.$store.dispatch("loadUser");
                    this.$router.push({ name: "home" });
                }
            } catch (error) {
                this.errors = error.response && error.response.data.errors;
            }

            this.loading = false;
        }
    }
};
</script>
<style lang="scss">
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
