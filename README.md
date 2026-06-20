Projet Data Analyst — Analyse e-commerce 2023 vs 2024
Contexte
Ce projet a été réalisé dans le cadre d'une formation Data Analyst. Il simule une mission en entreprise e-commerce : analyser la performance commerciale sur un périmètre défini et comparer les années 2023 et 2024.
________________________________________
Objectifs
•	Comprendre les dynamiques de chiffre d'affaires et de marge
•	Analyser les retours produits et leur impact
•	Étudier le comportement client (panier moyen, taux de réachat)
•	Restituer les enseignements dans un tableau de bord Power BI interactif
________________________________________
Périmètre d'étude
Paramètre	Valeur
Pays	France
Département	Women
Période	01/01/2023 → 31/12/2024
Source	BigQuery (jeu de données public)
________________________________________
Tables utilisées
Table	Description
orders	Commandes clients
order_items	Lignes de commande (produits)
products	Catalogue produits
users	Informations clients
________________________________________
Clés de jointure
users.id          = orders.user_id
orders.order_id   = order_items.order_id
products.id       = order_items.product_id
________________________________________
Structure du dépôt
projet-ecommerce-data/
├── data/            ← Fichier CSV du sous-périmètre
├── notebooks/       ← Analyse exploratoire Python (EDA)
├── sql/             ← Requêtes BigQuery (KPI + extraction)
├── powerbi/         ← Fichier .pbix du dashboard
├── slides/          ← Support de soutenance
├── src/             ← Scripts Python réutilisables
├── README.md
└── .gitignore
________________________________________
Conventions métier
•	Vente : ligne avec status = 'Complete'
•	Retour : ligne avec status = 'Returned'
•	CA et marge : calculés uniquement sur les lignes Complete
•	Taux de retour : lignes Returned / (lignes Complete + lignes Returned)
•	Taux de réachat : part des clients ayant au moins 2 commandes Complete sur une même année
________________________________________
KPI suivis
KPI	Définition
Chiffre d'affaires	Somme des sale_price sur les lignes Complete
Marge brute	Somme de sale_price - cost sur les lignes Complete
Panier moyen	CA ÷ nombre de commandes avec revenu > 0
Taux de retour	Lignes Returned / (Lignes Complete + Returned)
Taux de réachat	Clients avec ≥ 2 commandes Complete sur une même année
________________________________________
Installation et dépendances
Prérequis
•	Python 3.10+
•	Jupyter Notebook ou VS Code avec extension Jupyter
•	Power BI Desktop
Installation des bibliothèques Python
pip install pandas numpy matplotlib seaborn plotly
________________________________________
Étapes de reproduction
1.	Cloner le dépôt : 
2.	git clone https://github.com/Fatima-Zahra37/projet-ecommerce-data.git
3.	Placer le fichier CSV dans le dossier data/
4.	Ouvrir et exécuter le notebook dans notebooks/
5.	Exécuter les requêtes SQL dans sql/ via BigQuery
6.	Ouvrir le fichier .pbix dans powerbi/ avec Power BI Desktop
________________________________________
Principaux enseignements
Cette section sera complétée à l'issue de l'analyse.
________________________________________
Auteur
Fatima-Zahra — Formation Data Analyst 2025-2026

