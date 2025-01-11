import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";
export default class extends Controller {
  static targets = ["myDonutsChart"];
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

    //stylesheet color from root scss
    const customBlueColor = getComputedStyle(document.documentElement)
      .getPropertyValue("--blue")
      .trim();

    const customPinkColor = getComputedStyle(document.documentElement)
      .getPropertyValue("--pink")
      .trim();

    new Chart(this.myDonutsChartTarget.getContext("2d"), {
      type: "doughnut",
      data: {
        labels: Object.keys(this.data.client_know_us),
        datasets: [
          {
            label: "",
            data: Object.values(this.data.client_know_us),
            backgroundColor: [
              customBlueColor,
              customPinkColor,
              "rgb(215, 5, 6)",
              "rgb(215, 105, 6)",
              "rgb(255, 255, 255)",
              "rgb(25, 255, 255)",
            ],
            hoverOffset: 4,
          },
        ],
      },
      options: {
        responsive: true,

        // scales: {
        //   y: {
        //     type: "linear", // Ensure scale type is specified correctly
        //     beginAtZero: true,
        //   },
        //   x: {
        //     type: "category", // Assuming categorical x-axis
        //   },
        // },
        plugins: {
          legend: {
            // display: false, // Hide the legend
            onClick: null, //stop click legend
          },
        },
      },
    });
  }
}
