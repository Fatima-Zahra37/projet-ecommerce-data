# Projet Data Analyst — Analyse e-commerce 2023 vs 2024

## Contexte

Ce projet a été réalisé dans le cadre d'une formation Data Analyst. Il simule une mission en entreprise e-commerce chez **TheLook Europe** : analyser la performance commerciale sur un périmètre défini et comparer les années 2023 et 2024.

---

## Objectifs

- Comprendre les dynamiques de chiffre d'affaires et de marge
- Analyser les retours produits et leur impact
- Étudier le comportement client (panier moyen, taux de réachat)
- Restituer les enseignements dans un tableau de bord Power BI interactif

---

## Périmètre d'étude

| Paramètre   | Valeur                                              |
|-------------|-----------------------------------------------------|
| Pays        | France                                              |
| Département | Women                                               |
| Période     | 01/01/2023 → 31/12/2024                             |
| Source      | `bigquery-public-data.thelook_ecommerce` (BigQuery) |

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
├── data/
│   └── thelook_fr_women_2023_2024.csv   ← CSV du sous-périmètre
├── notebooks/
│   ├── 01_EDA_python.ipynb              ← Analyse exploratoire + KPIs Python
│   └── 02_checks_coherence.ipynb        ← Validation SQL avec DuckDB
├── sql/
│   ├── kpi_ca_marge_par_annee.sql       ← KPI CA et marge brute
│   ├── kpi_aov_par_annee.sql            ← KPI panier moyen (AOV)
│   ├── kpi_taux_retour_par_annee.sql    ← KPI taux de retour
│   ├── kpi_taux_reachat_par_annee.sql   ← KPI taux de réachat
│   └── extract_sous_perimetre.sql       ← Requête d'extraction du périmètre
├── powerbi/
│   └── dashboard_thelook.pbix           ← Dashboard Power BI
├── slides/
│   └── soutenance_20min.pptx            ← Support de soutenance
├── src/
│   └── utils.py                         ← Fonctions utilitaires Python
├── README.md
├── requirements.txt
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
| Panier moyen (AOV) | CA ÷ nombre de commandes avec revenu > 0                 |
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
# Créer l'environnement virtuel
python -m venv venv
venv\Scripts\activate

# Installer les dépendances
pip install -r requirements.txt
```

---

## Étapes de reproduction

1. Cloner le dépôt :
   ```bash
   git clone https://github.com/Fatima-Zahra37/projet-ecommerce-data.git
   ```
2. Créer et activer l'environnement virtuel, installer les dépendances
3. Placer le fichier CSV dans `data/`
4. Exécuter `notebooks/01_EDA_python.ipynb` pour l'analyse exploratoire
5. Exécuter `notebooks/02_checks_coherence.ipynb` pour la validation SQL
6. Exécuter les requêtes SQL dans `sql/` via BigQuery ou DuckDB
7. Ouvrir `powerbi/dashboard_thelook.pbix` avec Power BI Desktop

---

## Décisions de design Power BI

> *Cette section sera complétée à l'issue de la construction du dashboard.*

---

## Principaux enseignements

> *Cette section sera complétée à l'issue de l'analyse.*

---

## Auteur

**Fatima-Zahra** — Formation Data Analyst 2025-2026
