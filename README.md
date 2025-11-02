<h1 align="center">🚗 VCU Cluster Dashboard</h1>
<p align="center">
  <b>Digital Instrument Cluster for Electric Vehicles</b><br>
  Developed using <b>Qt QML, C/C++, Yocto Project, and Raspberry Pi 4</b>
</p>

---

### 🧠 About The Project
This project implements a **digital instrument cluster** (HMI) for an Electric Vehicle.  
It simulates real-time vehicle data (speed, battery, indicators) through a **CAN-based ECU node**,  
displayed on a modern, responsive **Qt Quick interface** running directly on Raspberry Pi 4 via **EGLFS**.

---

### 🧩 Features
- 📊 Real-time speedometer, tachometer, and power gauges.  
- 🌡️ Battery, temperature, and gear indicators.  
- 🚘 3D map-based navigation view (QML + Mapbox).  
- 🧠 CAN communication simulated via ECU node (C++).  
- ⚙️ Auto-launch with systemd on Yocto boot.  
- 💾 Custom Yocto recipe for Qt EGLFS deployment.  

---

### 🧱 Tech Stack
| Category | Technologies |
|-----------|--------------|
| **Languages** | C, C++, QML, JavaScript |
| **Frameworks** | Qt 5.15, Qt Quick Controls 2, EGLFS |
| **OS / Build System** | Yocto Project (kirkstone), Linux, Ubuntu |
| **Hardware** | Raspberry Pi 4 |
| **Communication** | CAN Bus (ECU Node Simulation) |

---

### 🧰 Folder Structure
```

VCU_Cluster_dashboard/
├── docs/               # Documentation (Yocto setup, Qt integration, etc.)
├── ecu_node/           # CAN communication & ECU simulation
├── software/           # Qt source code for dashboard UI
├── Screenshort/        # Screenshots of running dashboard
├── .gitignore
└── README.md

````

---

### 🖼️ UI Screenshots
Below are sample dashboards from the running system:

<p align="center">
  <img src="Screenshort/1.png" width="300"/> 
  <img src="Screenshort/2.png" width="300"/> 
  <img src="Screenshort/3.png" width="300"/> 
</p>

<p align="center">
  <img src="Screenshort/7.png" width="300"/> 
  <img src="Screenshort/8.png" width="300"/> 
  <img src="Screenshort/9.png" width="300"/> 
</p>

<p align="center">
  <img src="Screenshort/Main%20Menu.png" width="600"/>
</p>

---
