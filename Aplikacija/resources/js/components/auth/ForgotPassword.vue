<template>
        <div class="mreza poravnanje">
            <div class="background_image">
                <div class="register">
                     <div class="box"> <h5 class="heading">
                                Resetuj lozinku<span class="dot">.</span>
                                <div class="half_border"></div>
                            </h5></div>
                        <form
                            autocomplete="off"
                            @submit.prevent="requestResetPassword"
                            method="post"
                        >
                         <div class="input-div form-group">
                              
                                <input
                                    type="text"
                                    id="email"
                                    class="input-field form-control"
                                     autocomplete="off"
                                    required
                                    v-model="email"
                                    :class="[
                                        { 'is-invalid': errorFor('email') }
                                    ]"
                                />
                                  <label for="email" class="input-label">E-mail</label>
                                <v-errors
                                    :errors="errorFor('email')"
                                ></v-errors>
                                <span v-if="mailSent" class="text-success"
                                    >Email sa uputstvom za resetovanje lozinke je
                                    poslat na vašu adresu.</span
                                >
                            </div>

                            <button type="submit" class="btn btn-primary btn-lg btn-block">
                                Resetuj lozinku
                            </button>
                        </form>
                    </div>
                </div>
            </div>
</template>
<script>
import validationErrors from "../mixins/validationErrors";

export default {
    mixins: [validationErrors],
    data() {
        return {
            email: null,
            loading: false,
            mailSent: false
        };
    },
    methods: {
        async requestResetPassword() {
            this.loading = true;
            this.errors = null;

            try {
                await axios.post("/password/email", {
                    email: this.email
                });
                this.mailSent = true;
            } catch (error) {
                this.errors = error.response && error.response.data.errors;
                this.mailSent = false;
            }

            this.loading = false;
        }
    }
};
</script>
<style scoped>
.half_border{
    right:60%;
}
</style>
