USE ecommerce_funnel;
GO
WITH s AS (
    SELECT user_session,
           MIN(CASE WHEN event_type = 'view'     THEN event_time END) AS first_view,
           MIN(CASE WHEN event_type = 'cart'     THEN event_time END) AS first_cart,
           MIN(CASE WHEN event_type = 'purchase' THEN event_time END) AS first_purchase
    FROM dbo.events_clean
    GROUP BY user_session
),
f AS (
    SELECT *,
        CASE WHEN first_view IS NOT NULL THEN 1 ELSE 0 END AS viewed,
        CASE WHEN first_cart >= first_view THEN 1 ELSE 0 END AS carted,
        CASE WHEN first_cart >= first_view
              AND first_purchase >= first_cart THEN 1 ELSE 0 END AS purchased
    FROM s
)
SELECT SUM(viewed)    AS viewed,
       SUM(carted)    AS carted,
       SUM(purchased) AS purchased,
       CAST(100.0 * SUM(carted)    / SUM(viewed) AS decimal(5,1)) AS view_to_cart_pct,
       CAST(100.0 * SUM(purchased) / SUM(carted) AS decimal(5,1)) AS cart_to_purchase_pct,
       CAST(100.0 * SUM(purchased) / SUM(viewed) AS decimal(5,1)) AS view_to_purchase_pct
FROM f;