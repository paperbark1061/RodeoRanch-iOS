# RodeoRanch iOS

Rider & Judge iPhone app for the RodeoRanch equestrian event management platform.

## Overview

This app connects to the hosted RodeoRanch web platform and provides a mobile-optimised interface for:
- **Riders** — event entries, draw positions, live scores, run history, horse management, standings
- **Judges** — score entry, run timer, penalty buttons, discipline-aware scoring screens

## Requirements

- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

## Getting started

1. Clone this repo
2. Open `RodeoRanch.xcodeproj` in Xcode
3. Select a simulator or connected device (iPhone 14 or later recommended)
4. Build & run (`⌘R`)

No API keys required for demo mode — the app ships with mock data and also connects to `https://rodeo-ranch.vercel.app` for live demo data.

## Architecture

```
RodeoRanch/
├── App/                    Entry point, app config
├── Core/
│   ├── Network/            API service layer
│   ├── Models/             Shared data models
│   ├── Auth/               Authentication state
│   └── Mock/               Mock data for demo mode
├── Features/
│   ├── Auth/               Login / register screens
│   ├── Dashboard/          Home screen (role-aware)
│   ├── Events/             Event list & entry flow
│   ├── MyRuns/             Run history & results
│   ├── Horses/             Horse registration & management
│   ├── Standings/          Live leaderboard
│   ├── Notifications/      Push & in-app notifications
│   ├── Profile/            Rider profile & settings
│   └── Judge/              Judge mode — score entry, timer, penalties
└── DesignSystem/           Colours, typography, reusable components
```

## API

The app targets `https://rodeo-ranch.vercel.app` in demo mode.  
Update `Core/Network/APIConfig.swift` to point at a live Railway backend when ready.

## Disciplines supported

| Discipline | Scoring type |
|---|---|
| Team Penning | Cattle count + time |
| Cutting | Judge points (60–80 NCHA scale) |
| Sorting | Cattle count + time |
| Barrel Racing | Time (1D–4D divisions) |
| General Rodeo | Configurable per event |

## Related repos

- [RodeoRanch](https://github.com/paperbark1061/RodeoRanch) — Web platform (HTML demo + API scaffold)
- RodeoRanch-ClubAdmin *(coming soon)* — Club & event management app
