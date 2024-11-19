import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="photo-preview"
export default class extends Controller {
  static targets = ["input", "preview", "originalAvatar"];

  displayPreview(event) {
    const reader = new FileReader();

    reader.onload = (event) => {
      // Set the preview image source to the file's data URL
      this.previewTarget.src = event.currentTarget.result;
      this.previewTarget.classList.remove("hidden");
      // Hide the original avatar image when preview is visible
      this.originalAvatarTarget.classList.add("hidden");
    };

    // Read the selected file as data URL
    reader.readAsDataURL(this.inputTarget.files[0]);
  }
}
