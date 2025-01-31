import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list", "transaction"];

  connect() {
    console.log("TransactionsListController is connected!");

    // Restore the scroll position when the page loads
    this.restoreScrollPosition();

    // Restore the selected transaction and scroll to it if needed
    this.restoreSelectedTransaction();
  }

  // Restore scroll position from localStorage
  restoreScrollPosition() {
    const savedScrollPosition = localStorage.getItem(
      "transactionsListScrollPosition"
    );
    if (savedScrollPosition && this.listTarget) {
      this.listTarget.scrollTop = parseInt(savedScrollPosition, 10); // Ensure it's an integer
    }
  }

  // Save the scroll position to localStorage before navigating
  saveScrollPosition() {
    if (this.listTarget) {
      localStorage.setItem(
        "transactionsListScrollPosition",
        this.listTarget.scrollTop
      );
    }
  }

  // Save the selected transaction ID to localStorage
  saveSelectedTransaction(event) {
    const selectedTransaction = event.currentTarget;
    localStorage.setItem(
      "selectedTransactionId",
      selectedTransaction.dataset.transactionId
    );
  }

  // Restore the selected transaction and scroll to it directly
  restoreSelectedTransaction() {
    const savedTransactionId = localStorage.getItem("selectedTransactionId");

    if (savedTransactionId && this.transactionTargets) {
      const selectedTransaction = this.transactionTargets.find(
        (transaction) =>
          transaction.dataset.transactionId === savedTransactionId
      );

      if (selectedTransaction) {
        this.highlight({ currentTarget: selectedTransaction });

        // Directly scroll to the selected transaction (without smooth scrolling)
        selectedTransaction.scrollIntoView({
          behavior: "auto",
          block: "center", // Scroll to the center of the container
          inline: "center", // Align the element horizontally in the center
        });
      }
    }
  }

  // Highlight the clicked transaction and save the selection
  highlight(event) {
    // Remove highlight from previously selected transaction
    if (this.selectedTransaction) {
      this.selectedTransaction.classList.remove(
        "border-customPink",
        "border-opacity-90",
        "bg-customPink",
        "bg-opacity-20",
        "text-customPink"
      );
      this.selectedTransaction.classList.add("border-white", "text-black"); // Reset to default
    }

    // Highlight the clicked transaction
    const selectedTransaction = event.currentTarget;
    selectedTransaction.classList.remove("border-white", "text-black");
    selectedTransaction.classList.add(
      "border-customPink",
      "border-opacity-90",
      "bg-customPink",
      "bg-opacity-20",
      "text-customPink"
    );

    // Store the new selected transaction
    this.selectedTransaction = selectedTransaction;

    // Save the ID of the selected transaction to localStorage
    this.saveSelectedTransaction(event);

    console.log("Highlighted transaction:", selectedTransaction);
  }
}
