<template>
    <div>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
                  <router-link
                                    class="nav-link "
                                    :to="{ name: 'home' }"
                                    ><a class="navbar-brand" href="#">Diplomski rad</a> </router-link
                                >
                
                        <ul class="navbar-nav">
                             <li class="nav-item" v-if="isLoggedIn">
                                <router-link
                                    class="nav-link "
                                    :to="{ name: 'main' }"
                                    >Korisnicka mjerenja</router-link
                                >
                            </li>
                           <li class="nav-item" v-if="isLoggedIn && user.role=='1'">
                                <router-link
                                    class="nav-link "
                                    :to="{ name: 'admin' }"
                                    >Admin panel</router-link
                                >
                            </li>
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
                                    >Uloguj se</router-link
                                >
                            </li>
                            <li class="nav-item" v-if="isLoggedIn">
                                <a class="nav-link" href="#">Zdravo, {{user.first_name}}</a>             
                            </li> <li class="nav-item" v-if="isLoggedIn">
                                <a class="nav-link" href="#" @click.prevent="logout">Odjavi se</a>
                            </li>
                        </ul>
                    
               
            </div>
        </nav>
        <div class="container mt-4 mb-4 pr-4 pl-4">
            <router-view></router-view>
        </div>
    </div>
</template>
<script>
import { mapState} from "vuex";

export default {
    name: "Navigation",
     computed: {
    ...mapState({
      isLoggedIn: "isLoggedIn",
      user: "user"
    }),
  
    
  },
    methods:{
        async logout(){
            try {
                
                axios.post("/logout");
               this.$store.dispatch("logout");
            } catch (error) {
                 this.$store.dispatch("logout");
            }
        }
    }
};
</script>
