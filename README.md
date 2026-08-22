# DEALKR

DEALKR is a unified mobile application for both Customers and Vendors. The application securely and automatically determines the user's role upon login and routes them to the appropriate experience.

## Overview
- **Single App Architecture:** Customers and Vendors use the same mobile application.
- **Role-Based Routing:** Secure backend authentication determines if a user is a Customer or a Vendor.
- **Customer Experience:** Fast-commerce UI with Home, Categories, Auction, Cart, and Menu tabs. My Orders is placed in the Menu.
- **Vendor Experience:** Dedicated dashboard with real-time metrics, product management, inventory, orders, and auction tools.
- **Shared Infrastructure:** Both experiences are powered by a single source of truth—the same backend, database, product catalog, payment system, and notification infrastructure.
- **Security:** Role-based access control (RBAC) ensures Vendors cannot access Customer data and vice versa. There is no manual role-switching feature in the application.

## Tech Stack
- Flutter (iOS, Android, Web, Desktop)
- Secure Session Management
- Shared Backend & Single Database
- Razorpay for payments (server-side verification)

## Setup & Run
1. Run `flutter pub get` to fetch dependencies.
2. Ensure the backend endpoint and configuration are correctly set in the environment.
3. Run `flutter run` to launch the application.

---

## About CouldAI
This app was generated with [CouldAI](https://could.ai), an AI app builder for cross-platform apps that turns prompts into real native iOS, Android, Web, and Desktop apps with autonomous AI agents that architect, build, test, deploy, and iterate production-ready applications.
