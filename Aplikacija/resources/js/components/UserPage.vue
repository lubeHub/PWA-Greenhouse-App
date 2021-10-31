<template>
    <div class="container">
        <div class="card">
            <div class="card-header">Kontrola korisnika</div>
            <div class="card-body" v-if="!loading">
                <div class="row justify-content-center">
                    <div class="col-md-4">
                        <div>Ime: {{ this.user.first_name }}</div>
                        <div>Prezime: {{ this.user.last_name }}</div>
                    </div>
                    <div class="col-md-8 ">
                        <div class="card">
                            <div class="card-header">Izaberite velicine</div>
                            <div class="card-body">
                                <div
                                    class="row p-3"
                                    v-for="podatak in podaci"
                                    :key="podatak.id"
                                >
                                    <div class="col-md-8">
                                        <div class="d-flex align-items-center">
                                            <div>
                                                <h5>{{ podatak.name }}</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="col-md-4 d-flex flex-row-reverse"
                                        style="width:30px; height:40px;"
                                    >
                                        <img :src="podatak.url" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                   
                </div>
 <div class="align-self-end d-flex flex-row-reverse p-2">
                        <router-link
                            class="link"
                            :to="{
                                name: 'admin'
                            }"
                            ><button class="btn btn-outline-info">
                                Vrati se nazad
                            </button></router-link
                        >
                    </div>
            </div>
            <div v-else>Podaci se ucitavaju..</div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            id: this.$route.params.id,
            user: null,
            podaci: null,
            loading: false
        };
    },
    created() {
        this.loading = true;

        try {
            axios.get("/sanctum/csrf-cookie");
            const pomoc = axios.get(`/api/users/${this.id}`).then(response => {
                this.user = response.data;
                this.loading = false;
            });
            axios.get("/api/measurements").then(response => {
                this.podaci = response.data;
                this.loading = false;
            });
            console.log(this.podaci);
        } catch (error) {}
    }
};
</script>
