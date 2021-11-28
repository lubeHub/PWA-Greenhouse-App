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
                                class="col d-flex align-items-stretch"
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
import DataLoading from "./../DataLoading.vue";
import NoAccessPage from "./../NoAccessPage.vue";
import { mapState } from "vuex";
import mqtt from "mqtt";

import FieldComponent from "./../users/FieldComponent.vue";
export default {
    name: "ManageUser",
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
        measurementsInRow(row) {
            return this.measurements.slice(
                (row - 1) * this.columns,
                row * this.columns
            );
        },
        placeholdersInRow(row) {
            return this.columns - this.measurementsInRow(row).length;
        },

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
        // 订阅主题
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
        // 取消订阅
        doUnSubscribe() {
            const { topic } = this.subscription;
            this.client.unsubscribe(topic, error => {
                if (error) {
                    console.log("Unsubscribe error", error);
                }
            });
        },
        // 断开连接
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

        getCurrentValue() {
            try {
                axios
                    .get(
                        "https://api.thingspeak.com/channels/1500203/feeds.json?api_key=UYD0NKJ8ZVR8KQPY&results=1",
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

        valueOfMeasurement(measurement) {
            if (this.message instanceof Uint8Array) {               
                return JSON.parse(this.enc.decode(this.message))["field" + measurement.fieldId];
            } else return this.message.feeds[0]["field" + measurement.fieldId];
        },
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
        console.log("monuted")

    },
    created() {
        this.loading = true;
        this.getMeasurementsFromUser();
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
    background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2)),
        url("http://127.0.0.1:8000/images/wallpaper.jpg");
    background-size: cover;
}

.register {
    min-height: 100vh;
}
</style>
