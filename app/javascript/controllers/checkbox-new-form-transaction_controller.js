import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element
      .querySelectorAll(".service-name-checkbox")
      .forEach((checkbox) => {
        checkbox.addEventListener("change", this.checkboxChanged.bind(this));
      });
  }

  checkboxChanged(event) {
    const checkbox = event.target;
    const targetId = checkbox.dataset.target;
    const targetCheckbox = document.getElementById(targetId);

    if (checkbox.checked) {
      targetCheckbox.checked = true;
    } else {
      targetCheckbox.checked = false;
    }
  }
}
