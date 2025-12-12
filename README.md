# FiveM - Disable NPCs & Vehicles Script

🚫 Ein einfaches aber effektives FiveM-Script, das NPCs (Peds) und Fahrzeuge auf deinem Server deaktiviert.

## Features

- ✅ Deaktiviert alle NPCs/Peds
- ✅ Deaktiviert alle KI-gesteuerten Fahrzeuge
- ✅ Entfernt Szenario-Peds (Leute die rumlaufen, telefonieren etc.)
- ✅ Entfernt geparkte Fahrzeuge
- ✅ Konfigurierbar über `config.lua`
- ✅ Performance-optimiert
- ✅ Spieler-Fahrzeuge werden nicht entfernt

## Installation

1. **Download**: Lade das Script herunter oder clone das Repository
   ```bash
   git clone https://github.com/30Msearchtime/fivem-disable-npcs-vehicles.git
   ```

2. **Platzierung**: Kopiere den Ordner `fivem-disable-npcs-vehicles` in dein FiveM Server `resources` Verzeichnis

3. **Server.cfg**: Füge folgende Zeile zu deiner `server.cfg` hinzu:
   ```
   ensure fivem-disable-npcs-vehicles
   ```

4. **Server Neustart**: Starte deinen FiveM Server neu

## Konfiguration

Öffne die `config.lua` um das Script anzupassen:

```lua
Config = {}

-- Deaktiviere NPCs (Peds)
Config.DisableNPCs = true

-- Deaktiviere Fahrzeuge
Config.DisableVehicles = true

-- Deaktiviere zufällige Szenario-Peds
Config.DisableScenarioPeds = true

-- Deaktiviere Parked Vehicles
Config.DisableParkedVehicles = true
```

Setze die Werte auf `false`, wenn du bestimmte Features deaktivieren möchtest.

## Wie funktioniert es?

Das Script nutzt FiveM/GTA V Natives um:
- Die Spawn-Dichte von NPCs und Fahrzeugen auf 0 zu setzen
- Existierende NPCs und Fahrzeuge periodisch zu entfernen
- Spieler-Fahrzeuge werden erkannt und NICHT entfernt

## Performance

Das Script ist sehr performance-freundlich und nutzt effiziente Loops mit angemessenen Wait-Zeiten. Es sollte keine spürbaren Performance-Probleme verursachen.

## Kompatibilität

- ✅ FiveM Server
- ✅ Kompatibel mit den meisten anderen Scripts
- ✅ Getestet auf aktuellen FiveM Builds

## Support

Bei Fragen oder Problemen öffne ein Issue auf GitHub.

## Lizenz

MIT License - Du kannst das Script frei verwenden und anpassen.

## Credits

Entwickelt von [30Msearchtime](https://github.com/30Msearchtime)

---

⭐ Wenn dir das Script gefällt, gib dem Repo einen Star!
