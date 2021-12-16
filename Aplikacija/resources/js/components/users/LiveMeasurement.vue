<!-- Parent komponenta za prikaz trenutnih velicina -->
<template>
    <div class="mreza poravnanje">
        <div class="background_image">
            <div class="register">
                <div v-if="!loading">
                    <div v-if="isLoggedIn">
                    
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
                                <field-component
                                    v-bind="measurement"
                                    :value="valueOfMeasurement(measurement)"
                                    :time_date ="dateOfMeasurement()"
                                ></field-component>
                            </div>
                            <div
                                class="col"
                                id="placeholder"
                                v-for="p in placeholdersInRow(row)"
                                :key="'placeholder' + row + p"
                            ></div>
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
import mqtt from "mqtt";

import FieldComponent from "./../users/FieldComponent.vue";
export default {
    name: "Live",
    components: { DataLoading, NoAccessPage, FieldComponent },
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
            id: this.$route.params.id,
            measurements: null,
            loading: false,
            columns: 3,
            value: null,
            enc: new TextDecoder("utf-8"),
            currentMessage: 'testna poruka',
            connection: {
                host: "mqtt3.thingspeak.com",
                port: 80,
                endpoint: "/mqtt",
                clean: true, // 保留会话
                connectTimeout: 4000, // 超时时间
                reconnectPeriod: 4000, // 重连时间间隔
                // 认证信息
                clientId: "IiEkOxwSFBgSDSsgOjwwGRM",
                username: "IiEkOxwSFBgSDSsgOjwwGRM",
                password: "8h/rK9iAn4M34bauwilICLp+"
            },
            subscription: {
                topic: "channels/1500203/subscribe",
                qos: 0
            },
            message: null,
            receiveNews: "",
            qosList: [
                { label: 0, value: 0 },
                { label: 1, value: 1 },
                { label: 2, value: 2 }
            ],
            client: {
                connected: false
            },
            subscribeSuccess: false
        };
    },

    methods: {
        //event koji se poziva prilikom promjene velicine ekrana, brise prazni placeholder div ukoliko je ekran manji od 1500px
         myEventHandler(e) {
                if(screen.width<1500)
                document.getElementById('placeholder').remove();
            },
        //measurementsInRow i placeHoldersInRow su funkcije koje postavljaju prazni div kao placeholder da bi tabela bila prikazana poravnato
        measurementsInRow(row) {
            return this.measurements.slice(
                (row - 1) * this.columns,
                row * this.columns
            );
        },
        placeholdersInRow(row) {
            return this.columns - this.measurementsInRow(row).length;
        },
            //kreira konekciju sa MQTT 
        createConnection() {
            const { host, port, endpoint, ...options } = this.connection;
            const connectUrl = `ws://${host}:${port}${endpoint}`;
            try {
                this.client = mqtt.connect(connectUrl, options);
            } catch (error) {
                console.log("mqtt.connect error", error);
            }
            this.client.on("connect", () => {
                console.log("Connection succeeded!");
            });
            this.client.on("error", error => {
                console.log("Connection failed", error);
            });
            this.client.on("message", (topic, message) => {
                this.receiveNews = this.receiveNews.concat(message);

                this.message = message;
                console.log(`Received message ${message} from topic ${topic}`);
            });
        },
        // pretplacuje se na MQTT kanal
        doSubscribe() {
            const { topic, qos } = this.subscription;
            this.client.subscribe(topic, { qos }, (error, res) => {
                if (error) {
                    console.log("Subscribe to topics error", error);
                    return;
                }
                this.subscribeSuccess = true;
                console.log("Subscribe to topics res", res);
            });
        },
        //  skida pretplatu sa MQTT kanala
        doUnSubscribe() {
            const { topic } = this.subscription;
            this.client.unsubscribe(topic, error => {
                if (error) {
                    console.log("Unsubscribe error", error);
                }
            });
        },
        // brise konekciju sa MQTT kanala
        destroyConnection() {
            if (this.client.connected) {
                try {
                    this.client.end();
                    this.client = {
                        connected: false
                    };
                    console.log("Successfully disconnected!");
                } catch (error) {
                    console.log("Disconnect failed", error.toString());
                }
            }
        },
        //poziv kontrolera koji vraca sve odabrane mjerne velicine za datog korisnika
        getMeasurementsFromUser() {
            try {
                axios
                    .post(`/api/getusermeasurements/${this.id}`)
                    .then(response => {
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
                        "https://api.thingspeak.com/channels/1500203/feeds.json?api_key=UYD0NKJ8ZVR8KQPY&results=1&round=2",
                        {
                            withCredentials: false
                        }
                    )
                    .then(response => {
                        this.message = response.data;
                        this.currentMessage=response.data;
                      
                    });
            } catch (error) {}
        },
        //dekodira mqtt poruku a zatim vraca vrijednost mjerene velicine
        valueOfMeasurement(measurement) {
            if (this.message instanceof Uint8Array) {               
                return JSON.parse(this.enc.decode(this.message))["field" + measurement.fieldId];
            } else return this.message.feeds[0]["field" + measurement.fieldId];
        },
         //dekodira mqtt poruku a zatim vraca datum mjerene velicine
        dateOfMeasurement(){
            if (this.message instanceof Uint8Array) {               
                return JSON.parse(this.enc.decode(this.message))["created_at"];
            } else return this.message.feeds[0]["created_at"];
        },
    },
    beforeMount() {
        this.getCurrentValue();

    },
    mounted(){
    this.createConnection();
    this.doSubscribe();
    },
    created() {
        this.loading = true;
        this.getMeasurementsFromUser();
        window.addEventListener("resize", this.myEventHandler);
    },

    beforeDestroy() {
        this.doUnSubscribe();
        this.destroyConnection();
    }
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
   background-image: linear-gradient(to bottom right,
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
}
</style>
