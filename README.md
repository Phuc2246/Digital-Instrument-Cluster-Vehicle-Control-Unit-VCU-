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

### ⚙️ Build & Run (Yocto)
1. Clone Yocto (kirkstone) and required layers:
   ```bash
   git clone -b kirkstone https://git.yoctoproject.org/poky
   git clone -b kirkstone https://github.com/meta-qt5/meta-qt5.git
   git clone -b kirkstone https://github.com/openembedded/meta-openembedded.git
   git clone -b kirkstone https://github.com/agherzan/meta-raspberrypi.git
````

2. Configure `local.conf`:

   ```bash
   MACHINE = "raspberrypi4"
   DISTRO_FEATURES:append = " eglfs opengl"
   IMAGE_INSTALL:append = " project1 qtbase qtdeclarative qtquickcontrols2 qtgraphicaleffects"
   ```
3. Add custom layer:

   ```bash
   bitbake-layers add-layer ../meta-myproj
   ```
4. Build:

   ```bash
   bitbake core-image-base
   ```

---

### 🧠 Developer Info

**Nguyễn Hồng Phúc**
🎓 Computer Engineering – HCMUTE
🔧 Focus: Embedded Linux, Qt HMI, Yocto Project, Automotive Systems

---

### 💻 Currently Working With

<p>
  <img src="https://img.shields.io/badge/C-00599C?style=for-the-badge&logo=c&logoColor=white"/>
  <img src="https://img.shields.io/badge/C++-00599C?style=for-the-badge&logo=cplusplus&logoColor=white"/>
  <img src="https://img.shields.io/badge/QT-41CD52?style=for-the-badge&logo=qt&logoColor=white"/>
  <img src="https://img.shields.io/badge/YOCTO-000000?style=for-the-badge&logo=yoctoproject&logoColor=white"/>
  <img src="https://img.shields.io/badge/LINUX-FCC624?style=for-the-badge&logo=linux&logoColor=black"/>
</p>

---

### 🧭 Contact

<p align="center">
  <a href="mailto:nguyenhongphuc.dev@gmail.com">
    <img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white"/>
  </a>
  <a href="https://www.linkedin.com/in/nguyenhongphuc2246/">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white"/>
  </a>
  <a href="https://github.com/Phuc2246">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
  </a>
</p>

---

⭐ *If you like this project, consider giving it a star on GitHub!*

````

---

### ✅ Hướng dẫn thêm nhanh:
- Đặt file này vào `C:\Users\ACER\Documents\VCU_Cluster_dashboard\README.md`
- Commit và push lại:

```bash
git add README.md
git commit -m "Add professional README with screenshots and badges"
git push
````

---

