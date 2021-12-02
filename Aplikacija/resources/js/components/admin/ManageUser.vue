<!-- Admin komponenta za podesavanje korisnika i njegovih polja -->
<template>
    <div class="mreza poravnanje">
        <div class="background_image">
            <div class="register">
                <div v-if="!loading">
                    <div v-if="isLoggedIn && loggedUser.role == '1'">
                        <div class="box">
                            <h5 class="heading">
                                Odaberi veličine<span class="dot">.</span>
                                <div class="half_border"></div>
                            </h5>
                        </div>
                        <div class="row justify-content-center">
                            <div class="col-md-4" style="padding-top:1.5rem">
                                <div>
                                    <img
                                        style="border-radius:50%"
                                        :src="baseUrl + this.selectedUser.url"
                                    />
                                </div>
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
                                <div
                                    v-for="number in numberOfFields"
                                    :key="number"
                                >
                                    <div class="input-div">
                                        <div>
                                            <label class="gray-label"
                                                >Polje {{ number }}:</label
                                            >
                                            <div class="vselect">
                                                <v-select
                                                    option:deselected="deselectedValue()"
                                                    :options="podaci"
                                                   
                                                    label="name"
                                                    v-model="fields[number]"
                                                    :selectable="
                                                        option =>
                                                            !checkIfExist(
                                                                option.name
                                                            )
                                                    "
                                                    @input="
                                                        setSelectedValue(
                                                            $event,
                                                            number
                                                        )
                                                    "
                                                >
                                                </v-select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <span
                                    v-if="valuesChanged > 1"
                                    class="text-success"
                                    >Veličine su uspješno promijenjene.</span
                                >
                                <span
                                    v-if="valuesChanged < 1"
                                    class="text-failure"
                                    >Greška prilikom promijene.</span
                                >
                            </div>
                        </div>

                        <div
                            class="row justify-content-center"
                            style="margin-top:2rem"
                        >
                            <div class="col-md-6">
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

                            <div class="col-md-6 rightbutton ">
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
</template>
<script>
import DataLoading from "./../shared/DataLoading.vue";
import NoAccessPage from "./../shared/NoAccessPage.vue";
import { mapState } from "vuex";
import vSelect from "vue-select";
import "./../../../css/select.scss";
export default {
    name: "ManageUser",
    components: { DataLoading, NoAccessPage, vSelect },
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
            selectedValues: [],
            loading: false,
            measurementArray: [],
            fields: [],
            numberOfFields: 8,
            valuesChanged: 1,
            baseUrl: "http://127.0.0.1:8000/images/avatars/"
        };
    },
    methods: {
        //metoda koja dodaje odabranu vrijednost selecta u niz selectedValues
        setSelectedValue(event, id) {
            this.valuesChanged = 1;
           this.selectedValues[id] =( event!=null)?event.name:null;

        },
        //metoda koja provjerava da li je izabrana opcija u nizu selectedValues, odnosno da li je opcija vec izabrana u nekom drugom selectu
        checkIfExist(podatak) {
            return this.selectedValues.includes(podatak);
        },

        // metoda koja vraca odabranog korisnika 
        getSelectedUser() {
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
        },
        //metoda koja vraca sve mjerne velicine iz baze
        getMeasurements() {
            try {
                axios.get("/api/measurements").then(response => {
                    this.podaci = response.data;
                    this.loading = false;
                });
            } catch (error) {}
        },
            deselectedValue(){
                console.log("radi");
            },
        // metoda koja salje bazi izabrane velicine
        saveMeasurements() {
            //provjera validnosti formata
            for (var number = 1; number <= this.numberOfFields; number++) {
                if (this.fields[number] == undefined) {
                    this.measurementArray.push({
                        field: number,
                        value: null
                    });
                } else
                    this.measurementArray.push({
                        field: number,
                        value: this.fields[number].name
                    });
            }

            //poziv kontrolera za rad sa bazom
            try {
                axios.post("/api/usermeasurements", {
                    measurementArray: this.measurementArray,
                    userId: this.selectedUser.id
                });
                this.valuesChanged = 2;
            } catch (error) {
                this.valuesChanged = 0;
            }
        }
    },
    created() {
        this.loading = true;
        this.getSelectedUser();
        this.getMeasurements();
    }
};
</script>
<style lang="scss" scoped>
.btn {
    margin-top: 1.5%;
    height: 40px;
    width: 150px;
}
.btn-secondary {
    background-color: #6c757d;
}
.half_border {
    right: 60%;
}
img {
    width: 125px;
    height: 125px;
}
.rightbutton {
    display: flex;
    flex-direction: row-reverse;
}

.vselect
{
    width:70%;
}
@media screen and (max-width: 800px) {
    .rightbutton {
        flex-direction: row;
    }
}

</style>
