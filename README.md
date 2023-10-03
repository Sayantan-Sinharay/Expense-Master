# Expense Master

Welcome to **Expense Master**! This README will guide you through the steps to set up and run the application. Please follow the instructions below.

## Table of Contents

1. [Requirements](#1-requirements)
2. [Getting Started](#2-getting-started)
3. [Usage](#3-usage)

## 1. Requirements

Before you begin, ensure that you have the following software and tools installed:

- Ruby version: 3.1.1
- Database: PostgreSQL
- Rails version: 6.1.7.3
- Yarn version: 1.22.19
- Node version: v16.20.0

## 2. Getting Started

Follow these steps to get the application up and running:

```sh
# Enter into project Directory
cd /Expense-Master

# Install Ruby dependencies using Bundler
bundle install

# Install JavaScript dependencies using Yarn
yarn install

# Compile Webpacker assets
bin/rails webpacker:compile

# Precompile assets for production
bin/rails assets:precompile

# Set up the database
bin/rails db:setup

# Start the Rails server on port 3000
bin/rails server -p 3000
```

## 3. Usage

Once the application is up and running, you can access it by opening a web browser and navigating to `localhost:3000`. Here's a quick rundown of what you can do next:

- To preview the mails please navigate to `localhost:3000/letter_opener`

---
