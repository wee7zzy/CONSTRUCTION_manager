# ConstructionXpert Services - Système de Gestion de Projets de Construction

## Description
Une application web Java EE pour la gestion efficace des projets de construction, permettant de gérer les projets, les tâches et les ressources.

## Fonctionnalités Principales

### Gestion des Projets
- Création de nouveaux projets avec détails (nom, description, dates, budget)
- Affichage et modification des projets existants
- Suppression de projets

### Gestion des Tâches
- Création et assignation de tâches aux projets
- Suivi des tâches avec dates et ressources
- Modification et suppression des tâches

### Gestion des Ressources
- Ajout et suivi des ressources
- Gestion des quantités et des fournisseurs
- Mise à jour automatique des stocks

### Fonctionnalités Bonus
- Système d'authentification administrateur
- Gestion des fournisseurs
- Protection des routes

## Technologies Utilisées
- Backend: Java EE (Servlets, JSP)
- Base de données: MySQL
- Frontend: HTML, CSS (Bootstrap), JavaScript
- Serveur: Apache Tomcat
- Contrôle de version: Git

## Installation

### Prérequis
- JDK 11 ou supérieur
- Apache Tomcat 9.x
- MySQL 8.0
- Maven

### Configuration de la Base de Données
1. Créer une base de données MySQL nommée 'construction'
2. Exécuter les scripts SQL fournis dans le dossier `database`

### Déploiement
1. Cloner le repository
2. Configurer les paramètres de connexion à la base de données dans `src/main/resources/db.properties`
3. Compiler le projet avec Maven: `mvn clean install`
4. Déployer le fichier WAR généré sur Tomcat

## Structure du Projet
```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── constructionxpert/
│   │           ├── controllers/
│   │           ├── models/
│   │           ├── dao/
│   │           ├── services/
│   │           └── utils/
│   ├── resources/
│   └── webapp/
│       ├── WEB-INF/
│       ├── css/
│       ├── js/
│       └── views/
└── test/
```

## Diagrammes UML
Les diagrammes UML (Classes, Cas d'Utilisation, Séquence) sont disponibles dans le dossier `docs/uml/`