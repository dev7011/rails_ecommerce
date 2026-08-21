import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"
Chart.register(...registerables)

// Connects to data-controller="dashboard"
export default class extends Controller {
  myChart;
  addChart(){
      this.myChart.data.datasets.push({
        label: 'Dataset ' + (this.myChart.data.datasets.length + 1),
        data: [
          40,
          70,
          50,
          60,
          90,
          45,
          80
        ],
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        borderColor: 'rgb(54, 162, 235)',
        borderWidth: 1
      });

      this.myChart.update();
    }

  chartBar(selector){
    const labels = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July"
    ]
    const data = {
      labels: labels,
      datasets: [{
        label: 'My First Dataset',
        data: [65, 59, 80, 81, 56, 55, 40],
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 159, 64, 0.2)',
          'rgba(255, 205, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(201, 203, 207, 0.2)'
        ],
        borderColor: [
          'rgb(255, 99, 132)',
          'rgb(255, 159, 64)',
          'rgb(255, 205, 86)',
          'rgb(75, 192, 192)',
          'rgb(54, 162, 235)',
          'rgb(153, 102, 255)',
          'rgb(201, 203, 207)'
        ],
        borderWidth: 1
      }]
    };

    const options = {
      scales: {
        y: {
          beginAtZero: true
        }
      },

      animation: {
        duration: 1000,
        easing: 'easeOutBounce',
        delay: 500,
        loop: false
      }
    }

    const ctx = document.getElementById(selector);

    this.myChart = new Chart(ctx, {
      type: 'bar',
      data: data,
      options: options
    });
  }

  chartDoughnut(selector){
    const data = {
      labels: [
        'Red',
        'Blue',
        'Yellow'
      ],

      datasets: [{
        label: 'My First Dataset',
        data: [300, 50, 100],
        backgroundColor: [
          'rgb(255, 99, 132)',
          'rgb(54, 162, 235)',
          'rgb(255, 205, 86)'
        ],
        borderColor: [
          'rgb(255, 205, 86)',
          'rgb(255, 99, 132)',
          'rgb(54, 162, 235)'
          ],
        hoverOffset: 4
      }]
    };
    Chart.defaults.elements.arc.borderWidth = 5;
    const ctx = document.getElementById(selector);
    new Chart(ctx, {
      type: 'doughnut',
      data: data
    });
  }

  chartLine(selector){
    const labels = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July"
    ]
    const data = {
      labels: labels,
      datasets: [{
        label: 'My First Dataset',
        data: [65, 59, 80, 81, 56, 55, 40],
        fill: false,
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1
      }]
    };

    const options = {
      scales: {
        y: {
          ticks: {
            // Include a dollar sign in the ticks
            callback: function(value, index, ticks) {
              return '$' + value;
            }
          }
        }
      }
    }

    const ctx = document.getElementById(selector);
    new Chart(ctx, {
      type: 'line',
      data: data,
      options: options
    });
  }



  connect() {
    this.chartBar("chartBar")
    this.chartDoughnut("chartDoughnut")
    this.chartLine("chartLine")
  }
}
