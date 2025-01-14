import { Controller } from "@hotwired/stimulus";
import { Chart, registerables } from "chart.js";

export default class extends Controller {
  static targets = ["myDonutsChart"]; // Define the canvas target for the donut chart
  chartData = {}; // Custom property to store chart data

  connect() {
    try {
      // Parse JSON data from the dataset
      const howDoYouKnowUsData = this.element.dataset.donutschartClientCounts;
      this.chartData = JSON.parse(howDoYouKnowUsData); // Safely parse JSON
      console.log("Parsed donut chart data:", this.chartData); // Debug log

      // Render the donut chart
      this.renderChart();
    } catch (error) {
      console.error("Error parsing JSON data for DonutChart:", error);
    }
  }

  renderChart() {
    if (Object.keys(this.chartData).length === 0) {
      console.warn("No data available for rendering the donut chart.");
      return;
    }

    Chart.register(...registerables); // Register Chart.js components

    // Custom plugin to draw labels inside the donut chart segments
    const insideLabelsPlugin = {
      id: "insideLabels",
      afterDatasetDraw(chart) {
        // Apply the plugin only for donut charts
        if (chart.config.type === "doughnut") {
          const { ctx } = chart;
          const dataset = chart.data.datasets[0];
          const total = dataset.data.reduce((sum, value) => sum + value, 0);

          dataset.data.forEach((value, index) => {
            const label = chart.data.labels[index];
            const percentage = ((value / total) * 100).toFixed(1) + "%";
            const meta = chart.getDatasetMeta(0);
            const arc = meta.data[index];
            const centerPoint = arc.getCenterPoint();

            ctx.save();
            ctx.font = "12px Arial";
            ctx.fillStyle = "black"; // Set the text color
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            ctx.fillText(label, centerPoint.x, centerPoint.y - 8); // Label name
            ctx.fillText(percentage, centerPoint.x, centerPoint.y + 8); // Percentage
            ctx.restore();
          });
        }
      },
    };

    // Register the custom plugin
    Chart.register(insideLabelsPlugin);

    // Render the donut chart
    new Chart(this.myDonutsChartTarget.getContext("2d"), {
      type: "doughnut", // Specify the chart type as 'doughnut'
      data: {
        labels: Object.keys(this.chartData), // Labels for the chart
        datasets: [
          {
            data: Object.values(this.chartData), // Data for each section
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
        plugins: {
          legend: {
            display: false, // Hide legend for this chart
          },
        },
      },
    });
  }
}
