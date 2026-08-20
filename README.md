# City Historic Engine for Liquid Galaxy

Flutter application that presents the history and heritage of a city on a Liquid Galaxy rig. The current content is **Lleida** (Catalonia): points of interest, cathedrals and churches, museums, and historical events.

Repository: [LiquidGalaxyLAB/lg-city-historic-engine](https://github.com/LiquidGalaxyLAB/lg-city-historic-engine)

## Index

1. [Name of the Project](#1-name-of-the-project)
2. [Project Description](#2-project-description)
3. [Frontend Development](#3-frontend-development)
4. [Integration with Liquid Galaxy](#4-integration-with-liquid-galaxy)
5. [Personal Information](#5-personal-information)

---

## 1. Name of the Project

**City Historic Engine (CHE)** — `lg-city-historic-engine`

Developed at **Lleida Liquid Galaxy LAB** for the [Liquid Galaxy Project](https://www.liquidgalaxy.eu).

---

## 2. Project Description

City Historic Engine makes historical and cultural information easier to explore by combining a mobile catalog with the visualization power of Liquid Galaxy (Google Earth on a multi-screen panoramic rig).

From the app you can:

- Browse four categories: **Points of Interest**, **Cathedrals & Churches**, **Museums**, and **Historical Events**
- Search and filter places, then open a detail view with image, era, dates, and description
- Send a place to the Liquid Galaxy: the camera flies there, a balloon shows the story, and (when available) a wide image is shown across the central screens
- Orbit around the site and listen to the same text as the balloon (text-to-speech)
- Manage the rig from **Tools**: relaunch, reboot, shutdown, clean KMLs, show/hide logos

The app works as a catalog on its own. Connecting to Liquid Galaxy is optional and unlocks the immersive view.

**Languages:** English, Spanish, Catalan, Turkish  
**Theme:** light and dark

---

## 3. Frontend Development

Built with **Flutter**. The UI is organized by screens; Liquid Galaxy communication lives in services, not in the widgets.

### Tech stack

| Area | Technology |
| --- | --- |
| UI | Flutter (Material), custom theme |
| Connection to the rig | SSH (`dartssh2`) |
| Local settings | `shared_preferences` |
| Localized place texts | SQLite (`sqflite`) |
| Images / panorama slices | `image` |
| Narration | `flutter_tts` |

### App flow

1. Splash  
2. Home with the four categories  
3. Category list (search + filters)  
4. Launch screen for the selected place (send to LG, orbit, narration)  
5. Side menu: Connect, Tools, Settings, Help, About

### Project layout (`lib/`)

```
lib/
  screens/       UI pages (home, categories, connect, tools, settings…)
  widgets/       Shared UI (top bar, cards, menu, headers)
  services/      Liquid Galaxy, Chromium panoramas, narration, localization
  models/        POI model and SSH connection state
  kmls/          KML builders (logos, balloons, placemarks, outlines)
  data/          Place catalogs (names, outlines, Chromium images, Lleida seed)
  i18n/          UI translations (en / es / ca / tr)
  theme/         Light and dark theme
```

Category screens hold the places shown in the lists. A local database is used to enrich names and descriptions by language. Liquid Galaxy sending does not depend on changing that split.

### How to run

**Requirements**

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x)
- Android Studio (or another IDE) with an emulator or a device
- On **Windows**, enable **Developer Mode** so Flutter can create plugin symlinks  
  (`Settings → For developers`, or `start ms-settings:developers`)

```bash
git clone https://github.com/LiquidGalaxyLAB/lg-city-historic-engine.git
cd lg-city-historic-engine
flutter pub get
flutter run
```

Open the folder that contains `pubspec.yaml` (the project root), not the `android/` subfolder.

---

## 4. Integration with Liquid Galaxy

The app talks to the master machine (**lg1**) over **SSH**. Google Earth on each screen reloads KML files served from `http://lg1:81/`.

### Connect

Open **Connect** and fill in:

| Field | Typical value |
| --- | --- |
| User LG | `lg` |
| Password LG | `lg` |
| IP | IP of lg1 on the local network |
| Port | `22` |
| Password Admin | sudo password of the rig |
| Screens | `5` (or the number of screens in your rig) |

On success, credentials are saved and the partner logos are sent to the leftmost screen.

### What happens when you send a place

`LGService.presentPoi` runs a queued pipeline so two taps cannot overlap on the rig:

1. SSH session is checked (and reconnected if needed)
2. Previous balloon is hidden
3. If the place has a wide Chromium image, it is sliced and shown on the three central screens
4. Camera **FlyTo** the stored LookAt (lat, lng, range, heading, tilt)
5. For buildings: OSM-based **ground outline** + placemark. For historical events: outline is cleared so the story stays in the balloon
6. **Balloon** with the localized name, era, dates, and description
7. From the launch screen you can **orbit** and **narrate** (TTS uses the same text as the balloon)

KML files follow the Liquid Galaxy solo-KML convention: `master_1.kml` on the center machine, `slave_N.kml` on the others.

### Tools (rig management)

From **Tools**, with an active connection:

- Relaunch Liquid Galaxy
- Reboot / shutdown the rig
- Clean KMLs
- Clean logos / show or hide logos

These actions require SSH access and the admin password configured on Connect.

### Liquid Galaxy setup

To install or refresh a rig, see the [Liquid Galaxy LAB setup guide](https://github.com/LiquidGalaxyLAB/liquid-galaxy).

---

## 5. Personal Information

| Role | Name |
| --- | --- |
| Author | Yasmina Ramadan |
| Contact | yasiramadan@gmail.com |
| Mentor | Claudia Diosan |
| Organization administrator | Andreu Ibáñez |
| Support | Lleida Liquid Galaxy LAB |
| Logo designer | Paula Torne |
| History information | Alex Moix |
| Coordinates | David López Solá & Adrià Ballesteros Oro |

More about the organization: [liquidgalaxy.eu](https://www.liquidgalaxy.eu)

## License

LG City Historic Engine is licensed under the [MIT License](https://opensource.org/license/MIT)


