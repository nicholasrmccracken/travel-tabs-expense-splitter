# TravelTabs

TravelTabs is a web application designed to help groups of travelers manage and split expenses during their trips. It allows users to create trips, add participants, log expenses, and automatically calculate each participant's share.

## Table of Contents

- [Technologies](#technologies)
- [Features](#features)
- [Installation](#installation)
- [Contributing](#contributing)
  - [Style Guidelines](#style-guidelines)
- [Individual Contributions](#individual-contributions)

## Technologies

- Ruby on Rails (Frontend & Backend)
- Devise (User Authentication Gem)
- CSS Tailwind (Styling)
- SQLite (Database)

## Features

- Create and manage trips
- Add participants to trips
- Log and categorize expenses
- Automatically calculate and display each participant's share
- View expense summaries and detailed breakdowns
- Responsive design with Tailwind CSS

## Installation

To set up the project locally, follow these steps:

1. **Clone Repository:**

    ```bash
    git clone https://github.com/yourusername/your-repo-name.git cd your-repo-name
    ```

2. **Install Ruby:**  
Install ruby v3.3.3. You can check your version with:

    ```bash
    ruby -v
    ```

3. **Install Dependencies:**  
Install all required gems by running the following command:

    ```bash
    rails assets:precompile
    ```

4. **Precompile Assets:**  
Ensure all assets (javascripts) are precompiled:

    ```bash
    bundler install
    ```

5. **Run Rails Server & Tailwind Watcher:**  
Locally host the website on port 3000 by running the following command:

    ```bash
    foreman start -f Procfile.dev
    ```

6. **Access Site Locally:**  
Open your web browser and navigate to [http://localhost:3000](http://localhost:3000).

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.  
2. Create a new branch for your feature.  

    ```bash
    git checkout -b feature-name
    ```

3. Make your changes and commit them.  
Be sure to adhere to the [style guidelines](#style-guidelines).

    ```bash
    git commit -m 'Add feature-name'
    ```

4. Push to the branch.  

    ```bash
    git push origin feature-name
    ```

5. Open a pull request on GitHub.  

### Style Guidelines

**Code Style:**

- Follow the [Ruby Style Guide](https://rubystyle.guide/).
- Use 2 spaces for indentation, no tabs.
- Keep lines under 80 characters.
- Use meaningful and descriptive variable and method names.
- Avoid using global variables.
- Use snake_case for methods and variables.
- Use CamelCase for classes and modules.
- Prefer single-quoted strings when you don't need string interpolation or special symbols.
- Use `def` with parentheses when there are arguments, without parentheses when there are none.
- Use `private` and `protected` to encapsulate methods that should not be part of the public API.
- Write unit tests for all methods and classes.

**Rails Style:**

- Follow the [Rails Style Guide](https://rails.rubystyle.guide/).
- Use RESTful routes and actions in controllers.
- Keep controllers skinny, models fat.
- Use partials to DRY up views.
- Use strong parameters for mass assignment protection.
- Use `before_action` callbacks to set up common data or constraints.
- Use scopes in models for commonly used queries.
- Avoid using instance variables in views; use view helpers instead.
- Use `form_with` for forms.
- Use `flash` for user notifications.
- Write integration tests for controllers and views.

**Git Style:**

- Create a branch for features that will not be completed within a single push.
- Prefix branch names with descriptors of work being done and use dashes as separators.
  - ‘feature/deck-card-classes’, ‘bugfix/’
- Rebase branches instead of merging them.
- Commit messages must have subject line (50 char max) and optional body copy (wrapped at 72 columns) separated by a blank line.
- Subject lines should be capitalized, not end in a period, and be written in an imperative mood.
  - 'Add', 'Implement', 'Fix'
- Body copy must only contain what and why explanations, never how. The how should be in documentation.

## Individual Contributions

**Aysha:**

- Created functionality for trips (create, edit, leave, delete, show) within model, controller, routes, and views
- Created functionality for expenses (create, leave, delete, show) within model, controller,routes, and views
- Implemented initial expense edit/update functionality
- Added sharing expense functionality with amount (and initial percentage)
- Added total owed for shared expense for each trip in view

**Christopher:**

- Implemented tailwind for sitewide styling
- Created custom color palette
- Style various views associated with trips and expenses (new expense, trip forms, trip index home page, individual trip show page)
- Old expense participant and ledger

**Nicholas:**

- Created database with all models and assocations
- Implemented dynamic addition of users to trips via email lookup
- Implemented users controller & added methods in the expenses and trips controllers.
- Made the README.md, logo, and color palette for the site.

**Sanju:**

- Implemented friend requests feature
- Built a `Users List` page to display all users except the current user.
- Added "Send Friend Request" button with conditional rendering for sent and received requests.
- Created and styled the dashboard page
- Created and styled the navigation bar
- Created and styled the landing page and the 'Learn more' page
- Styled login page
- Implemented the friend request controller
- Created 'Edit profile' page for logged in users
- Implemented views
