document.addEventListener('DOMContentLoaded', function () {
    const menuToggle = document.getElementById('menu-toggle');
    const menuOptions = document.getElementById('menu-options');

    // Function to show the menu
  function showMenu() {
    menuOptions.classList.remove('hidden');
  }

  // Function to hide the menu
  function hideMenu() {
    menuOptions.classList.add('hidden');
  }

    // Toggle menu on click
  menuToggle.addEventListener('click', function () {
    console.log('Menu toggle clicked');
    if (menuOptions.classList.contains('hidden')) {
      showMenu();
    } else {
      hideMenu();
    }
  });
  
    // Show Menu on Hover
    menuToggle.addEventListener('mouseenter', function () {
    showMenu();
    });

    // Keep the menu visible while hovering over it
  menuOptions.addEventListener('mouseenter', function () {
    showMenu();
  });
  
   // Hide menu when the mouse leaves the menu or menu toggle
  menuOptions.addEventListener('mouseleave', function () {
    hideMenu();
  });

  // Ensure menu stays functional after an item is clicked
  menuOptions.addEventListener('click', function () {
    hideMenu(); // Optionally hide the menu after a click
  });
});

// Hide the menu when clicking outside
document.addEventListener('click', function (event) {
    if (!menuToggle.contains(event.target) && !menuOptions.contains(event.target)) {
      hideMenu();
    }
  });

  // Hide menu after clicking a menu item
  menuOptions.addEventListener('click', function () {
    hideMenu();
  });


