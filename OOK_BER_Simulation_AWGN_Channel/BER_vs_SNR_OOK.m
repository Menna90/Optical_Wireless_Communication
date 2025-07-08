clc; clear; % Clear command window and workspace to start fresh

% ------------------ PARAMETERS ------------------
N = 1000;                      % Number of bits to transmit
SNR_dB_range = 0:2:20;         % Range of SNR values in dB for simulation

% ------------------ BIT GENERATION ------------------
tx_bits = generate_bits(N);    % Step 1: Generate random binary sequence

% ------------------ MODULATION ------------------
mod_signal = ook_modulate(tx_bits);  % Step 2: Perform OOK modulation

% ------------------ BER STORAGE ------------------
simulated_ber = zeros(size(SNR_dB_range));  % Array to store simulated BER
theory_ber = theoretical_ber(SNR_dB_range); % Compute theoretical BER for comparison

% ------------------ MAIN BER SIMULATION LOOP ------------------
for i = 1:length(SNR_dB_range)
    % Step 3: Add AWGN noise to the modulated signal for each SNR
    noisy_signal = add_awgn(mod_signal, SNR_dB_range(i));   
    
    % Step 4: Demodulate the received signal to recover bits
    rx_bits = ook_demodulate(noisy_signal);                 
    
    % Step 5: Calculate and store BER for current SNR
    simulated_ber(i) = calculate_ber(tx_bits, rx_bits);     
end

% ------------------ SIGNAL VISUALIZATION ------------------
% Step 6: Plot a portion of the transmitted and received signals for illustration
figure;
stairs(1:50, mod_signal(1:50), 'LineWidth', 1.5); hold on;
stairs(1:50, noisy_signal(1:50), 'LineWidth', 1.5);
legend('Transmitted Signal','Received Signal'); 
title('OOK Transmission');
xlabel('Bit Index'); ylabel('Amplitude');

% ------------------ BER PLOT ------------------
% Step 7: Plot simulated vs theoretical BER on a semilog graph
figure;
semilogy(SNR_dB_range, simulated_ber, 'o-', ... % Simulated BER curve
         SNR_dB_range, theory_ber, 'x--');      % Theoretical BER curve
grid on;
legend('Simulated BER','Theoretical BER','Location','southwest');
xlabel('SNR (dB)'); ylabel('Bit Error Rate');
title('BER vs SNR for OOK over AWGN');

% ------------------ FUNCTION DEFINITIONS ------------------

function bits = generate_bits(N)
% Generate N random bits (0 or 1)
% Input:  N - Number of bits
% Output: bits - Random binary row vector
bits = randi([0 1], 1, N);
end

function signal = ook_modulate(bits)
% Perform On-Off Keying (OOK) modulation
% 1 -> Light ON (amplitude 1), 0 -> Light OFF (amplitude 0)
% Input:  bits - binary row vector
% Output: signal - OOK modulated signal
signal = bits; % For OOK, bits map directly to signal amplitude
end

function noisy_signal = add_awgn(signal, SNR_dB)
% Add Additive White Gaussian Noise (AWGN) to signal
% Inputs:  signal  - modulated signal
%          SNR_dB  - Signal-to-Noise Ratio in dB
% Output:  noisy_signal - noisy received signal

signal_power = mean(signal.^2);      % Compute average signal power
snr_linear = 10^(SNR_dB/10);         % Convert SNR from dB to linear scale
noise_power = signal_power / snr_linear; % Compute required noise power
noise = sqrt(noise_power) * randn(size(signal)); % Generate Gaussian noise
noisy_signal = signal + noise;       % Add noise to signal
end

function rx_bits = ook_demodulate(rx_signal)
% Demodulate OOK signal using threshold detection
% If amplitude >= 0.5 -> 1, else -> 0
% Input:  rx_signal - noisy received signal
% Output: rx_bits   - recovered binary bits
rx_bits = double(rx_signal >= 0.5);
end

function ber = calculate_ber(tx_bits, rx_bits)
% Calculate Bit Error Rate (BER)
% Inputs:  tx_bits - transmitted bits
%          rx_bits - received bits
% Output:  ber     - bit error rate

errors = sum(tx_bits ~= rx_bits);    % Count number of bit errors
ber = errors / length(tx_bits);      % Compute BER
end

function ber = theoretical_ber(SNR_dB)
% Compute theoretical BER for OOK over AWGN channel
% For OOK, same as binary ASK: BER = Q(sqrt(2*Eb/N0))
% Input:  SNR_dB - array of SNR values in dB
% Output: ber    - theoretical BER values

snr_linear = 10.^(SNR_dB/10);        % Convert SNR from dB to linear scale
ber = qfunc(sqrt(2 * snr_linear));   % Use Q-function for theoretical BER
end
