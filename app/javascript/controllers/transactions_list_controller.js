import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list", "transaction"];

  connect() {
    console.log("TransactionsListController is connected!");

    // Restore the scroll position when the page loads
    this.restoreScrollPosition();

    // Restore the selected transaction or highlight the first one if none is stored
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

  // Restore the selected transaction and scroll to it directly, or select the first one if none exists
  restoreSelectedTransaction() {
    const savedTransactionId = localStorage.getItem("selectedTransactionId");

    // Clear any previous selection before restoring the current one
    this.clearSelection();

    // If there's a saved transaction ID in localStorage, select and highlight it
    if (savedTransactionId) {
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
    } else {
      // If no saved transaction ID, highlight and select the first transaction
      const firstTransaction = this.transactionTargets[0];

      if (firstTransaction) {
        this.highlight({ currentTarget: firstTransaction });

        // Optionally, scroll to the first item if desired
        firstTransaction.scrollIntoView({
          behavior: "auto",
          block: "center",
          inline: "center",
        });
      }
    }
  }

  // Clear any previously highlighted transaction
  clearSelection() {
    // Remove highlight from previously selected transaction if it exists
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

    // Optionally, remove highlight classes from all transactions to ensure no overlap
    this.transactionTargets.forEach((transaction) => {
      transaction.classList.remove(
        "border-customPink",
        "border-opacity-90",
        "bg-customPink",
        "bg-opacity-20",
        "text-customPink"
      );
      transaction.classList.add("border-white", "text-black"); // Reset to default
    });
  }

  // Highlight the clicked transaction and save the selection
  highlight(event) {
    const selectedTransaction = event.currentTarget;

    // Clear any previous selection immediately (remove old highlight)
    this.clearSelection();

    // Highlight the new clicked transaction
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
