import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["info", "form", "editCancelButton", "photo"];

  // Define a target for guest info sections for easier querying
  get guestInfoTargets() {
    return this.element.querySelectorAll(".guest-info");
  }

  editCancelToggle() {
    // Loop through each pair of info and form fields
    this.guestInfoTargets.forEach((guestInfoElement) => {
      const formElement = guestInfoElement.querySelector(
        '[data-edit-guest-target="form"]'
      );
      const infoElement = guestInfoElement.querySelector(
        '[data-edit-guest-target="info"]'
      );

      // Toggle visibility
      infoElement.classList.toggle("hidden");
      formElement.classList.toggle("hidden");
    });

    this.editCancelButton();
    this.photoLabelToggle();
  }

  photoLabelToggle() {
    // Toggle visibility for the photo label and input
    const photoLabel = this.photoTarget.previousElementSibling; // Find the label
    photoLabel.classList.toggle("hidden");
    this.photoTarget.classList.toggle("hidden");
  }
  editCancelButton() {
    // Toggle visibility for the text of the edit cancel button

    this.editCancelButtonTarget.classList.toggle("bg-blue-500");
    this.editCancelButtonTarget.classList.toggle("hover:bg-blue-700");
    this.editCancelButtonTarget.classList.toggle("bg-yellow-500");
    this.editCancelButtonTarget.classList.toggle("hover:bg-yellow-700");

    this.editCancelButtonTarget.innerText =
      this.editCancelButtonTarget.innerText === "MODIFIER"
        ? "ANNULER"
        : "MODIFIER";
  }
}
