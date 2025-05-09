// app/javascript/controllers/search_guests_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "searchInput", "list"];

  // connect() {
  //   console.log(this.formTarget);
  //   console.log(this.searchInputTarget);
  //   console.log(this.listTarget);
  // }

  update() {
    const query = this.searchInputTarget.value;
    const url = `${this.formTarget.action}?query=${query}`;
    fetch(url, { headers: { Accept: "text/plain" } })
      .then((response) => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
      });
  }
}
