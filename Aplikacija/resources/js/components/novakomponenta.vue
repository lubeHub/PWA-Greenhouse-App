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
            porukica:null
        };
    },
   
    methods: {
        createConnection() {
            axios.get('https://api.thingspeak.com/channels.json?api_key=LQEKPIVU3W4ZSH3I/').then(response => {
                this.porukica = response.data;
              
            });;
        },
      
    }
};
</script>
