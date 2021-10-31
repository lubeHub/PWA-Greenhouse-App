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
                                <div>
                                    <label>Polje 1:</label
                                    ><select
                                        v-model="field1"
                                        @change="setSelectedValue"
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
                                    <label>Polje 2:</label
                                    ><select
                                        v-model="field2"
                                        @change="setSelectedValue"
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
                                    <label>Polje 3:</label
                                    ><select
                                        v-model="field3"
                                        @change="setSelectedValue"
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
                                    <label>Polje 4:</label
                                    ><select
                                        v-model="field4"
                                        @change="setSelectedValue"
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
                                    <label>Polje 5:</label
                                    ><select
                                        v-model="field5"
                                        @change="setSelectedValue"
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
                                    <label>Polje 6:</label
                                    ><select
                                        v-model="field6"
                                        @change="setSelectedValue"
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
                                    <label>Polje 7:</label
                                    ><select
                                        v-model="field7"
                                        @change="setSelectedValue"
                                        ><option
                                            v-for="podatak in podaci"
                                            :disabled="
                                                checkIfExist(podatak.name)
                                            "
                                            :key="podatak.id"
                                            >{{ podatak.name
                                            }}<img :src="podatak.url"/></option
                                    ></select>
                                </div>
                                <div>
                                    <label>Polje 8:</label
                                    ><select
                                        v-model="field8"
                                        @change="setSelectedValue"
                                       
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
                                <button
                                    class="btn btn-outline-info"
                                    @click="saveMeasurements()"
                                >
                                    Sacuvaj podesavanja
                                </button>
                            
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
        setSelectedValue(event) {
         
            this.selectedValue.push(event.target.selectedOptions[0].value);
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
