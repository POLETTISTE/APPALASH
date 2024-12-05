import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="photo-preview"
export default class extends Controller {
  static targets = ["input", "preview"];

  // Display preview image when a file is selected
  displayPreview(event) {
    const reader = new FileReader();

    reader.onload = (event) => {
      // Set the preview image source to the file's data URL
      this.previewTarget.src = event.currentTarget.result;
      this.previewTarget.classList.remove("hidden");
    };

    // Read the selected file as data URL
    reader.readAsDataURL(this.inputTarget.files[0]);
  }

  // Update the preview after the form is submitted
  connect() {
    // Ensure the preview is hidden and the original avatar is visible if there is no new avatar
    if (this.inputTarget.files.length === 0) {
      this.previewTarget.classList.add("hidden");
    }
  }
}
