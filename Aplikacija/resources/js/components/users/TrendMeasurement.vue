<!-- Parent komponenta za prikaz trenda velicina -->
<template>
    <div class="mreza poravnanje">
        <div class="background_image">
            <div class="register">
                <div v-if="!loading">
                    <div v-if="isLoggedIn">
                        <div class="row">
                            <div class="col-sm">
                                <v-select
                                    class="select"
                                    @input="getValuesFromDate"
                                    :options="[
                                        { value: '1', desc: 'Zadnjih 24 sata' },
                                        { value: '7', desc: 'Zadnjih 7 dana' },
                                        {
                                            value: '30',
                                            desc: 'Zadnjih 30 dana'
                                        },
                                        {
                                            value: '0',
                                            desc: 'Proizvoljan vremenski period'
                                        }
                                    ]"
                                    v-model="selected"
                                    :value="selected"
                                    label="desc"
                                ></v-select>
                            </div>
                            <div
                                class="datepicker col-sm"
                                v-if="this.customDateField"
                            >
                                <date-picker
                                    v-model="dateRange"
                                    range
                                    @close="customDate()"
                                ></date-picker>
                            </div>
                        </div>
                        <div
                            class="row mb-4"
                            v-for="row in rows"
                            :key="'row' + row"
                        >
                            <div
                                class="col d-flex align-items-stretch justify-content-center"
                                v-for="(measurement,
                                column) in measurementsInRow(row)"
                                :key="'row' + row + column"
                            >
                                <graph-component
                                    :key="graphKey"
                                    v-bind="measurement"
                                    :value="valueOfMeasurement(measurement)"
                                    :time_date="dateOfMeasurement()"
                                ></graph-component>
                            </div>
                            <!-- <div
                                id="placeholder"
                                class="col"
                                v-for="p in placeholdersInRow(row)"
                                :key="'placeholder' + row + p"
                            ></div> -->
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
import DatePicker from "vue2-datepicker";
import "vue2-datepicker/index.css";

import vSelect from "vue-select";
import "./../../../css/select.scss";
import DataLoading from "./../shared/DataLoading.vue";
import NoAccessPage from "./../shared/NoAccessPage.vue";
import { mapState } from "vuex";

