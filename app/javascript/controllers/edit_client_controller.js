import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["info", "form", "editCancelButton"];

  // Define a target for client info sections for easier querying
  get clientInfoTargets() {
    return this.element.querySelectorAll(".client-info");
  }
  editCancelToggle() {
    // Loop through each pair of info and form fields
    this.clientInfoTargets.forEach((clientInfoElement) => {
      const formElement = clientInfoElement.querySelector(
        '[data-edit-client-target="form"]'
      );
      const infoElement = clientInfoElement.querySelector(
        '[data-edit-client-target="info"]'
      );

      // Toggle visibility
      infoElement.classList.toggle("hidden");
      formElement.classList.toggle("hidden");
    });
    this.button();
  }

  button() {
    // this.editButtonTarget.classList.toggle("hidden");
    // this.cancelButtonTarget.classList.toggle("hidden");
    this.editCancelButtonTarget.classList.toggle("bg-blue-500");
    this.editCancelButtonTarget.classList.toggle("hover:bg-blue-700");
    this.editCancelButtonTarget.classList.toggle("bg-yellow-500");
    this.editCancelButtonTarget.classList.toggle("hover:bg-yellow-700");
    // Toggle the button's inner text
    this.editCancelButtonTarget.innerText =
      this.editCancelButtonTarget.innerText === "MODIFIER"
        ? "ANNULER"
        : "MODIFIER";
  }
}
