import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

export default class extends Controller {
  static targets = ["myBarChart"];
  barChartData = {}; // Initialize barChartData as an empty object

  connect() {
    try {
      // Parse JSON data from the HTML data attribute
      const clientCountsData = this.element.dataset.barchartClientCounts;
      this.barChartData = JSON.parse(clientCountsData); // Use barChartData instead of data
      this.renderBarChart();
    } catch (error) {
      console.error("Error parsing JSON data for BarChart:", error);
    }
  }

  renderBarChart() {
    if (Object.keys(this.barChartData).length === 0) {
      // Handle case where barChartData hasn't been initialized
      return;
    }

    Chart.register(...registerables); // Register all necessary components

    new Chart(this.myBarChartTarget.getContext("2d"), {
      type: "bar",
      data: {
        labels: Object.keys(this.barChartData), // Assuming names are labels
        datasets: [
          {
            label: "Clients",
            data: Object.values(this.barChartData),
            backgroundColor: [
              "rgba(255, 99, 132, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(255, 206, 86, 0.2)",
              "rgba(75, 192, 192, 0.2)",
              "rgba(153, 102, 255, 0.2)",
              "rgba(255, 159, 64, 0.2)",
            ],
            borderColor: [
              "rgba(255, 99, 132, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 206, 86, 1)",
              "rgba(75, 192, 192, 1)",
              "rgba(153, 102, 255, 1)",
              "rgba(255, 159, 64, 1)",
            ],
            borderWidth: 1,
          },
        ],
      },
      options: {
        responsive: false,
        scales: {
          y: {
            beginAtZero: true,
          },
          x: {
            type: "category",
          },
        },
        plugins: {
          legend: {
            // display: true,
          },
        },
      },
    });
  }
}
