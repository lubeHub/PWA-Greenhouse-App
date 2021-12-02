 <!-- Child komponenta zaprikaz trenutnih velicina -->
<template
    ><div class="field">
        <!-- <div>
            <label class="gray-label">Polje {{ fieldId }}: </label>
        </div> -->
        <div class="drop1">
            <div class="description">
                <div id="name">{{ name }}</div>
                <div id="info"></div>
            </div>
            <div class="measurement">
                <img :src="baseUrl + url"/>
               <div class="graph"><chart-component :key="graphKey" :width="this.setGraphWidth()" :height="this.setGraphHeight()" :value="value" :labels="time_date"></chart-component></div> 
            </div>
        </div>
    </div>
</template>

<script>
import ChartComponent from "./../chart";

export default {
    name: "GraphComponent",
    props: ["name", "unit", "fieldId", "url", "value", "time_date"],
    components: { ChartComponent },
    data() {
        return {
            baseUrl: "http://127.0.0.1:8000/images/icons/",
            time: null,
            date: null,
            graphKey:0,
            graphWidth:0,
            graphHeight:0,
            
        }
    },
    methods: {
        //zaokruzuje broj na 2 decimale
        toDecimal(value) {
            return parseFloat(value).toFixed(2);
        },
        //podesava visinu grafikona u zavisnosti od sirine ekrana
       setGraphHeight(){
             if(screen.width<500){
               return 150;
           } 
           else return 200;
       },
       //podesava sirinu grafikona u zavisnosti od sirine ekrana
       setGraphWidth()
       {
           if(screen.width<500){
               return 200;
           } 
           else return 300;
           
       },
       //event koji se poziva prilikom promijene velicine ekrana i poziva
        myEventHandler(e) {
         this.graphKey+=1;
  }
                                                                                                                                                                            
},
created() {
  window.addEventListener("resize", this.myEventHandler);
},
destroyed() {
  window.removeEventListener("resize", this.myEventHandler);
},
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
    margin-top: 10%;
}
.field {
    width: 450px;
    height: 250px;
    margin-bottom: 5%;

    margin-top: 3%;
    font-family: "Rajdhani", sans-serif;
}

.drop1 {
     background-color: rgba(46, 93, 131, 0.3);
    width: 450px;
    height: 250px;
    position: absolute;
    display: block;
    margin: 0 auto;
    border-radius: 15px;
    /* z-index: 2; */
    backdrop-filter: blur(10px);
}
.measurement {
    padding-top: 1%;
    display: flex;
}
#name {
    /* background-color:gray; */
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
    font-size: small;
    /* background-color:purple; */

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
@media screen and (max-width: 500px) {
  .field, .drop1{
    width: 300px;
    height: 200px; 
  }
  img{
      margin-top:5%;
  }
}
.graph{
    margin-left:5%;
}
</style>
