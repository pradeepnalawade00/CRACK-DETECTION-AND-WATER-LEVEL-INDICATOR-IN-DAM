# 🌊 IoT-Based Dam Crack Detection & Water Level Monitoring System

<div align="center">

![IoT](https://img.shields.io/badge/IoT-Enabled-27AE60?style=for-the-badge)
![MATLAB](https://img.shields.io/badge/MATLAB-Signal_Processing-0076A8?style=for-the-badge&logo=mathworks&logoColor=white)
![Embedded C](https://img.shields.io/badge/Embedded_C-Firmware-A8B9CC?style=for-the-badge)
![Safety Systems](https://img.shields.io/badge/Safety-Critical_System-E74C3C?style=for-the-badge)

*A real-time IoT system for structural crack detection and water level monitoring in dam infrastructure — enhancing public safety through intelligent sensing.*

</div>

---

## 📌 Project Overview

Dam failures pose catastrophic risks to life and infrastructure. This project addresses that risk with a **real-time monitoring system** combining **piezoelectric crack sensors**, **ultrasonic water level sensing**, and **MATLAB-based signal processing** — all integrated into an IoT framework for remote alerting and data logging.

The system continuously monitors two critical parameters:
1. **Structural Integrity** — Crack propagation detected via piezoelectric vibration sensors
2. **Water Level** — Real-time measurement using ultrasonic distance sensors

---

## ✨ Key Features

- ⚡ **Real-time Crack Detection** — Piezoelectric sensors detect micro-vibrations indicating crack propagation
- 💧 **Ultrasonic Water Level Sensing** — Continuous, contactless water level measurement
- 📊 **MATLAB Signal Processing** — Noise filtering, threshold analysis, and vibration spectrum analysis
- 🚨 **Multi-level Alert System** — Visual (LED), audible (buzzer), and IoT notification alerts
- 📡 **IoT Data Dashboard** — Remote monitoring via cloud platform (ThingSpeak/Blynk)
- 🔋 **Low-power Design** — Optimized for long-term autonomous field deployment

---

## 🏗️ System Architecture

```
┌──────────────────────────────────────────────────────┐
│                  DAM STRUCTURE                        │
│  ┌─────────────┐          ┌──────────────────┐       │
│  │Piezoelectric│          │  Ultrasonic      │       │
│  │Crack Sensor │          │  Water Level     │       │
│  └──────┬──────┘          └────────┬─────────┘       │
└─────────┼───────────────────────────┼────────────────┘
          │ Vibration Signal          │ Distance Pulse
          ▼                           ▼
    ┌───────────────────────────────────────┐
    │         Microcontroller Unit          │
    │  (Signal Conditioning + ADC + Logic)  │
    └─────────────────┬─────────────────────┘
                      │
          ┌───────────┼───────────┐
          ▼           ▼           ▼
    ┌──────────┐ ┌─────────┐ ┌──────────────┐
    │  MATLAB  │ │  Local  │ │  IoT Cloud   │
    │ Analysis │ │  Alerts │ │  Dashboard   │
    │ (PC/Lab) │ │(LED/Buz)│ │ (Remote Mon.)│
    └──────────┘ └─────────┘ └──────────────┘
```

---

## 🛠️ Tech Stack & Components

| Component | Specification | Role |
|-----------|---------------|------|
| **Microcontroller** | Arduino Uno / ESP8266 | System control & data acquisition |
| **Crack Sensor** | Piezoelectric Film Sensor | Structural vibration detection |
| **Water Level Sensor** | HC-SR04 Ultrasonic | Contactless water level measurement |
| **Signal Processing** | MATLAB R2022b | Frequency analysis & threshold detection |
| **IoT Platform** | ThingSpeak / Blynk | Cloud data logging & alerts |
| **Alert System** | LEDs + Piezo Buzzer | On-site warning indicators |
| **Power Supply** | 9V/12V regulated | System power |

---

## 📊 MATLAB Signal Processing

The MATLAB module performs the following analysis on raw sensor data:

1. **Low-pass Filtering** — Remove high-frequency noise from piezoelectric readings
2. **FFT Analysis** — Identify dominant vibration frequencies indicative of crack growth
3. **Threshold Detection** — Flag readings exceeding safe vibration amplitude limits
4. **Trend Visualization** — Time-series plots of both crack index and water level

```matlab
% Example: FFT-based crack detection
signal = readAnalog(sensor_pin);
filtered = lowpass(signal, cutoff_freq, sample_rate);
Y = fft(filtered);
f = sample_rate*(0:(N/2))/N;

if max(abs(Y)) > CRACK_THRESHOLD
    triggerAlert('CRACK_DETECTED');
end
```

---

## 🚨 Alert Levels

| Level | Condition | Action |
|-------|-----------|--------|
| 🟢 **NORMAL** | Water < 70%, No vibration | Green LED, data logging |
| 🟡 **WARNING** | Water 70–90% OR mild vibration | Yellow LED, IoT notification |
| 🔴 **CRITICAL** | Water > 90% OR crack threshold exceeded | Red LED + Buzzer + Emergency alert |

---

## 📁 Repository Structure

```
CRACK-DETECTION-AND-WATER-LEVEL-INDICATOR-IN-DAM/
│
├── firmware/
│   ├── main.ino                  # Arduino main firmware
│   ├── sensor_drivers.h          # Sensor abstraction layer
│   └── iot_client.h              # IoT platform client
│
├── matlab/
│   ├── signal_analysis.m         # Main MATLAB processing script
│   ├── filter_design.m           # Filter coefficient design
│   └── visualize_data.m          # Plotting and trend analysis
│
├── docs/
│   ├── circuit_schematic.pdf     # Full wiring diagram
│   ├── project_report.pdf        # Detailed project documentation
│   └── results/                  # Sample output graphs
│
└── README.md
```

---

## ⚙️ Setup Instructions

```bash
# Clone the repository
git clone https://github.com/pradeepnalawade00/CRACK-DETECTION-AND-WATER-LEVEL-INDICATOR-IN-DAM.git
```

1. **Flash firmware**: Open `firmware/main.ino` in Arduino IDE and flash to your board
2. **Configure IoT**: Update ThingSpeak API key in `firmware/iot_client.h`
3. **Run MATLAB scripts**: Open `matlab/signal_analysis.m` and run with sensor data connected
4. **Monitor dashboard**: View live data at your ThingSpeak channel

---

## 🎯 Real-World Impact

This system addresses a critical infrastructure safety gap — over **5,700 dams in India** are aging, and continuous monitoring is essential to prevent catastrophic failures like the **Machhu Dam disaster (1979)**. This IoT-based approach offers a low-cost, scalable alternative to expensive manual inspections.

---

## 🎓 Learning Outcomes

- IoT sensor integration and data acquisition
- Signal processing with MATLAB for real-world noise filtering
- Safety-critical system design with multi-level alerting
- Cloud IoT platform integration (ThingSpeak)

---

## 👤 Author

**Pradeep Nalawade** | ECE Student | IoT & Embedded Systems Engineer

[![Portfolio](https://img.shields.io/badge/Portfolio-Visit-A78BFA?style=flat-square)](https://pradeepnalawade00.github.io/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/pradeep-nalawade-950244314/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat-square&logo=github)](https://github.com/pradeepnalawade00)
