# Scrcpy-AutoConnect
Scrcpy AutoConnect &amp; Find Port - Wireless Debugging Feature - Hardcode IP feature

# ADB AutoConnect Tool

A Batch script to quickly connect to an Android device over Wi-Fi using ADB (Android Debug Bridge) by automatically discovering the ADB port.

## Features

- **Auto Port Scanning**: Scans ports `30000-41000` on `192.168.1.244` to find the ADB port.
- **Fast Connection**: Uses `nmap` with aggressive timing (`-T4`) for rapid scanning.
- **Port Storage**: Saves the last successful port to `1port.txt` for future use.
- **One-Click Execution**: No menus or prompts — runs automatically.
- **Error Handling**: Provides clear feedback for connection failures.

---

## Requirements

- **`nmap`**: Installed and added to your system's `PATH`. [Download nmap](https://nmap.org).
- **ADB Over Wi-Fi**: Enabled on the Android device (Developer Options > Wireless Debugging).
- **Same Network**: The PC and Android device must be on the same Wi-Fi network.

---

## Quick Start

1. **Enable Wireless Debugging**:
   - On your Android device:  
     `Settings > Developer Options > Wireless Debugging` ➔ Enable.

2. **Place the Script**:
   - Copy `AutoConnect.bat` to your `scrcpy` directory (where `adb.exe` is located).

3. **Run the Script**:
   - Double-click `AutoConnect.bat`.

---

## How It Works

### Auto Find Port
- The script scans `192.168.1.244` for open ADB ports between **30000-41000** using:  
  ```bash
  nmap -T4 -Pn -n --min-rate 5000 -p 30000-41000 192.168.1.244
  ```
  - `-T4`: Aggressive speed mode.  
  - `-Pn`: Skips host discovery.  
  - `--min-rate 5000`: Sends packets rapidly for faster results.

### Connection Attempt
- If a port is found (e.g., `30000`), it runs:  
  ```bash
  adb connect 192.168.1.244:30000
  ```
- On success:  
  - Saves the port to `1port.txt`.  
  - Launches `scrcpy-console.bat` for screen mirroring.

### Error Handling
- **No Port Found**:  
  - Checks if:
    1. The device is on and connected to Wi-Fi.
    2. ADB debugging is enabled.
    3. The port is within `30000-41000`.
- **Connection Failed**:  
  - Ensures ADB is running on the device.

---

## Notes

- **IP Address**: Hardcoded to `192.168.1.244` (modify the script if your device uses a different IP).
- **Port Range**: Adjust the range in the script if your device uses ports outside `30000-41000`.
- **No Manual Input**: The script runs fully automatically — no menus or prompts.

---

📌 **Tip**: I recommend to Disable ADB authorization timeout or you will have to reauthorize debugging permissions 
