# 📡 Free-Space Optical (FSO) Link Simulation: Received Power vs Distance

This MATLAB project simulates a **Free-Space Optical (FSO) communication link** and analyzes how the received optical power varies with **link distance** under different **weather conditions**.

---

## 🔬 **Theory**

### 1️⃣ Free-Space Optical Communication
- FSO systems transmit data using light through open air, similar to fiber optics but without the fiber.
- Advantages: High bandwidth, immunity to electromagnetic interference.
- Limitation: Highly sensitive to atmospheric conditions.

### 2️⃣ Free-Space Path Loss (FSPL)
- Light traveling through free space experiences spreading loss.
- FSPL (in dB) is calculated using:
`FSPL = 20 * log10(d) + 20 * log10(f) + 20 * log10(4π / c)`
where:
- `d` = distance in meters
- `f` = frequency in Hz
- `c` = speed of light (3 × 10⁸ m/s)

### 3️⃣ Atmospheric Attenuation
- **Beer-Lambert Law** describes how atmospheric particles (fog, rain, dust) cause exponential decay of signal power.
- The received power is given by:

  `Pr(d) = Pt * exp(-γ * d)`
  where:
- `Pt` is the transmitter power,
- `γ` is the attenuation coefficient in dB/km,
- `d` is the distance in meters.

---

## 📈 **What This Code Does**

- Defines a range of link distances (100 m to 2000 m).
- Calculates FSPL for reference.
- Computes received power for 3 weather conditions:
- Clear Air (low attenuation)
- Light Fog (moderate attenuation)
- Heavy Fog (high attenuation)
- Plots `Received Power (dBm)` vs `Distance (m)`.

---

## 🚀 **How To Use**

### ✅ Prerequisites
- MATLAB installed (any version supporting basic plotting).

### ✅ Run the Code
1. Copy the entire `.m` script into your MATLAB workspace.
2. Run the script.  
3. The plot will show how received power drops with distance for each weather scenario.

---

## ⚙️ **Parameters You Can Modify**

| Parameter           | Description                       | Example Values     |
|---------------------|-----------------------------------|--------------------|
| `Pt_mW`             | Transmitter power (in mW)         | 10 mW              |
| `wavelength`        | Wavelength of optical signal      | 1550 nm (1.55e-6 m)|
| `gamma_*`           | Atmospheric attenuation (dB/km)   | 0.1, 10, 100       |
| `d`                 | Link distances                    | 100:100:2000       |

Change these to model your specific FSO system.

---

## ✍️ **Contact**

Feel free to use, modify, or expand this simulation.  
If you have any questions, feel free to reach out!

---
**License:** MIT
