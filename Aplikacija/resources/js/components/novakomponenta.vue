<template>
    <div>
        <button class="btn" @click="createConnection">Connect to it</button>

        {{ porukica }}
    </div>
</template>

<script>
export default {
    name: "komponenta",
    data() {
        return {
            porukica: null
        };
    },

    methods: {
        createConnection() {

            axios.get("https://api.thingspeak.com/channels/1500203/fields/2.json?api_key=UYD0NKJ8ZVR8KQPY", {
                withCredentials: false,
            })  .then(response => {
                    this.porukica = response.data;
                });;
        }
    }
};
</script>
