-- Reconstruction du sous-périmètre : France / Women / 2023-2024
-- Toutes les colonnes nécessaires à l'analyse

SELECT
    order_id,
    order_item_id,
    product_id,
    item_created_at,
    item_status,
    sale_price,
    cost,
    category,
    department,
    brand,
    product_name,
    order_status,
    order_created_at,
    shipped_at,
    delivered_at,
    user_id,
    gender,
    country,
    state,
    city
FROM source_table
WHERE country    = 'France'
AND   department = 'Women'
AND   YEAR(CAST(item_created_at AS TIMESTAMP)) BETWEEN 2023 AND 2024
ORDER BY item_created_at, order_id, order_item_id;
