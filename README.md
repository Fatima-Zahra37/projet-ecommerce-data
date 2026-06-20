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

| Table         | Description                   |
|---------------|-------------------------------|
| `orders`      | Commandes clients             |
| `order_items` | Lignes de commande (produits) |
| `products`    | Catalogue produits            |
| `users`       | Informations clients          |

---

## Clés de jointure

```sql
users.id        = orders.user_id
orders.order_id = order_items.order_id
products.id     = order_items.product_id
```

---

## Structure du dépôt

```
projet-ecommerce-data/
├── data/          ← Fichier CSV du sous-périmètre
├── notebooks/     ← Analyse exploratoire Python (EDA)
├── sql/           ← Requêtes BigQuery (KPI + extraction)
├── powerbi/       ← Fichier .pbix du dashboard
├── slides/        ← Support de soutenance
├── src/           ← Scripts Python réutilisables
├── README.md
└── .gitignore
```

---

## Conventions métier

- **Vente** : ligne avec `status = 'Complete'`
- **Retour** : ligne avec `status = 'Returned'`
- **CA et marge** : calculés uniquement sur les lignes `Complete`
- **Taux de retour** : lignes `Returned` / (lignes `Complete` + lignes `Returned`)
- **Taux de réachat** : part des clients ayant au moins 2 commandes `Complete` sur une même année

---

## KPI suivis

| KPI                | Définition                                               |
|--------------------|----------------------------------------------------------|
| Chiffre d'affaires | Somme des `sale_price` sur les lignes `Complete`         |
| Marge brute        | Somme de `sale_price - cost` sur les lignes `Complete`   |
| Panier moyen       | CA ÷ nombre de commandes avec revenu > 0                 |
| Taux de retour     | Lignes `Returned` / (Lignes `Complete` + `Returned`)     |
| Taux de réachat    | Clients avec ≥ 2 commandes `Complete` sur une même année |

---

## Installation et dépendances

### Prérequis

- Python 3.10+
- VS Code avec extension Jupyter
- Power BI Desktop

### Installation des bibliothèques Python

```bash
pip install pandas numpy matplotlib seaborn plotly
```

---

## Étapes de reproduction

1. Cloner le dépôt :
   ```bash
   git clone https://github.com/Fatima-Zahra37/projet-ecommerce-data.git
   ```
2. Placer le fichier CSV dans le dossier `data/`
3. Ouvrir et exécuter le notebook dans `notebooks/`
4. Exécuter les requêtes SQL dans `sql/` via BigQuery
5. Ouvrir le fichier `.pbix` dans `powerbi/` avec Power BI Desktop

---

## Principaux enseignements

> *Cette section sera complétée à l'issue de l'analyse.*

---

## Auteur

**Fatima-Zahra** — Formation Data Analyst 2025-2026
