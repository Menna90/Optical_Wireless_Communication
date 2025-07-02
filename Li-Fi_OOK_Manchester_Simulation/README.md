# 📡 Li-Fi Communication Simulation using OOK with Manchester Encoding (noise-free version)

This MATLAB project simulates a simple Li-Fi (Light Fidelity) communication link.  
It demonstrates the full transmission chain: binary data generation, Manchester encoding, On-Off Keying (OOK) modulation, demodulation, decoding, BER calculation, energy efficiency evaluation, and real-time animation of the transmission process.

---

## 📋 Features

✅ Generate random binary data  
✅ Encode using Manchester encoding (clock recovery & error resilience)  
✅ Modulate with On-Off Keying (OOK) for optical transmission  
✅ Demodulate and decode the received signal  
✅ Calculate Bit Error Rate (BER) and energy efficiency (ON-time ratio)  
✅ Visualize all stages: original data, encoded signal, modulated signal, and decoded output  
✅ Real-time animation of the transmission process

---

## 📂 Project Structure

- **Main Script:** `LiFi_OOK_Manchester.m`  
- **Functions:** Defined within the script for encoding, modulation, demodulation, BER calculation, plotting, and animation.

---

## ⚙️ Requirements

- MATLAB (tested on R2023 or newer)
- No additional toolboxes needed

---

## 🚀 How to Run

1. Clone this repository:
   ```bash
   git clone https://github.com/Menna90/Optical_Wireless_Communication/new/main/Li-Fi_OOK_Manchester_Simulation
2. Open `LiFi_OOK_Manchester.m` in MATLAB.
3. Click Run or execute in the command window.

## 📈 Output
### Plots for:
- Original binary data
- Manchester encoded signal
- OOK modulated signal
- Received demodulated bits
### Console output:
- Bit Error Rate (BER)
- Energy efficiency (LED ON-time ratio)
### Real-time animated transmission

## 📌 Notes
- This simulation assumes a noise-free optical channel.
- You can extend it by adding channel noise, LED non-linearities, or ambient light interference.
- Contributions are welcome!
