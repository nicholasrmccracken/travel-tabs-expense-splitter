# TravelTabs

Project Description

## Table of Contents

- [Technologies](#technologies)
- [Features](#features)
- [Installation](#installation)
- [Contributing](#contributing)
  - [Style Guidelines](#style-guidelines)
- [Individual Contributions](#individual-contributions)

## Technologies

-

## Features

-

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
    bundler install
    ```

4. **Run Rails Server & Tailwind Watcher:**  
Locally host the website on port 3000 by running the following command:

    ```bash
    foreman start -f Procfile.dev
    ```

5. **Access Site Locally:**  
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

-

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

-

**Sanju:**

-
