# 📟 HSPA Modem Interactive Call & SMS Engine

[![Linux Support](https://img.shields.io/badge/Platform-Linux-orange.svg?style=flat-square&logo=linux)](https://www.linux.org/)
[![Bash Script](https://img.shields.io/badge/Shell-Bash-4EAA25.svg?style=flat-square&logo=gnu-bash)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

A lightweight, automated, and interactive terminal utility that breathes new life into legacy **HSPA/3G USB mobile broadband hardware** (such as `1c9e:6061` devices). Move past basic cellular internet routing—this toolkit turns your Linux desktop into a functional SMS station and cellular phone utilizing your raw SIM card credits.

---

## 🔥 Key Features

* **Automated Hardware Discovery:** Dynamically detects and targets active `ModemManager` indexes (`0` or `1`) dynamically. No manual string mapping required.
* **Full-Duplex Audio Bridging:** Leverages the `sox` acoustics pipeline to capture and convert raw telecom audio streams (`u-law`, 8000Hz, mono) between hidden diagnostic serial lanes (`/dev/ttyUSB1` & `/dev/ttyUSB2`) and your PC's native microphone/speakers.
* **Smart Number Normalization:** Automatically intercepts local mobile carrier dialing structures (like Algerian `05XXXXXXXX`, `06XXXXXXXX`, `07XXXXXXXX`) and reformats them to international standards (`+213...`) to ensure flawless network trunk routing.
* **Volatile Lifecycle Control:** Automatically provisions, triggers, and cleanly wipes one-time-use cellular call and text objects inside the modem subsystem cache to prevent resource lockups.

---

## ⚙️ Core Prerequisites

Before launching the toolkit, make sure your Linux system has the foundational cellular wrappers and audio utilities installed:

```bash
sudo apt update
sudo apt install modemmanager usb-modeswitch sox libsox-fmt-all -y
