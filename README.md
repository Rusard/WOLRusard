# Wake-on-line

Application iOS permettant de démarrer des ordinateurs à distance via Wake-on-LAN.

Fonctionnalités principales :

- Gestion d'une liste d'ordinateurs avec nom, adresse MAC et adresse IP locale.
- Envoi de paquets magic WOL sur le port UDP 9.
- Sauvegarde locale des machines via `UserDefaults`.
- Intégration Siri via `AppIntents` pour dire : *"Allume [nom de l'ordinateur]"*.

Le projet est entièrement réalisé en SwiftUI et ne dépend d'aucune bibliothèque tierce.
