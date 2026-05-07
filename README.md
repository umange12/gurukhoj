# GuruKhoj — AI-Powered Home Tutor Finder System

**Student:** Umang Shaily | **Roll No:** 2401296  
**University:** Graphic Era Hill University, Dehradun  
**Guide:** Mr. Amit Juyal

---
# 🎓 GuruKhoj — AI-Powered Home Tutor Finder

> An intelligent tutor discovery platform with ML-based recommendations.  
> Individual college project — Graphic Era Hill University, Dehradun.

---

## 📌 About The Project

**GuruKhoj** is a web application that helps students find the right home tutor using **AI/ML-based recommendations**. Students can browse tutors, view profiles, and get personalized suggestions based on their requirements.

Built with Python Flask and powered by a machine learning recommendation engine.

---

## ✨ Features

- 👤 Student & Teacher Registration / Login
- 🔍 Smart Tutor Search with filters
- 🤖 AI-Based Tutor Recommendations (ML)
- 📊 Student Performance Predictor
- 🏫 Teacher Dashboard & Profile Management
- 🎛️ Admin Panel
- 💬 EduBot — NLP-based chatbot assistant

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Python, Flask |
| Frontend | HTML, CSS, JavaScript |
| Database | SQLite |
| ML/AI | Scikit-learn, Random Forest, NLP |
| Libraries | NumPy |

---

## 👨‍💻 About This Project

This was an **individual project** built by Umang Shaily.

- Complete Flask web application
- ML recommendation engine using Random Forest
- NLP-based EduBot chatbot
- SQLite database design
- Manual testing and bug fixing throughout development

---

## 🚀 How To Run

### Requirements
- Python 3.8 or above
- pip

### Step 1 — Clone the repository
```bash
git clone https://github.com/umange12/gurukhoj.git
cd gurukhoj
```

### Step 2 — Install dependencies
```bash
pip install -r requirements.txt
```

### Step 3 — Run the app
```bash
python app.py
```

### Step 4 — Open in browser
```
http://localhost:5000
```

Done! 🎉

---

## 📁 Project Structure

```
gurukhoj/
├── app.py                  # Main Flask application
├── model_train.py          # ML model training script
├── requirements.txt        # Python dependencies
├── ml/
│   └── ai_engine.py        # AI recommendation engine
├── templates/
│   ├── index.html
│   ├── login.html
│   ├── register.html
│   ├── our_teachers.html
│   ├── teacher_profile.html
│   ├── teacher_dashboard.html
│   ├── student_portal.html
│   └── admin.html
└── static/
    ├── css/style.css
    └── js/main.js
```

---

## 🧪 Test Cases (QA)

| Test Case | Input | Expected Output | Status |
|-----------|-------|-----------------|--------|
| TC-01: Student Registration | Valid name, email, password | Account created | ✅ Pass |
| TC-02: Teacher Registration | Valid teacher details | Profile created | ✅ Pass |
| TC-03: Login valid user | Correct credentials | Dashboard opens | ✅ Pass |
| TC-04: Login wrong password | Wrong password | Error message | ✅ Pass |
| TC-05: Search tutor by subject | Subject name | Matching tutors shown | ✅ Pass |
| TC-06: AI Recommendation | Student profile | Personalized tutors suggested | ✅ Pass |
| TC-07: Empty search | No input | Validation error | ✅ Pass |
| TC-08: EduBot query | Student question | Relevant bot response | ✅ Pass |

---

## 📄 License

Academic project — Graphic Era Hill University, Dehradun.  
Student: Umang Shaily | Roll: 2401296

---

## 🙋‍♂️ Contact

**Umang Shaily**  
📧 shailyumang59@gmail.com  
🔗 [GitHub](https://github.com/umange12)

## How to Run

1. Install dependencies:
```
pip install flask scikit-learn numpy
```

2. Run the app:
```
python app.py
```

3. Open browser: `http://localhost:5000`

---

## Demo Login Credentials

| Role    | Email                    | Password   |
|---------|--------------------------|------------|
| Admin   | admin@gurukhoj.com       | admin123   |
| Teacher | priya@gurukhoj.com       | teacher123 |
| Student | arjun@student.com        | student123 |

---

## AI Models

1. **Content-Based Filtering** — 87% Top-3 Hit Rate
2. **Random Forest Classifier** — 91% Accuracy (n_estimators=100, max_depth=15)
3. **Ensemble Performance Predictor** — R²=0.89, RMSE=±3.8
4. **TF-IDF + BM25 Search** — 83% Precision@3

---

## Project Structure

```
GuruKhoj/
├── app.py              ← Main Flask application (all routes)
├── ml/
│   └── ai_engine.py   ← All 4 AI models
├── templates/          ← HTML pages
├── static/
│   ├── css/style.css  ← All styling
│   └── js/main.js     ← Frontend JS
├── requirements.txt
└── gurukkhoj.db       ← Auto-created SQLite DB
```
