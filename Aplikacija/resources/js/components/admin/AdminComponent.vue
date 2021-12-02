<!--Admin komponenta koja izlistava sve korisnike iz baze -->
<template>
        <div class="mreza poravnanje">
            <div class="background_image">
                <div class="register">
                     <div v-if="!loading">
                    <div v-if="isLoggedIn && user.role == '1'">
                       
                            <div class="box"> <h5 class="heading">
                                Podešavanje korisnika<span class="dot">.</span>
                                <div class="half_border"></div>
                            </h5></div>
                          
                             
                            <div
                                class="row p-3"
                                v-for="user in users"
                                :key="user.id"
                            >
                
                                <div class="ime col-md-8">
                                   <label> {{ user.first_name }} {{ user.last_name }}</label>
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
                      <div v-else><no-access-page></no-access-page></div>
                    </div>
                      <div v-else><data-loading></data-loading></div>
                    
                </div>
            </div>
        </div>
</template>
<script>
import DataLoading from "./../shared/DataLoading.vue";
import { mapState } from "vuex";
import NoAccessPage from "./../shared/NoAccessPage.vue";
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

.btn {
    width:100px;
    height:45px;
    color: white;
    border-radius: 106px;
}
.ime {
    padding-top: 3.5%;
    font-size:1rem;
}
button{
    position:absolute;
    right:0;
}
label{
    margin-top:2%;
}
</style>
