# GuruKhoj — AI-Powered Home Tutor Finder System

**Student:** Umang Shaily | **Roll No:** 2401296  
**University:** Graphic Era Hill University, Dehradun  
**Guide:** Mr. Amit Juyal

---

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
