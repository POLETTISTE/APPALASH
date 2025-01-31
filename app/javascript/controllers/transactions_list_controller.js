import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list", "transaction"];

  connect() {
    console.log("TransactionsListController is connected!");

    const savedScrollPosition = localStorage.getItem(
      "transactionsListScrollPosition"
    );
    if (savedScrollPosition) {
      this.listTarget.scrollTop = savedScrollPosition;
    }

    // Ensure only one transaction is highlighted on page load
    this.transactionTargets.forEach((transaction) => {
      if (transaction.classList.contains("border-customPink")) {
        this.selectedTransaction = transaction; // Store reference
      } else {
        transaction.classList.add("border-white");
      }
    });
  }

  saveScrollPosition() {
    localStorage.setItem(
      "transactionsListScrollPosition",
      this.listTarget.scrollTop
    );
  }

  highlight(event) {
    // Remove highlight from previously selected transaction
    if (this.selectedTransaction) {
      this.selectedTransaction.classList.remove(
        "border-customPink",
        "border-opacity-70",
        "bg-customPink",
        "bg-opacity-20"
      );
      this.selectedTransaction.classList.add("border-white");
    }

    // Highlight the clicked transaction
    const selectedTransaction = event.currentTarget;
    selectedTransaction.classList.remove("border-white");
    selectedTransaction.classList.add(
      "border-customPink",
      "border-opacity-70",
      "bg-customPink",
      "bg-opacity-20"
    );

    // Store the new selected transaction
    this.selectedTransaction = selectedTransaction;

    console.log("Highlighted transaction:", selectedTransaction);
  }
}
