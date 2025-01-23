// app/javascript/controllers/transactions_list_controller.js
import { Controller } from "@hotwired/stimulus";

// Permit the controller to target the list and transaction elements in the list when clicking on the show of a transaction
export default class extends Controller {
  static targets = ["list", "transaction"]; // Targeting the list and transactions

  connect() {
    console.log("TransactionsListController is connected!");

    // Restore the scroll position when the page loads
    const savedScrollPosition = localStorage.getItem(
      "transactionsListScrollPosition"
    );
    if (savedScrollPosition) {
      this.listTarget.scrollTop = savedScrollPosition;
    }

    // Scroll directly to the selected transaction if one is highlighted
    const selectedTransaction = this.transactionTargets.find((transaction) =>
      transaction.classList.contains("bg-lime-200")
    );
    if (selectedTransaction) {
      selectedTransaction.scrollIntoView({ block: "center" }); // Instant scroll, no animation
    }
  }

  saveScrollPosition() {
    // Save the scroll position before navigating away
    localStorage.setItem(
      "transactionsListScrollPosition",
      this.listTarget.scrollTop
    );
  }

  highlight(event) {
    // Remove highlight from all transactions
    this.transactionTargets.forEach((transaction) => {
      transaction.classList.remove("bg-lime-200");
    });

    // Highlight the clicked transaction
    const selectedTransaction = event.currentTarget;
    selectedTransaction.classList.add("bg-lime-200");

    console.log("Highlighted transaction:", selectedTransaction);
  }
}
