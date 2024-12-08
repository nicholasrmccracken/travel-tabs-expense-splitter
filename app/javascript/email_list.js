document.addEventListener('DOMContentLoaded', () => {
    const emailInput = document.querySelector('input[name="participant_email"]');
    const addButton = document.getElementById('add-email-button');
    const emailList = document.getElementById('email-list');

    addButton.addEventListener('click', () => {
      const email = emailInput.value.trim();

      if (email) {
        const emailItem = document.createElement('div');
        emailItem.className = 'flex justify-between items-center border border-gray-300 rounded px-3 py-2';
        emailItem.innerHTML = `
          <span>${email}</span>
          <input type="hidden" name="trip[participant_emails][]" value="${email}">
          <button type="button" class="remove-email-button w-1/4 bg-red-500 text-off_white px-4 py-2 rounded hover:bg-off_white hover:text-red-500 focus:ring focus:ring-secondary-red focus:outline-none button-animation">Remove</button>
        `;
        emailList.appendChild(emailItem);

        emailItem.querySelector('.remove-email-button').addEventListener('click', () => {
          emailList.removeChild(emailItem);
        });
        
        emailInput.value = '';
      }
    });
});