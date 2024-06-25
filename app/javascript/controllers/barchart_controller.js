import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

export default class extends Controller {
  static targets = ["myBarChart"];
  data = {}; // Initialize data as an empty object

  async connect() {
    await this.fetchData();
    this.renderChart();
  }

  async fetchData() {
    const response = await fetch("/dashboard.json"); // Adjust URL based on your route
    const jsonData = await response.json();
    this.data = jsonData; // Update this.data with fetched data
  }

  renderChart() {
    if (Object.keys(this.data).length === 0) {
      // Handle case where data hasn't been fetched yet
      return;
    }

    Chart.register(...registerables); // Register all necessary components including scales

    new Chart(this.myBarChartTarget.getContext("2d"), {
      type: "bar",
      data: {
        labels: Object.keys(this.data.client_counts), // Assuming names are labels
        datasets: [
          {
            label: [],
            data: Object.values(this.data.client_counts),
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
        scales: {
          y: {
            type: "linear", // Ensure scale type is specified correctly
            beginAtZero: true,
          },
          x: {
            type: "category", // Assuming categorical x-axis
          },
        },
        plugins: {
          legend: {
            display: false, // Hide the legend
            onClick: null, //stop click legend
          },
        },
      },
    });
  }
}
