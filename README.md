# FiveM - Disable NPCs & Vehicles Script

🚫 A simple yet effective FiveM script that disables NPCs (Peds) and vehicles on your server.

## Features

- ✅ Disables all NPCs/Peds
- ✅ Disables all AI-controlled vehicles
- ✅ Removes scenario peds (people walking around, on phones, etc.)
- ✅ Removes parked vehicles
- ✅ Configurable via `config.lua`
- ✅ Performance optimized
- ✅ Player vehicles are not removed

## Installation

1. **Download**: Download the script or clone the repository
   ```bash
   git clone https://github.com/30Msearchtime/fivem-disable-npcs-vehicles.git
   ```

2. **Placement**: Copy the `fivem-disable-npcs-vehicles` folder to your FiveM server `resources` directory

3. **Server.cfg**: Add the following line to your `server.cfg`:
   ```
   ensure fivem-disable-npcs-vehicles
   ```

4. **Server Restart**: Restart your FiveM server

## Configuration

Open `config.lua` to customize the script:

```lua
Config = {}

-- Disable NPCs (Peds)
Config.DisableNPCs = true

-- Disable Vehicles
Config.DisableVehicles = true

-- Disable random scenario peds
Config.DisableScenarioPeds = true

-- Disable Parked Vehicles
Config.DisableParkedVehicles = true
```

Set values to `false` if you want to disable specific features.

## How does it work?

The script uses FiveM/GTA V natives to:
- Set the spawn density of NPCs and vehicles to 0
- Periodically remove existing NPCs and vehicles
- Player vehicles are detected and NOT removed

## Performance

The script is very performance-friendly and uses efficient loops with appropriate wait times. It should not cause any noticeable performance issues.

## Compatibility

- ✅ FiveM Server
- ✅ Compatible with most other scripts
- ✅ Tested on current FiveM builds

## Support

For questions or issues, please open an issue on GitHub.

## License

MIT License - You are free to use and modify the script.

## Credits

Developed by [30Msearchtime](https://github.com/30Msearchtime)

---

⭐ If you like this script, give the repo a star!
