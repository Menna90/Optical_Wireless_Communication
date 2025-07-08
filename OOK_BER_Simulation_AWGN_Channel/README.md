# On-Off Keying (OOK) BER Simulation over AWGN Channel

## 📌 Overview

This MATLAB project simulates an **On-Off Keying (OOK)** modulation scheme for a simple binary communication system and analyzes its performance in the presence of Additive White Gaussian Noise (AWGN). 
The Bit Error Rate (BER) is calculated through simulation and compared with the theoretical BER.

---

## 🔬 Theory

- **OOK Modulation:**  
  - OOK is the simplest form of amplitude shift keying (ASK). A binary '1' is transmitted as a light pulse (amplitude = 1), and a binary '0' is transmitted as no light (amplitude = 0).
  - Commonly used in optical wireless communication (e.g., VLC, Li-Fi).

- **AWGN Channel:**  
  - AWGN represents random noise that affects the signal during transmission. It is modeled as a zero-mean Gaussian process with a certain variance.

- **Bit Error Rate (BER):**  
  - For binary OOK over AWGN, the theoretical BER is:
    ```
    BER = Q( sqrt(2 * Eb/N0) )
    ```
  - Where `Q(x)` is the Q-function.
  - `Eb` means Energy per bit --> the average energy used to transmit one bit.
  - `N0` is the noise power spectral density (Watts per Hz) --> It represents how much noise power exists per unit bandwidth.
  - The ratio `Eb/N0` is the bit energy to noise power spectral density ratio.
---

## ⚙️ Code Structure

| Function | Purpose |
| -------- | ------- |
| `generate_bits(N)` | Generates a random binary sequence of length `N`. |
| `ook_modulate(bits)` | Maps bits to OOK symbols (0 or 1). |
| `add_awgn(signal, SNR_dB)` | Adds Gaussian noise to the signal for a given SNR. |
| `ook_demodulate(rx_signal)` | Recovers bits using threshold detection (threshold = 0.5). |
| `calculate_ber(tx_bits, rx_bits)` | Calculates the BER by comparing transmitted and received bits. |
| `theoretical_ber(SNR_dB)` | Computes theoretical BER for OOK over AWGN. |

---

## 📈 What Does It Do?

1. **Generate bits:** Create a random binary sequence of 0’s and 1’s.
2. **Modulate:** Use OOK where ‘1’ is light ON, ‘0’ is light OFF.
3. **Transmit through AWGN:** Add Gaussian noise to simulate real-world interference.
4. **Demodulate:** Use a threshold to decide if received signal represents 0 or 1.
5. **Calculate BER:** Compare transmitted and received bits.
6. **Compare:** Plot both simulated BER and theoretical BER for various SNRs.

---

## 📊 Plots

1. **Signal Visualization:**  
   - Shows how the modulated signal looks before and after noise is added.

2. **BER vs. SNR Curve:**  
   - Shows how the probability of error decreases as the SNR increases.
   - Simulated BER should closely match theoretical BER, validating the model.

---

## ▶️ How to Run

1. Save the MATLAB script to your working directory (e.g., `BER_vs_SNR_for_OOK.m`).
2. Open MATLAB.
3. Run the script:
   ```matlab
   BER_vs_SNR_for_OOK

## 📝 Notes
You can adjust:
1. N: Number of bits (larger N gives more accurate results).
2. SNR_dB_range: To cover a wider or narrower SNR range.

This simple simulation assumes:
- Perfect synchronization.
- No inter-symbol interference (ISI).
- Hard-decision threshold detection.

## 👩‍💻 Author
This simulation template is designed for beginners learning the fundamentals of digital modulation and channel noise effects.
### Happy coding! 🚀
