# Projet Data Analyst — Analyse e-commerce 2023 vs 2024

## Contexte

Ce projet a été réalisé dans le cadre d'une formation Data Analyst. Il simule une mission en entreprise e-commerce : analyser la performance commerciale sur un périmètre défini et comparer les années 2023 et 2024.

---

## Objectifs

- Comprendre les dynamiques de chiffre d'affaires et de marge
- Analyser les retours produits et leur impact
- Étudier le comportement client (panier moyen, taux de réachat)
- Restituer les enseignements dans un tableau de bord Power BI interactif

---

## Périmètre d'étude

| Paramètre   | Valeur                           |
|-------------|----------------------------------|
| Pays        | France                           |
| Département | Women                            |
| Période     | 01/01/2023 → 31/12/2024          |
| Source      | BigQuery (jeu de données public) |

---

## Tables utilisées

| Table         | Description                    |
|---------------|--------------------------------|
| `orders`      | Commandes clients              |
| `order_items` | Lignes de commande (produits)  |
| `products`    | Catalogue produits             |
| `users`       | Informations clients           |

---

## Clés de jointure

```sql
users.id        = orders.user_id
orders.order_id = order_items.order_id
products.id     = order_items.product_id
```

---

## Structure du dépôt