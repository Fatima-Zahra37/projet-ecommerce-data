-- KPI : Taux de retour par année
-- Taux de retour = lignes Returned / (lignes Complete + lignes Returned)
SELECT
    EXTRACT(YEAR FROM oi.created_at) AS annee,
    ROUND(
        SUM(CASE WHEN oi.status = 'Returned' THEN 1 ELSE 0 END)
        / SUM(CASE WHEN oi.status IN ('Complete', 'Returned') THEN 1 ELSE 0 END),
        4
    ) AS taux_retour
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
GROUP BY annee
ORDER BY annee