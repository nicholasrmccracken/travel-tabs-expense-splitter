import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "button", "list"];
  static values = { tripId: String };

  connect() {
    console.log("Email List Controller connected");

    // Guard clause to prevent execution on pages without necessary targets/values
    if (!this.hasInputTarget || !this.hasButtonTarget || !this.hasListTarget || !this.hasTripIdValue) {
      console.warn("Email List Controller: Required elements not found. Skipping initialization.");
      return;
    }
  }

  // Utility function to create a new email item
  createEmailItem(email) {
    const emailItem = document.createElement("div");
    emailItem.className = "flex justify-between items-center border border-gray-300 rounded px-3 py-2";

    const emailSpan = document.createElement("span");
    emailSpan.textContent = email;

    const hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "trip[participant_emails][]";
    hiddenInput.value = email;

    const removeButton = document.createElement("button");
    removeButton.type = "button";
    removeButton.className = "remove-email-button w-1/4 bg-red-500 text-off_white px-4 py-2 rounded hover:bg-off_white hover:text-red-500 focus:ring focus:ring-secondary-red focus:outline-none button-animation";
    removeButton.textContent = "Remove";

    // Remove the email item when the remove button is clicked
    removeButton.addEventListener("click", () => {
      this.listTarget.removeChild(emailItem);
    });

    emailItem.appendChild(emailSpan);
    emailItem.appendChild(hiddenInput);
    emailItem.appendChild(removeButton);

    return emailItem;
  }

  // Function to add a new email to the list
  addEmail(email) {
    const existingEmails = Array.from(this.listTarget.querySelectorAll('input[name="trip[participant_emails][]"]'))
      .map(input => input.value);

    if (existingEmails.includes(email)) {
      alert("This email is already added!");
      return;
    }

    const emailItem = this.createEmailItem(email);
    this.listTarget.appendChild(emailItem);
  }

  // Verify email is associated with an account
  async verifyEmail(email) {
    try {
      const response = await fetch(`/users/verify_email?email=${encodeURIComponent(email)}`);
      if (!response.ok) {
        throw new Error(`Failed to verify email: ${response.statusText}`);
      }

      const data = await response.json();
      return data.exists;
    } catch (error) {
      console.error("Error verifying email:", error);
      return false;
    }
  }

  // Handle add email button click
  async addEmailHandler(event) {
    event.preventDefault();

    const email = this.inputTarget.value.trim();

    if (!email) {
      alert("Please enter an email.");
      return;
    }

    const emailIsValid = await this.verifyEmail(email);
    if (!emailIsValid) {
      alert("This email is not associated with any account.");
      return;
    }

    this.addEmail(email);
    this.inputTarget.value = "";
  }
}
