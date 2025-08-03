# Wake-on-line

Application iOS permettant de démarrer des ordinateurs à distance via Wake-on-LAN.

Fonctionnalités principales :

- Gestion d'une liste d'ordinateurs avec nom, adresse MAC et adresse IP locale.
- Envoi de paquets magic WOL sur le port UDP 9.
- Sauvegarde locale des machines via `UserDefaults`.
- Intégration Siri via `AppIntents` pour dire : *"Allume [nom de l'ordinateur]"*.

Le projet est entièrement réalisé en SwiftUI et ne dépend d'aucune bibliothèque tierce.

## Installation

1. **Cloner le dépôt**

   ```bash
   git clone <URL-du-dépôt>
   cd Wake-on-line
   ```

2. **Ouvrir le projet**

   Ouvrez le dossier `WakeOnLine` dans Xcode (version 15 ou supérieure).

3. **Compiler et lancer**

   Sélectionnez un simulateur ou un appareil physique puis cliquez sur *Run* pour installer l'application.

## Utilisation en ligne de commande

Un utilitaire CLI est fourni pour envoyer un paquet WOL depuis macOS ou Linux :

```bash
swift build
.build/debug/wakeonlan-cli <MAC> <IP> [PORT]
```

L'exécutable enverra un paquet magique vers l'adresse fournie et affichera un message de confirmation.
