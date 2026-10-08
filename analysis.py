import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("data/credit_portfolio.csv")

print("\n=== PORTFOLIO KPIs ===")
print("Accounts:", len(df))
print("Outstanding:", round(df["outstanding_balance"].sum(), 0))
print("Default rate:", round(df["default_flag"].mean()*100, 2), "%")
print("Average CIBIL:", round(df["cibil_score"].mean(), 1))
print("Net monthly revenue:", round(df["net_monthly_revenue"].sum(), 0))

product = df.groupby("product").agg(
    accounts=("customer_id","count"),
    outstanding=("outstanding_balance","sum"),
    default_rate=("default_flag","mean"),
    net_revenue=("net_monthly_revenue","sum")
).sort_values("net_revenue", ascending=False)

print("\n=== PRODUCT PERFORMANCE ===")
print(product.assign(default_rate_pct=product.default_rate*100).round(2))

risk = df.groupby("risk_band").agg(
    accounts=("customer_id","count"),
    outstanding=("outstanding_balance","sum"),
    default_rate=("default_flag","mean")
).sort_values("outstanding", ascending=False)

print("\n=== RISK PROFILE ===")
print(risk.assign(default_rate_pct=risk.default_rate*100).round(2))

# Export dashboard-ready summaries
product.reset_index().to_csv("product_kpis.csv", index=False)
risk.reset_index().to_csv("risk_kpis.csv", index=False)

# Simple charts
plt.figure(figsize=(9,5))
product["net_revenue"].sort_values().plot(kind="barh")
plt.title("Net Monthly Revenue by Product")
plt.xlabel("Net Revenue")
plt.tight_layout()
plt.savefig("revenue_by_product.png", dpi=180)
plt.close()

plt.figure(figsize=(9,5))
(df.groupby("region")["default_flag"].mean()*100).sort_values().plot(kind="bar")
plt.title("Default Rate by Region")
plt.ylabel("Default Rate (%)")
plt.tight_layout()
plt.savefig("default_rate_by_region.png", dpi=180)
plt.close()

print("\nFiles exported: product_kpis.csv, risk_kpis.csv, revenue_by_product.png, default_rate_by_region.png")
