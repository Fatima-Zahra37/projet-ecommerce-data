-- Extraction du sous-périmètre France x Women x 2023-2024
-- Jointures : users -> orders -> order_items -> products
SELECT
    oi.created_at AS item_created_at,
    o.created_at AS order_created_at,
    oi.shipped_at,
    oi.delivered_at,
    o.order_id,
    oi.id AS order_item_id,
    oi.status AS item_status,
    o.status AS order_status,
    oi.sale_price,
    p.cost,
    p.id AS product_id,
    p.brand,
    p.category,
    p.department,
    p.name AS product_name,
    u.id AS user_id,
    u.gender,
    u.country,
    u.state,
    u.city
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.orders` o
    ON oi.order_id = o.order_id
JOIN `bigquery-public-data.thelook_ecommerce.products` p
    ON oi.product_id = p.id
JOIN `bigquery-public-data.thelook_ecommerce.users` u
    ON o.user_id = u.id
WHERE u.country = 'France'
    AND p.department = 'Women'
    AND DATE(oi.created_at) BETWEEN '2023-01-01' AND '2024-12-31'
ORDER BY oi.created_at, o.order_id, oi.id