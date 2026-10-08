# Credit Portfolio & Customer Profitability Analytics

## Resume-ready project
**Role target:** Data Analyst / Banking Analytics / Risk Analytics / Business Analyst

A retail-banking analytics project that evaluates **credit risk, portfolio profitability, customer segments, and branch/region performance** using Python, SQL and Power BI.

### Business questions
- Which lending products generate the strongest net revenue?
- Which regions/branches combine high exposure with elevated default risk?
- How does CIBIL score relate to delinquency/default?
- Which customers should enter an early-warning/collections queue?
- Which customer segments are attractive for lower-risk cross-sell?

### Tech stack
**Python (Pandas, NumPy, Matplotlib) | SQL (PostgreSQL) | Power BI | Excel-ready CSV**

### Repository
```text
credit-portfolio-analytics/
├── data/
│   ├── credit_portfolio.csv
│   └── branch_master.csv
├── Credit_Portfolio_Analytics.ipynb
├── analysis.py
├── sql_analysis.sql
├── dashboard_guide.md
├── requirements.txt
└── README.md
```

### How to run
```bash
pip install -r requirements.txt
python analysis.py
```

Open `Credit_Portfolio_Analytics.ipynb` for the complete analysis.

### Power BI dashboard
Import `data/credit_portfolio.csv` and build 3 pages:
1. **Executive Overview:** Outstanding, default rate, avg CIBIL, net revenue, product mix.
2. **Risk & Early Warning:** CIBIL bands, DPD, utilization, default rate, high-risk account table.
3. **Branch & Product Performance:** region/branch revenue, outstanding exposure, default rate, product comparison.

### Key analytical approach
The dataset is **synthetic and created for portfolio-analysis practice**. It is not ICICI Bank customer data and contains no real customer information.

### Resume bullet
> **Credit Portfolio & Profitability Analytics | Python, SQL, Power BI** — Analyzed a 12K-account synthetic retail-lending portfolio to identify product profitability, regional risk concentration and early-warning accounts; built SQL KPI queries and a Power BI-ready risk dashboard using CIBIL, DPD, utilization and expected-loss indicators.
