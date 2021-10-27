<template>
  <div class="w-50 m-auto">
    <div class="card card-body">
      <form>
        <div class="form-group">
          <label for="email">E-mail</label>
          <input
            type="text"
            name="email"
            placeholder="Unesite vasu e-mail adresu"
            class="form-control"
            v-model="email"
            :class="[{'is-invalid': errorFor('email')}]"
          />
          <v-errors :errors="errorFor('email')"></v-errors>
        </div>

        <div class="form-group">
          <label for="email">Lozinka</label>
          <input
            type="password"
            name="password"
            placeholder="Unesite vasu sifru"
            class="form-control"
            v-model="password"
            :class="[{'is-invalid': errorFor('password')}]"
          />
          <v-errors :errors="errorFor('password')"></v-errors>
        </div>

        <button
          type="submit"
          class="btn btn-primary btn-lg btn-block"
          :disabled="loading"
          @click.prevent="login"
        >Ulogujte se</button>

        <hr />

        <div>
          Nemate jos nalog?
          <router-link :to="{name: 'registration'}" class="font-weight-bold">Kreirajte novi.</router-link>
        </div>

        <div>
          Zaboravili ste lozinku?
          <router-link :to="{name: 'forgot'}" class="font-weight-bold">Resetujte lozinku.</router-link>
        </div>
      </form>
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