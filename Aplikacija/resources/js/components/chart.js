
import { Line } from "vue-chartjs";

export default {
  extends: Line,
   props: {
       labels:{
           type:Array,
           default:null
       },
    value: {
      type: Array,
      default: null
    },},
  data() {
    return {
        gradient: null,
        options: {
            legend: {
                display: false
            },
            backgroundColor: "rgb(255,0,0)",
            responsive: false,
            maintainAspectRatio: false,
            scales: {
                yAxes: [
                    {
                        ticks: {
                            fontColor: "white",
                            beginAtZero: true
                        }
                    }
                ],
                xAxes: [
                    {
                        ticks: {
                            fontColor: "white",
                            fontSize: 12,
                            stepSize: 1,
                            beginAtZero: true
                        }
                    }
                ]
            }
        }
    };
  },
  mounted() {
    this.gradient = this.$refs.canvas
      .getContext("2d")
      .createLinearGradient(0, 0, 0, 450);
    
    this.gradient.addColorStop(0, "rgba(29, 144, 244,0.5)");
    this.gradient.addColorStop(0.5, "rgba(29, 144, 244,0.3)");
    this.gradient.addColorStop(1, "rgba(29, 144, 244,0)");


    this.renderChart(
        {
            labels: this.labels,
            datasets: [
                {
                    pointBackgroundColor: "rgba(29, 144, 244,1)",
                    borderWidth: 1,
                    borderColor: "rgba(29, 144, 244,1)",
                    data: this.value
                }
            ]
        },
        this.options
    );
  }
};

