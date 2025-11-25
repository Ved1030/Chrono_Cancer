🧬 Chrono Cancer — AI-Powered Cancer Care & Medical Analysis Platform

Chrono Cancer is a smart healthcare management and cancer-support application built using Flutter (Frontend) and Python/FastAPI (Backend). It enables medical collaboration between Patients, Doctors, and ASHA Workers, while providing AI-powered medical report analysis with XAI (Explainable AI).

🚀 Key Features
👤 User Roles

✔ Patient

Upload medical reports (PDF / Image)
AI-based medical report interpretation
Health history & tracking
Appointment booking
View recommended doctors
Insights powered by XAI explanations

✔ Doctor

Access detailed patient medical reports
View history & predictions
Provide professional assessment & notes
Monitoring of patient health evolution

✔ ASHA Worker

Community screening
Patient onboarding & data submission
Tracking medical schedules
Reporting and referral assistance

🧠 AI Report Analyzer (Core Feature)

Our AI model can analyze:
✔ Medical blood reports
✔ Pathology reports
✔ Diagnostic images
✔ Health summaries

It produces:

Disease interpretation
Explanation of parameters
Possible medical conditions
Recommended next steps

Simple language summary for patients

🔎 XAI — Explainable Artificial Intelligence
XAI ensures the AI output is transparent & understandable.

Model explanations include:

✔ Confidence %
✔ Highlight of impactful biomarkers
✔ Why a conclusion was made
✔ Which parameters influenced classification
✔ User-friendly medical breakdown

This brings trust & accountability to AI in healthcare.

🏗 Project Structure
chrono_cancer/
│
├── Backend/             → Python / FastAPI / AI models  
│   ├── api_server.py  
│   ├── requirements.txt  
│   ├── saved_models/  
│   └── .env  (SECRET — not in repo)
│
├── Frontend/            → Flutter cross-platform app  
│   ├── lib/  
│   ├── assets/  
│   ├── android/  
│   ├── ios/
│   ├── web/
│   └── pubspec.yaml
│
└── README.md

🛠 Technologies Used
Frontend (Flutter)
Dart
Firebase Authentication
Firestore Database
State Management (Provider / Bloc)
Map & location services
PDF generation
REST API integration
Cross-platform build (Android / iOS / Web / Windows / macOS / Linux)
Backend (Python)
FastAPI
Torch / TensorFlow
NumPy / Pandas
scikit-learn
XAI frameworks
OCR text extraction
Medical model inference logic

📦 Installation / Setup
Clone repository
git clone https://github.com/Ved1030/Chrono_Cancer

🔧 Backend Setup
cd Backend
pip install -r requirements.txt

Add your private configs to:

Backend/.env

Run server:

uvicorn api_server:app --host 0.0.0.0 --port 8000

📱 Frontend Setup (Flutter)
cd Frontend
flutter pub get
flutter run

🔐 Security

✔ .env is Git-ignored
✔ Push-protection enabled
✔ No private API-keys in repo
✔ Sensitive data encrypted

📄 PDF Export & Sharing

Patients and doctors can:
✔ Export AI analysis as PDF
✔ Share through WhatsApp / Email

🩺 Goal of This Project

Early detection of cancer
Making medical reports understandable
Helping doctors with AI-insights
Providing support to ASHA community workers

🧑‍💻 Contributors

👨‍💻 Virti Panchamia, Neev Patel, Param Shah, Ved Mehta – Project Developer
🤝 Contribution requests welcome

📬 Contact

For questions, collaboration or suggestions:
📩 Email: virtipanchamia25@gmail.com
           neevpatel2600@gmail.com
           paramshah1906@gmail.com
           mehtaved12@gmail.com

🐙 GitHub: https://github.com/Ved1030

⭐ If you like this project

Please star the repo 🙌

⭐ github.com/Ved1030/Chrono_Cancer
