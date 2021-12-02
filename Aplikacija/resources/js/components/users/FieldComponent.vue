   <!-- Child komponenta za prikaz trenutnih velicina -->

<template
    ><div class="field">
        <!-- <div>
            <label class="gray-label">Polje {{ fieldId }}: </label>
        </div> -->
        <div class="drop1">
            <div class="description">
                <div id="name">{{ name }}</div>
                <div id="info">
                   {{isoTimeToNormal(time_date)}}  {{ isoDateToNormal(time_date) }}
                </div>
            </div>
            <div class="measurement">
                <img :src="baseUrl + url" />
                <label id="value"
                    >{{ toDecimal(value)
                    }}<span id="unit">{{ unit }}</span></label
                >
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: "FieldComponent",
    props: ["name", "unit", "fieldId", "url", "value", "time_date"],
    data() {
        return {
            baseUrl: "http://127.0.0.1:8000/images/icons/",
            time: null,
            date: null
        };
    },
    methods: {
        //zaokruzuje broj na 2 decimale
        toDecimal(value) {
            return parseFloat(value).toFixed(2);
        },
        //konvertuje IsoDate u dd/MM format
        isoDateToNormal(time_date) {
           return new Date(time_date).toLocaleDateString("en-GB", {
                day: "2-digit",
                month: "2-digit",
                timeZone: "CET"
            });
            
        },
        //konvertuje IsoDate u hh:mm format
        isoTimeToNormal(time_date) {
            return new Date(time_date).toLocaleTimeString("en", {
                timeStyle: "short",
                hour12: false,
                timeZone: "CET"
            });
        }
    }
};
</script>
<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Rajdhani:wght@500&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Sora:wght@200&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Patrick+Hand&display=swap");
img {
    height: 64px;
    width: 64px;
    margin-left: 10%;
    margin-top: 5%;
}
.field {
    width: 300px;
    height: 200px;
    margin-bottom: 5%;
    margin-top: 3%;
    font-family: "Rajdhani", sans-serif;
}

.drop1 {
    background-color: rgba(46, 93, 131, 0.3);
    width: 300px;
    height: 200px;
    position: absolute;
    display: block;
    margin: 0 auto;
    border-radius: 15px;
    backdrop-filter: blur(10px);
}
.measurement {
    padding-top: 5%;
    display: flex;
}
#name {
    font-size: larger;
    margin-bottom: 0;
    border-radius: 10px;
}
#value {
    font-size: 4rem;
    margin-left: 7%;
    text-shadow: 4px 4px 4px #000;
}
#info {
    font-size: 14px;
    border-radius: 10px;
}
.description {
    text-align: left;
    text-shadow: 4px 4px 4px #000;
    border-radius: 10px;
    margin-left: 5%;
    margin-top: 5%;
}
#unit {
    font-size: 2.5rem;
}
</style>
