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

Before launching the toolkit, make sure your Linux system has tiohe foundatnal cellular wrappers and audio utilities installed:

```bash
sudo apt update
sudo apt install modemmanager usb-modeswitch sox libsox-fmt-all -y


🚀 Quick Start Guide
1. Clone & Initialize
Get the tool up and running on your local machine instantly:

Bash
# Clone the repository
git clone https://github.com/0xWhoAmI-AB7/HSPA-modem-toolkit-for-linux.git

# Move into the workspace
cd HSPA-modem-toolkit

# Make the wrapper executable
chmod +x modem_tools.sh

# Launch the interactive system console
./modem_tools.sh
⚠️ Administrative Note: Because mmcli requires low-level kernel interaction to communicate with raw serial components, the script will request your sudo elevation password to access hardware lanes.

2. Install Globally (Optional)
To use the tool from any terminal directory at any time without pointing to this folder, establish it as a system binary:

Bash
sudo cp modem_tools.sh /usr/local/bin/modem_tools
sudo chmod +x /usr/local/bin/modem_tools
Now simply type:

Bash
modem_tools
🛠️ Diagnostics & Tweaks
Audio Stream Verification
If a voice call establishes perfectly but you experience silence, your specific hardware variant or network provider might have the internal audio lines flipped.

If this happens, open modem_tools.sh and locate lines 77 and 80. Simply swap the tracking entries:

Change /dev/ttyUSB2 to /dev/ttyUSB1 for the listener pipeline.

Change /dev/ttyUSB1 to /dev/ttyUSB2 for the microphone transmission loop.

🤝 Contributing
Got a patch for a specific brand of USB dongles? Found a way to expand USSD balance checks? Contributions are highly encouraged!

Fork the Project.

Create your Feature Branch (git checkout -b feature/AmazingFeature).

Commit your changes (git commit -m 'Add some AmazingFeature').

Push to the Branch (git push origin feature/AmazingFeature).

Open a Pull Request
## 📜 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
