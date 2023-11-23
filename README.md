# Food Guardian 😋

Food Guardian révolutionne votre expérience d'achat alimentaire en scannant, sécurisant et informant instantanément sur chaque produit pour des courses sans stress ni danger.

## Structure du dépôt

~~~text
food_guardian/
│
├── lib/
│   ├── screens/
│   ├── styles/
│   ├── utils/
│   ├── widgets/
│   │
│   └── main.dart
│
├── assets/
│   ├── icons/
│   ├── images/
│   ├── ...
│
└── android/
~~~

<!-- - `/maquettes`: Contient les maquettes visuelles de l'application. -->
- `/lib`: Ce dossier est l'endroit où vous définissez les fonctionnalités de base de votre application. Il contient les fichiers **main.dart**, **routes.dart**, et le fichier automatiquement généré **firebase_options.dart**. En outre il contient une série de dossiers:
  - `/screens`: Contient les différents écrans de l'application
  - `/styles`: Contient les fichiers définissant les font, couleurs, dimensions et autres styles utilisés dans l'application
  - `/utils`: Contient des fichiers présentant une série d'utilités comme la validation des forms
  - `/widgets`: Contient les différents widgets utilisés à travers, la plupart du temps, dans plusieurs écrans de l'application
- `/assets`: 
- `/android`:

## Présentation de l'application

Bienvenue dans l'univers de Food Guardian, votre guide incontournable pour des achats alimentaires en toute sérénité ! Imaginez-vous avec un super scanner de code-barres qui vous dévoile instantanément les secrets de chaque produit que vous touchez. Pour ceux qui jonglent avec des intolérances ou des allergies, c'est une aubaine. D'un simple scan, notre appli se met en quête des allergènes et des ingrédients qui pourraient vous jouer des tours. Mais ce n'est pas tout : en créant votre profil personnalisé, vous dites adieu aux indésirables dans votre assiette. Vous recevez des alertes sur-le-champ dès qu'un produit pointé du doigt contient ce que vous voulez éviter.

Cerise sur le gâteau, Food Guardian ne se contente pas de vous dire ce qu'il y a dans vos courses, il vous donne aussi un maximum d'infos sur chaque produit, des avis de ceux qui l'ont testé et des recommandations sur mesure. Fini les prises de tête dans les rayons, même à l'étranger ! Notre appli traduit les étiquettes pour vous, pour que vous fassiez vos emplettes l'esprit léger. Et si jamais un produit refuse de se dévoiler dans la base de données, pas de panique : prenez une photo des ingrédients et Food Guardian prend la relève pour vous assurer que rien de dangereux ne se cache dans votre panier.

Avec Food Guardian, faire ses courses devient une aventure sécurisée, pleine de découvertes et sans mauvaise surprise.

## Étude de l'existant

### Applications Concurrentes

#### Yuka
Yuka est une application mobile qui scanne les produits alimentaires pour obtenir des informations claires sur l'impact sanitaire des produits que vous consommez.
- **Points Forts**:
  - Expérience intuitive
  - Système de score et recommandations
  - Fonctionne également pour les produits cosmétiques
  - Projet indépendant
- **Points Faibles**:
  - Interface améliorable
  - Dépendant d'une base de données

<div style="display: flex; justify-content: center;">
    <img src="/assets/screenshots/yuka1.jpg" alt="Capture d'écran de l'application Yuka" height="500" style="margin-right: 10px;">
    <img src="/assets/screenshots/yuka2.jpg" alt="Capture d'écran de l'application Yuka" height="500">
</div>

#### Ingredio
- **Points Forts**:
  - Focalisée sur les ingrédients
- **Points Faibles**:
  - Interface améliorable
  - Pauvre en fonctionnalités

<div style="display: flex; justify-content: center;">
    <img src="/assets/screenshots/ingredio1.jpg" alt="Capture d'écran de l'application Yuka" height="500" style="margin-right: 10px;">
    <img src="/assets/screenshots/ingredio2.jpg" alt="Capture d'écran de l'application Yuka" height="500">
</div>

## Public Cible

Food Guardian s'adresse à tous les amateurs de nourriture soucieux de leur santé et de leur bien-être. Cette application est un incontournable pour les personnes aux prises avec des allergies et des intolérances alimentaires, offrant une tranquillité d'esprit lors des courses. Les familles préoccupées par la qualité des aliments qu'elles consomment trouveront en Food Guardian un allié précieux pour veiller à la sécurité et à la santé de leurs proches. Les voyageurs, soucieux de décoder les étiquettes à l'étranger, apprécieront la facilité avec laquelle l'application traduit les ingrédients. En somme, Food Guardian s'adresse à toute personne désireuse de consommer de manière éclairée, informée et sécurisée.

## Récits Utilisateurs

### [Nom du Persona 1]
- En tant que [rôle/statut], je veux [fonctionnalité] afin de [justification].
![Maquette de la Fonctionnalité](lien_vers_maquette)

### [Nom du Persona 2]
- En tant que [rôle/statut], je veux [fonctionnalité] afin de [justification].
![Maquette de la Fonctionnalité](lien_vers_maquette)

## État d'Avancement

### Fonctionnalité 1
![GIF Illustrant la Fonctionnalité 1](lien_vers_gif)

### Fonctionnalité 2
![GIF Illustrant la Fonctionnalité 2](lien_vers_gif)

## Documentation pour les Développeurs

[WIP]