import GraphComponent from "./GraphComponent.vue";
export default {
    name: "trend",
    components: {
        DataLoading,
        NoAccessPage,
        GraphComponent,
        DatePicker,
        vSelect
    },
    computed: {
        ...mapState({
            isLoggedIn: "isLoggedIn",
            loggedUser: "user"
        }),
        rows() {
            return this.measurements === null
                ? 0
                : Math.ceil(this.measurements.length / this.columns);
        }
    },
    data() {
        return {
            selected: null,
            graphKey: 0,
            dateKey: 0,
            id: this.$route.params.id,
            measurements: null,
            loading: false,
            columns: 3,
            enc: new TextDecoder("utf-8"),
            currentMessage: "testna poruka",
            message: null,

            customDateField: 0,
            firstDate: null,
            lastDate: null,
            dateRange: null
        };
    },

    methods: {
        measurementsInRow(row) {
            return this.measurements.slice(
                (row - 1) * this.columns,
                row * this.columns
            );
        },
        placeholdersInRow(row) {
            return this.columns - this.measurementsInRow(row).length;
        },
        //measurementsInRow i placeHoldersInRow su funkcije koje postavljaju prazni div kao placeholder da bi tabela bila prikazana poravnato
        myEventHandler(e) {
            if (screen.width < 1500)
                document.getElementById("placeholder").remove();
        },

        //poziva rest api za proizvoljni datum
        async customDate() {
            let preferableSize = 1440;
            let apiLink =
                "https://api.thingspeak.com/channels/1500203/feeds.json?api_key=UYD0NKJ8ZVR8KQPY&start=" +
                this.dateRange[0] +
                "&end=" +
                this.dateRange[1] +
                "&round=2&average=";

            try {
                await axios
                    .get(apiLink + preferableSize, {
                        withCredentials: false
                    })
                    .then(response => {
                        this.message = response.data;
                    });
                this.graphKey += 1;
            } catch (error) {}
        },
        //poziv kontrolera koji vraca sve odabrane mjerne velicine za datog korisnika
        getMeasurementsFromUser() {
            this.loading = true;
            try {
                axios.post(`/api/getusermeasurements/${this.id}`).then(response => {
                    this.measurements = response.data;
                    this.loading = false;
                });
            } catch (error) {}
        },
        //vraca trenutne vrijednosti mjerenja, REST API
        getCurrentValue() {
            try {
                axios
                    .get(
                        "https://api.thingspeak.com/channels/1500203/feeds.json?api_key=UYD0NKJ8ZVR8KQPY&days=1&round=2&average=60",
                        {
                            withCredentials: false
                        }
                    )
                    .then(response => {
                        this.selected = { value: "1", desc: "Zadnjih 24 sata" };
                        this.message = response.data;
                        this.currentMessage = response.data;
                    });
            } catch (error) {}
        },

        // vraca niz vrijednosti mjerenih velicina
        valueOfMeasurement(measurement) {
            let arrayOfValues = [];
            let counter = 0;

            for (counter; counter < this.message.feeds.length; counter++) {
                arrayOfValues.push(
                    this.message["feeds"][counter][
                        "field" + measurement.fieldId
                    ]
                );
            }
            return arrayOfValues;
        },

        //Ukoliko je izabrana opcija zadnjih 24h vraca sate mjerenja jedinica, u suprotnom vraca datum mjerenja jedinica
        dateOfMeasurement() {
            let arrayOfTimes = [];
            let counter = 0;
            for (counter; counter < this.message.feeds.length; counter++) {
                arrayOfTimes.push(this.message["feeds"][counter]["created_at"]);
            }

            if (this.selected.value == 1) {
                return this.isoTimeToNormal(arrayOfTimes);
            } else return this.isoDateToNormal(arrayOfTimes);
        },

        //konvertuje IsoDate u hh:mm format
        isoTimeToNormal(time_date) {
            let arrayOfTimes = [];
            for (let i = 0; i < time_date.length; i++) {
                arrayOfTimes.push(
                    new Date(time_date[i]).toLocaleTimeString("en", {
                        timeStyle: "short",
                        hour12: false,
                        timeZone: "CET"
                    })
                );
            }
            return arrayOfTimes;
        },

        //konvertuje IsoDate u dd/MM format
        isoDateToNormal(time_date) {
            let arrayOfDates = [];
            for (let i = 0; i < time_date.length; i++) {
                arrayOfDates.push(
                    new Date(time_date[i]).toLocaleDateString("en-GB", {
                        day: "2-digit",
                        month: "2-digit",
                        timeZone: "CET"
                    })
                );
            }
            return arrayOfDates;
        },

        /*Ukoliko je izabrana opcija zadnjih 24h poziva API koji vraca prosjecnu velicinu mjerenja vrsenih svakih 1h,
     u suprotnom poziva API koji vraca prosjecnu velicinu mjerenja vrsenih svakih 24h */
        async getValuesFromDate() {
            if (this.selected.value != 0) {
                this.customDateField = 0;
                let apiLink =
                    "https://api.thingspeak.com/channels/1500203/feeds.json?api_key=UYD0NKJ8ZVR8KQPY&days=" +
                    this.selected.value +
                    "&round=2&average=";
                let preferableSize = 0;

                if (this.selected.value > 1) {
                    preferableSize = 1440;
                } else {
                    preferableSize = 60;
                }
                try {
                    await axios
                        .get(apiLink + preferableSize, {
                            withCredentials: false
                        })
                        .then(response => {
                            this.message = response.data;
                        });
                    this.graphKey += 1;
                } catch (error) {}
            } else {
                this.customDateField = 1;
            }
        }
    },
    beforeCreate() {},
    beforeMount() {
        this.getCurrentValue();
    },
    mounted() {},
    created() {
        this.getMeasurementsFromUser();
        window.addEventListener("resize", this.myEventHandler);
    },
    beforeUpdate() {},
    update() {},

    beforeDestroy() {}
};
</script>
<style lang="scss" scoped>
.btn {
    height: 40px;
    width: 150px;
}
.btn-secondary {
    background-color: #6c757d;
}
.mreza {
    width: 100%;
}
.background_image {
    background-image: linear-gradient(
            to bottom right,
            rgba(40, 42, 55, 1),
            rgba(40, 42, 55, 0.93),
            rgba(40, 42, 55, 0.9),
            rgba(40, 42, 55, 0.9),
            rgba(40, 42, 55, 0.9),
            rgba(40, 42, 55, 0.8)
        ),
        url("http://127.0.0.1:8000/images/wallpaper.jpg");
    background-size: cover;
}

.register {
    min-height: 100vh;
    padding-top: 0;
}
.select {
    width: 300px;
}
.wrapper {
    position: relative;
    display: block;
    justify-content: center;
    align-content: center;
    height: 40px;
}
.wrapper-text {
    font-size: 20px;
    text-shadow: 7px 7px 7px #000;
}
</style>
