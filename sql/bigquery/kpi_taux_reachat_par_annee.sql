-- KPI : Taux de réachat par année
-- Client fidèle = client avec au moins 2 commandes Complete la même année
WITH commandes_par_client_annee AS (
    SELECT
        EXTRACT(YEAR FROM oi.created_at) AS annee,
        u.id AS user_id,
        COUNT(DISTINCT o.order_id) AS nb_commandes
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
    GROUP BY annee, user_id
)
SELECT
    annee,
    ROUND(
        SUM(CASE WHEN nb_commandes >= 2 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS taux_reachat
FROM commandes_par_client_annee
GROUP BY annee
ORDER BY annee