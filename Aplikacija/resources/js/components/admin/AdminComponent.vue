<template>
    <div class="container ">
        <div class="card-header">Kontrola korisnika</div>
        <div class="card ">
            <div class="card-body" v-if="!loading">
                <div class="row p-3" v-for="user in users" :key="user.id">
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
            <div v-else>Podaci se ucitavaju..</div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            users: null,
            loading: false
        };
    },
    created() {
        this.loading = true;
        try {
            const pomoc = axios.get("/api/users").then(response => {
                this.users = response.data;
                this.loading = false;
            });
        } catch (error) {}
    }
};
</script>
