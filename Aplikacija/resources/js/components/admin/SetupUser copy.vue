<template>
    <body class="align letters">
        <div class="grid align__item">
            <div class="background_image">
                <div class="register">
                    <div v-if="!loading">
                        <h5 class="heading">
                            Odaberi veličine<span class="dot">.</span>
                        </h5>
                        <div class="row justify-content-center">
                            <div class="col-md-4" style="padding-top:1.5rem">
                                <div>
                                    <div class="blue-label">Ime:</div>
                                    {{ this.user.first_name }}
                                </div>
                                <div>
                                    <div class="blue-label">Prezime:</div>
                                    {{ this.user.last_name }}
                                </div>
                            </div>
                            <div class="col-md-8 select-div">
                                <div class="input-div">
                                    <div>
                                        <label class="gray-label"
                                            >Polje 1:</label
                                        ><select
                                            v-model="field1"
                                            @change="setSelectedValue($event,1)"
                                            ><option
                                                v-for="podatak in podaci"
                                                :disabled="
                                                    checkIfExist(podatak.name)
                                                "
                                                :key="podatak.id"
                                                >{{ podatak.name }}</option
                                            ></select
                                        >
                                    </div>
                                    <div>
                                        <label class="gray-label"
                                            >Polje 2:</label
                                        ><select
                                            v-model="field2"
                                            @change="setSelectedValue($event,2)"
                                            ><option
                                                v-for="podatak in podaci"
                                                :disabled="
                                                    checkIfExist(podatak.name)
                                                "
                                                :key="podatak.id"
                                                >{{ podatak.name }}</option
                                            ></select
                                        >
                                    </div>
                                    <div>
                                        <label class="gray-label"
                                            >Polje 3:</label
                                        ><select
                                            v-model="field3"
                                            @change="setSelectedValue($event,3)"
                                            ><option
                                                v-for="podatak in podaci"
                                                :disabled="
                                                    checkIfExist(podatak.name)
                                                "
                                                :key="podatak.id"
                                                >{{ podatak.name }}</option
                                            ></select
                                        >
                                    </div>
                                    <div>
                                        <label class="gray-label"
                                            >Polje 4:</label
                                        ><select
                                            v-model="field4"
                                             @change="setSelectedValue($event,4)"
                                            ><option
                                                v-for="podatak in podaci"
                                                :disabled="
                                                    checkIfExist(podatak.name)
                                                "
                                                :key="podatak.id"
                                                >{{ podatak.name }}</option
                                            ></select
                                        >
                                    </div>
                                    <div>
                                        <label class="gray-label"
                                            >Polje 5:</label
                                        ><select
                                            v-model="field5"
                                             @change="setSelectedValue($event,5)"
                                            ><option
                                                v-for="podatak in podaci"
                                                :disabled="
                                                    checkIfExist(podatak.name)
                                                "
                                                :key="podatak.id"
                                                >{{ podatak.name }}</option
                                            ></select
                                        >
                                    </div>
                                    <div>
                                        <label class="gray-label"
                                            >Polje 6:</label
                                        ><select
                                            v-model="field6"
                                            @change="setSelectedValue($event,6)"
                                            ><option
                                                v-for="podatak in podaci"
                                                :disabled="
                                                    checkIfExist(podatak.name)
                                                "
                                                :key="podatak.id"
                                                >{{ podatak.name }}</option
                                            ></select
                                        >
                                    </div>
                                    <div>
                                        <label class="gray-label"
                                            >Polje 7:</label
                                        ><select
                                            v-model="field7"
                                             @change="setSelectedValue($event,7)"
                                            ><option
                                                v-for="podatak in podaci"
                                                :disabled="
                                                    checkIfExist(podatak.name)
                                                "
                                                :key="podatak.id"
                                                >{{ podatak.name
                                                }}<img
                                                    :src="podatak.url"/></option
                                        ></select>
                                    </div>
                                    <div>
                                        <label class="gray-label"
                                            >Polje 8:</label
                                        ><select
                                            v-model="field8"
                                             @change="setSelectedValue($event,8)"
                                            ><option
                                                :disabled="
                                                    checkIfExist(podatak.name)
                                                "
                                                v-for="podatak in podaci"
                                                :key="podatak.id"
                                                >{{ podatak.name }}</option
                                            ></select
                                        >
                                    </div>
                                </div>
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
                                    ><button
                                        class="btn btn-secondary"
                                    >
                                        Nazad
                                    </button></router-link
                                >
                            </div>

                            <div class="col-md-6 " style="padding-left:10%;  padding-right:0">
                              
                                    <button
                                        class="btn btn-primary btn-outline-info"
                                        @click="saveMeasurements()"
                                    >
                                        Sačuvaj
                                    </button>
                            </div>
                           
                        </div>
                    </div>
                    <div v-else><data-loading></data-loading></div>
                </div>
            </div>
        </div>
    </body>
</template>
<script>
import DataLoading from "../DataLoading.vue";
export default {
    components: { DataLoading },
    data() {
        return {
            id: this.$route.params.id,
            user: null,
            podaci: null,
            selectedValue: [],
            loading: false,
            field1: null,
            field2: null,
            field3: null,
            field4: null,
            field5: null,
            field6: null,
            field7: null,
            field8: null,
            measurementArray: []
        };
    },
    methods: {
        setSelectedValue(event,id) {
            this.selectedValue[id]=event.target.selectedOptions[0].value;
           
            console.log(this.selectedValue);
        },
        checkIfExist(podatak) {
            return this.selectedValue.includes(podatak);
            
        },
        saveMeasurements() {
            this.measurementArray = [
                { field: 1, value: this.field1 },
                { field: 2, value: this.field2 },
                { field: 3, value: this.field3 },
                { field: 4, value: this.field4 },
                { field: 5, value: this.field5 },
                { field: 6, value: this.field6 },
                { field: 7, value: this.field7 },
                { field: 8, value: this.field8 }
            ];
            axios.post("/api/usermeasurements", {
                measurementArray: this.measurementArray,
                userId: this.user.id
            });
        }
    },
    created() {
        this.loading = true;
        try {
            axios.get(`/api/users/${this.id}`).then(response => {
                this.user = response.data;
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
