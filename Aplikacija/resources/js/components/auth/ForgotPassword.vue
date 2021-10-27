<template>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-6">
                <div class="card card-default">
                    <div class="card-header">Resetujte lozinku</div>
                    <div class="card-body">
                        <form
                            autocomplete="off"
                            @submit.prevent="requestResetPassword"
                            method="post"
                        >
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
                                <span v-if="mailSent" class="text-success"
                                    >Email sa upustvom za resetovanje lozinke je
                                    poslat na vasu adresu.</span
                                >
                            </div>

                            <button type="submit" class="btn btn-primary">
                                Resetuj lozinku
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
