<template>
    <body class="align letters">
        <div class="grid align__item">
            <div class="background_image">
                <div class="register">
                    <div v-if="!loading">
                        <div v-if="isLoggedIn && loggedUser.role == '1'">
                            <h5 class="heading">
                                Odaberi veličine<span class="dot">.</span>
                            </h5>
                            <div class="row justify-content-center">
                                <div
                                    class="col-md-4"
                                    style="padding-top:1.5rem"
                                >
                                    <div>
                                        <div class="blue-label">Ime:</div>
                                        {{ this.selectedUser.first_name }}
                                    </div>
                                    <div>
                                        <div class="blue-label">Prezime:</div>
                                        {{ this.selectedUser.last_name }}
                                    </div>
                                </div>
                                <div class="col-md-8 select-div">
                                    <div class="input-div">
                                        <div
                                            v-for="number in numberOfFields"
                                            :key="number"
                                        >
                                            <div>
                                                <label class="gray-label"
                                                    >Polje {{ number }}:</label
                                                ><select
                                                    v-model="fields[number]"
                                                    @change="
                                                        setSelectedValue(
                                                            $event,
                                                            number
                                                        )
                                                    "
                                                >
                                                    <option></option
                                                    ><option
                                                        v-for="podatak in podaci"
                                                        :disabled="
                                                            checkIfExist(
                                                                podatak.name
                                                            )
                                                        "
                                                        :key="podatak.id"
                                                        >{{
                                                            podatak.name
                                                        }}</option
                                                    ></select
                                                >
                                            </div>
                                             
                                        </div>
                                    </div>
                                    <span v-if="valuesChanged>1" class="text-success"
                                    >Veličine su uspješno promijenjene.</span
                                > <span v-if="valuesChanged<1" class="text-failure"
                                    >Greška prilikom promijene.</span
                                > 
                                </div>
                            </div>

                            <div
                                class="row justify-content-center"
                                style="margin-top:2rem"
                            >
                                <div class="col-md-6 " style="padding-left:0">
                                    <router-link
                                        class="link"
                                        :to="{
                                            name: 'admin'
                                        }"
                                        ><button class="btn btn-secondary">
                                            Nazad
                                        </button></router-link
                                    >
                                </div>

                                <div
                                    class="col-md-6 "
                                    style="padding-left:10%;  padding-right:0"
                                >
                                    <button
                                        class="btn btn-primary btn-outline-info"
                                        @click="saveMeasurements()"
                                    >
                                        Sačuvaj
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div v-else><no-access-page></no-access-page></div>
                    </div>
                    <div v-else><data-loading></data-loading></div>
                </div>
            </div>
        </div>
    </body>
</template>
<script>
import DataLoading from "../DataLoading.vue";
import NoAccessPage from "../NoAccessPage.vue";
import { mapState } from "vuex";
export default {
    name: "ManageUser",
    components: { DataLoading, NoAccessPage },
    computed: {
        ...mapState({
            isLoggedIn: "isLoggedIn",
            loggedUser: "user"
        })
    },
    data() {
      return {
            id: this.$route.params.id,
            selectedUser: null,
            podaci: null,
            selectedValue: [],
            loading: false,
            measurementArray: [],
            fields: [],
            numberOfFields: 8,
            valuesChanged:1
        };
    },
    methods: {
        setSelectedValue(event,id) {
            this.valuesChanged=1;
            this.selectedValue[id]=event.target.selectedOptions[0].value;
        },
        checkIfExist(podatak) {
            return this.selectedValue.includes(podatak);
            
        },
        saveMeasurements() {
             for (var number = 1; number <= this.numberOfFields; number++) {
                 if(this.fields[number]== undefined){
                     this.measurementArray.push({
                    field: number,
                    value: null
                });
                 }
             else   this.measurementArray.push({
                    field: number,
                    value: this.fields[number]
                });
            }
            try{
                axios.post("/api/usermeasurements", {
                measurementArray: this.measurementArray,
                userId: this.selectedUser.id
            });
            this.valuesChanged=2;
            }
            catch(error){
             this.valuesChanged=0;   
            }
        }
    },
     created() {
        this.loading = true;
        try {
            axios.get(`/api/users/${this.id}`).then(response => {
                this.selectedUser = response.data;
                this.loading = false;
            });
            axios.get("/api/measurements").then(response => {
                this.podaci = response.data;
                this.loading = false;
            });
        } catch (error) {}
    }
};
</script>
<style lang="scss" scoped>
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
.btn {
    height: 40px;
    width: 150px;
}
.btn-secondary{
    background-color:#6c757d;
}
</style>
