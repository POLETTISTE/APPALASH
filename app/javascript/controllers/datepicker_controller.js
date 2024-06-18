import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import { French } from "flatpickr/l10n/fr";

export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      locale: French,
      dateFormat: "d-m-Y",
    });
  }
}
