# PowerShell Security Scripts

Collection pédagogique de scripts PowerShell défensifs pour l'inventaire et l'audit de systèmes Windows administrés par leur propriétaire. Les scripts lisent la configuration et peuvent exporter des résultats CSV ; ils ne modifient ni comptes, ni services, ni stratégies.

## Objectif

- automatiser des contrôles d'administration simples ;
- produire des objets PowerShell réutilisables ;
- exporter des résultats structurés ;
- améliorer la traçabilité d'un audit local ;
- pratiquer la gestion d'erreurs et la documentation.

## Architecture

```text
scripts/   commandes d'inventaire en lecture seule
docs/      utilisation, permissions et sécurité
tests/     contrôles Pester à compléter
examples/  exemples anonymisés uniquement
output/    exports locaux exclus de Git
```

## Environnement technique

- Windows PowerShell 5.1 ou PowerShell 7 selon les cmdlets utilisées ;
- exécution locale sur ses propres machines ;
- droits administratifs uniquement lorsque la lecture demandée l'exige ;
- Pester facultatif pour les tests.

`TODO: indiquer les versions réellement testées.`

## Prérequis

- vérifier le contenu avant exécution ;
- conserver la politique d'exécution de l'organisation ;
- ouvrir une console avec les seuls droits nécessaires ;
- créer localement le dossier `output` ;
- contrôler les CSV avant partage.

## Mise en place

```powershell
Get-Help .\scripts\Get-SystemInventory.ps1 -Full
.\scripts\Get-SystemInventory.ps1
.\scripts\Get-SystemInventory.ps1 -OutputPath .\output\system.csv
```

Les exemples n'imposent aucun changement de politique d'exécution.

## Tests réalisés

Une vérification statique Pester est fournie. L'exécution sur Windows reste à documenter.

`TODO: compléter après tests sur Windows 10/11 et Windows Server.`

## Sécurité mise en œuvre

- opérations en lecture seule ;
- aucun mot de passe ou secret en paramètre ;
- export seulement si `OutputPath` est explicitement fourni ;
- création du dossier parent contrôlée ;
- erreurs remontées clairement ;
- dossier `output` ignoré par Git ;
- limitation des événements par date et quantité.

## Résultats

`TODO: ajouter des sorties anonymisées après tests réels. Ne pas publier un inventaire brut d'une machine personnelle ou professionnelle.`

## Compétences développées

PowerShell, objets, pipeline, CIM, gestion d'erreurs, journaux Windows, comptes locaux, services, groupes, CSV et documentation sécurisée.

## Captures d'écran

`TODO: ajouter uniquement des captures anonymisées montrant une exécution réelle.`

## Difficultés rencontrées

`TODO: documenter les différences réellement observées entre PowerShell 5.1/7, éditions Windows et niveaux de droits.`

## Axes d'amélioration

- ajouter une signature de code dans un environnement de confiance ;
- compléter les tests Pester ;
- ajouter un mode JSON ;
- créer un rapport consolidé sans donnée sensible ;
- tester la compatibilité Windows Server.


