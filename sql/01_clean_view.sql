USE ecommerce_funnel;
GO
CREATE VIEW dbo.events_clean AS
SELECT DISTINCT
    CAST(LEFT(event_time, 19) AS datetime2(0))       AS event_time,
    event_type, product_id, category_id,
    COALESCE(NULLIF(category_code, ''), 'unknown')    AS category_code,
    COALESCE(NULLIF(brand, ''), 'unknown')            AS brand,
    price, user_id, user_session
FROM dbo.events_raw
WHERE user_session IS NOT NULL AND user_session <> '';