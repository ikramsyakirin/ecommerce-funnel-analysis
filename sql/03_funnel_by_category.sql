USE ecommerce_funnel;
GO
WITH base AS (
    SELECT user_session, event_type, event_time,
           CASE WHEN CHARINDEX('.', category_code) > 0
                THEN LEFT(category_code, CHARINDEX('.', category_code) - 1)
                ELSE category_code END AS main_category
    FROM dbo.events_clean
),
s AS (
    SELECT user_session, main_category,
           MIN(CASE WHEN event_type = 'view'     THEN event_time END) AS first_view,
           MIN(CASE WHEN event_type = 'cart'     THEN event_time END) AS first_cart,
           MIN(CASE WHEN event_type = 'purchase' THEN event_time END) AS first_purchase
    FROM base
    GROUP BY user_session, main_category
),
f AS (
    SELECT main_category,
        CASE WHEN first_view IS NOT NULL THEN 1 ELSE 0 END AS viewed,
        CASE WHEN first_cart >= first_view THEN 1 ELSE 0 END AS carted,
        CASE WHEN first_cart >= first_view
              AND first_purchase >= first_cart THEN 1 ELSE 0 END AS purchased
    FROM s
)
SELECT main_category,
       SUM(viewed)    AS viewed,
       SUM(carted)    AS carted,
       SUM(purchased) AS purchased,
       CAST(100.0 * SUM(carted)    / NULLIF(SUM(viewed), 0) AS decimal(5,1)) AS view_to_cart_pct,
       CAST(100.0 * SUM(purchased) / NULLIF(SUM(carted), 0) AS decimal(5,1)) AS cart_to_purchase_pct,
       CAST(100.0 * SUM(purchased) / NULLIF(SUM(viewed), 0) AS decimal(5,1)) AS view_to_purchase_pct
FROM f
GROUP BY main_category
ORDER BY viewed DESC;