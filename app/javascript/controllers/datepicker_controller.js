import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import { French } from "flatpickr/l10n/fr"; // Use correct import path

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      locale: French, // Set the locale to French
      dateFormat: "d-m-Y", // Set the desired date format
    });
  }
}
