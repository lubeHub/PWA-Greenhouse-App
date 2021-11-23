<template>
    <div class="navigacija letters">
        <nav class=" navbar navbar-expand-lg">
            <div class="container-fluid">
                  <router-link
                                    class="nav-link"
                                    :to="{ name: 'home' }"
                                    ><a class="navbar-brand" href="#">Diplomski rad<span class="dot" style="font-size:20px">.</span></a> </router-link
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
                                    >Prijavi se</router-link
                                >
                            </li>
                            <li class="nav-item" v-if="isLoggedIn">
                                <a class="nav-link" href="#">Zdravo, <span class="blue-label">{{user.first_name}}</span></a>             
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
               this.$router.push({ name: 'home' });
            } catch (error) {
                 this.$store.dispatch("logout");
            }
        }
    }
};
</script>
