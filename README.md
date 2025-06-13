# 🚗 AutoMate – Vehicle Service Booking App

AutoMate is a Flutter-based mobile application for vehicle owners to manage services like bookings, service history, and vehicle profiles.
It stores data locally using SQLite and offers a clean, user-friendly interface for day-to-day vehicle service needs.

---

## 📱 Features

- 🔐 login with local SQLite storage
- 🧾 Add and manage vehicle details (plate, VIN, brand, model, year)
- 🛠️ Book services like oil change, tire rotation, etc.
- 🕑 Select available time slots for service
- ✅ Review & confirm bookings (stored with "Completed" status)
- 📜 View service history with vehicle and service info
- 📤 Clean logout handling and persistent login

---

## 🛠️ Project Structure

lib/
├── core/
│ ├── database/ # SQLite DB logic
│ ├── models/ # Data models (User, Vehicle, Service)
│ └── providers/ # AuthProvider
├── features/
│ ├── auth/ # Login screen
│ ├── home/ # Dashboard UI
│ ├── onboarding/ # Onboarding slides
│ └── vehicle/ # Add/List vehicles, book service
└── main.dart # Entry point


---

## ⚙️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/Anshaj-logan/AutoMate-.git
   cd AutoMate-

2. Install dependencies
   $flutter pub get

   
3. Run the app
   $flutter run



   


