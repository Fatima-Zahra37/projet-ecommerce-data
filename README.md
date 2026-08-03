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

**Modèle de données** : schéma en étoile (1 table de faits + 3 dimensions : Dim_Date, Dim_Produit, Dim_Client), pour des performances optimales et l'accès à l'intelligence temporelle (comparaisons vs N-1).

**Convention de nommage** : la table de faits garde ses noms de colonnes en anglais (fidélité à la source BigQuery/CSV, traçabilité) ; les dimensions construites sont en français (lisibilité pour un public métier non technique).

**Code couleur cohérent** : bleu pour le chiffre d'affaires, vert pour la marge et les signaux positifs, rouge/orange pour le taux de retour et les points de vigilance — appliqué sur les 4 pages du dashboard.

**Filtres Top N** : appliqués sur les visuels à forte cardinalité (658 marques, nombreuses villes) pour garantir la lisibilité, recalculés dynamiquement selon l'année sélectionnée.

**Seuil de fiabilité statistique** : un filtre sur le volume minimum (≥10 lignes) a été appliqué aux analyses de taux de retour par catégorie, pour exclure les catégories dont l'échantillon est trop faible pour un résultat représentatif.

**Choix du graphique villes plutôt qu'une carte** : le visuel carte de Power BI nécessite des coordonnées de latitude/longitude non disponibles dans les données ; un graphique en barres du Top 10 des villes a été retenu comme alternative tout aussi lisible.

**Indicateurs d'évolution vs N-1** : mesures DAX utilisant `SAMEPERIODLASTYEAR`, avec gestion des cas limites (division par zéro, absence de donnée de comparaison pour 2023).

---

## Principaux enseignements

- Le chiffre d'affaires et la marge progressent quasiment au même rythme (+101,3% et +99,6%) entre 2023 et 2024 : la croissance ne se fait pas au détriment de la rentabilité.
- Cette croissance est portée par le volume de commandes plutôt que par le panier moyen (+6,1% seulement) : l'activité augmente, la fidélisation reste à développer (taux de réachat 3,4% en 2024).
- Le catalogue est très fragmenté (658 marques pour 1 573 produits) : aucune marque ne domine, la croissance résulte d'une dynamique globale plutôt que d'un produit phare.
- Le taux de retour baisse de 7,4 points sur la période, mais certaines catégories (Blazers & Jackets, Suits) concentrent l'essentiel des retours (~48%), un point de vigilance ciblé.
- La ville de Lyon, 2ᵉ ville de France, reste sous-représentée dans le chiffre d'affaires par rapport à son potentiel démographique.
- Un écart de volume de données a été observé entre le CSV fourni (1 679 lignes) et la reconstruction directe sur BigQuery (1 251 lignes), expliqué par une méthode de jointure plus stricte (INNER JOIN) ; les ratios (panier moyen, taux de retour) restent stables, confirmant que la logique de calcul est correcte.

---

## Auteur

**Fatima-Zahra FRINDOU** — Formation Data Analyst, session avril 2026
