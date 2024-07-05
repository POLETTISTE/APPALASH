import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "preview"];

  connect() {
    this.checkExistingPhoto(); // Call this method to initially check if there's an existing photo or preview
    this.inputTarget.addEventListener("change", this.displayPreview.bind(this)); // Bind displayPreview to input change event
    document
      .getElementById("remove-photo")
      .addEventListener("click", this.removePreview.bind(this)); // Bind removePreview to remove button click event
  }

  displayPreview(event) {
    const reader = new FileReader();
    reader.onload = (event) => {
      this.previewTarget.src = event.currentTarget.result;
    };
    reader.readAsDataURL(this.inputTarget.files[0]);
    this.previewTarget.classList.remove("d-none");

    this.toggleRemoveButton(true); // Show the remove button
  }

  removePreview() {
    this.inputTarget.value = "";
    this.previewTarget.src = "";
    this.previewTarget.classList.add("d-none");

    this.toggleRemoveButton(false); // Hide the remove button
  }

  toggleRemoveButton(show) {
    const removeButton = document.getElementById("remove-photo");
    if (removeButton) {
      if (show) {
        removeButton.classList.remove("d-none");
      } else {
        removeButton.classList.add("d-none");
      }
    }
  }

  checkExistingPhoto() {
    const existingPhoto = document.getElementById("existing-photo");
    const previewImage = document.getElementById("preview-image");

    if (
      (existingPhoto &&
        existingPhoto.querySelector("img") &&
        existingPhoto.querySelector("img").getAttribute("src")) ||
      (previewImage &&
        !previewImage.classList.contains("d-none") &&
        previewImage.getAttribute("src"))
    ) {
      this.toggleRemoveButton(true);
    } else {
      this.toggleRemoveButton(false);
    }
  }
}
