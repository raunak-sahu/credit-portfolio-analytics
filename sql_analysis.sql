-- ICICI-style Credit Portfolio Analytics
-- PostgreSQL syntax. Load data/credit_portfolio.csv into credit_portfolio.

-- 1. Portfolio KPIs
SELECT
    COUNT(*) AS accounts,
    ROUND(SUM(loan_amount),2) AS sanctioned_amount,
    ROUND(SUM(outstanding_balance),2) AS outstanding,
    ROUND(AVG(cibil_score),1) AS avg_cibil,
    ROUND(100.0*AVG(default_flag),2) AS default_rate_pct,
    ROUND(SUM(net_monthly_revenue),2) AS monthly_net_revenue
FROM credit_portfolio;

-- 2. Product performance
SELECT
    product,
    COUNT(*) AS accounts,
    ROUND(SUM(outstanding_balance),0) AS outstanding,
    ROUND(100.0*AVG(default_flag),2) AS default_rate_pct,
    ROUND(AVG(cibil_score),1) AS avg_cibil,
    ROUND(SUM(net_monthly_revenue),0) AS net_revenue
FROM credit_portfolio
GROUP BY product
ORDER BY net_revenue DESC;

-- 3. Branch/region performance
SELECT
    region,
    COUNT(*) AS accounts,
    ROUND(SUM(outstanding_balance),0) AS outstanding,
    ROUND(100.0*AVG(default_flag),2) AS default_rate_pct,
    ROUND(SUM(net_monthly_revenue),0) AS net_revenue
FROM credit_portfolio
GROUP BY region
ORDER BY net_revenue DESC;

-- 4. Risk concentration
SELECT
    risk_band,
    COUNT(*) AS accounts,
    ROUND(100.0*AVG(default_flag),2) AS default_rate_pct,
    ROUND(SUM(outstanding_balance),0) AS outstanding
FROM credit_portfolio
GROUP BY risk_band
ORDER BY outstanding DESC;

-- 5. High-risk customers needing review
SELECT customer_id, product, branch_id, cibil_score, dpd_days,
       credit_utilization_pct, outstanding_balance, default_flag
FROM credit_portfolio
WHERE cibil_score < 650
   OR dpd_days >= 30
   OR credit_utilization_pct >= 85
ORDER BY outstanding_balance DESC
LIMIT 100;

-- 6. Segment profitability
SELECT
    customer_segment,
    product,
    COUNT(*) AS accounts,
    ROUND(AVG(annual_income),0) AS avg_income,
    ROUND(AVG(cibil_score),1) AS avg_cibil,
    ROUND(SUM(net_monthly_revenue),0) AS net_revenue
FROM credit_portfolio
GROUP BY customer_segment, product
ORDER BY net_revenue DESC;

-- 7. Portfolio vintage-style proxy by risk bucket
SELECT
    CASE
        WHEN cibil_score < 600 THEN '<600'
        WHEN cibil_score < 650 THEN '600-649'
        WHEN cibil_score < 700 THEN '650-699'
        WHEN cibil_score < 750 THEN '700-749'
        ELSE '750+'
    END AS cibil_bucket,
    COUNT(*) AS accounts,
    ROUND(AVG(emi_to_income_pct),2) AS avg_emi_to_income_pct,
    ROUND(100.0*AVG(default_flag),2) AS default_rate_pct,
    ROUND(SUM(expected_credit_loss),0) AS expected_loss
FROM credit_portfolio
GROUP BY 1
ORDER BY 1;
