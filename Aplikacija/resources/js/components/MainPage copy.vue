<template>
    <div class="container ">
        <div class="card-header">Kontrola korisnika</div>
        <div class="card ">
            <div class="card-body" >
                <div class="row p-3" v-for="measurement in userMeasurements" :key="measurement.id">
                    <div class="col-md-8">
                      <h5>{{ user.first_name }} {{ user.last_name }}</h5>  
                    </div>

                    <div
                        class="col-md-4 align-self-end d-flex flex-row-reverse"
                    >
                        <router-link
                            class="link"
                            :to="{
                                name: 'manage-user',
                                params: { id: user.id }
                            }"
                            ><button class="btn btn-outline-info" :id="user.id">
                                Podesi korisnika
                            </button></router-link
                        >
                    </div>
                </div>
            </div>
            
            <button class="btn btn-outline-info" @click="doSth"></button>
        </div>
    </div>
</template>
<script>
import { mapState } from "vuex";

export default {
    data() {
        return {
            userMeasurements: null,
            loading: false
        };
    },
    computed: {
        ...mapState({
            user: "user",
        }),


    },
methods:{
    doSth() {
      
        this.loading = true;
        console.log(this.user.id);
        try {
            console.log(this.user.id);
              axios.post("/api/getusermeasurements", {
                userId: this.user.id
            });
            console.log("RADI");
        } catch (error) {
            console.log(error);
        }
    },

}}
</script>
