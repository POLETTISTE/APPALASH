// app/javascript/controllers/transactions_list_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["transaction"];

  highlight(event) {
    this.transactionTargets.forEach((transaction) => {
      transaction.classList.remove("bg-lime-200");
    });
    event.currentTarget.classList.add("bg-lime-200");
  }
}
