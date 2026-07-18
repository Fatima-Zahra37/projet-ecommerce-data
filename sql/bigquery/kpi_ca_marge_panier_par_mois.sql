-- KPI : CA, Marge, Panier moyen — granularité MENSUELLE
-- France / Women / 2023-2024, lignes Complete uniquement
SELECT
    EXTRACT(YEAR FROM oi.created_at) AS annee,
    EXTRACT(MONTH FROM oi.created_at) AS mois,
    ROUND(SUM(oi.sale_price), 2) AS chiffre_affaires,
    ROUND(SUM(oi.sale_price - p.cost), 2) AS marge_brute,
    ROUND(SUM(oi.sale_price) / COUNT(DISTINCT o.order_id), 2) AS panier_moyen
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
    AND oi.status = 'Complete'
GROUP BY annee, mois
ORDER BY annee, mois