<template>
    <div>
        <button class="btn" @click="createConnection">Connect to it</button>
        <button class="btn" @click="doSubscribe">Pretplati</button>
        {{ porukica }}
    </div>
</template>

<script>
import mqtt from "mqtt";
export default {
    name: "Home",
    data() {
        return {
            porukica: "testna poruka",
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
    created() {
        createConnection();
        doSubscribe();
    },
    methods: {
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
                this.porukica = message;
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
        }
    }
};
</script>
