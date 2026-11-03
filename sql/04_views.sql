SELECT SUM(viewed) AS viewed, SUM(carted) AS carted, SUM(purchased) AS purchased
FROM ecommerce_funnel.dbo.vw_funnel_session;

SELECT main_category, SUM(viewed) AS viewed, SUM(carted) AS carted, SUM(purchased) AS purchased
FROM ecommerce_funnel.dbo.vw_funnel_category
GROUP BY main_category
ORDER BY viewed DESC;