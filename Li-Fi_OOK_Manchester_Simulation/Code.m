% ================================================================
% Li-Fi Communication Simulation using OOK with Manchester Encoding
% Author: Menna (Noise-Free Version)
% ================================================================
% This script simulates a simple Li-Fi system:
% - Generates random binary data
% - Encodes it using Manchester encoding
% - Modulates it using On-Off Keying (OOK)
% - Demodulates and decodes at the receiver
% - Evaluates performance using Bit Error Rate (BER) and energy efficiency
% - Animates the transmission and plots the results
% ================================================================

clc; clear; close all; % Clear console, workspace, and figures

%% Step 1: Binary Data Generation
% Generate random binary sequence of length 100
dataLength = 100; 
originalBits = randi([0 1], 1, dataLength); % Random 0s and 1s

%% Step 2: Manchester Encoding
% Encode the binary data using Manchester scheme
% Each bit is represented by 2 bits: 
%   1 -> [0 1] (LOW to HIGH)
%   0 -> [1 0] (HIGH to LOW)
manchesterSignal = manchester_encode(originalBits);

%% Step 3: OOK Modulation
% Perform On-Off Keying (OOK) modulation
% '1' means LED ON, '0' means LED OFF
ookSignal = ook_modulate(manchesterSignal);

%% Step 4: Receiver Side (Demodulation + Decoding)
% Demodulate OOK signal and decode the Manchester encoded data
% In this noise-free version, the modulated signal is directly used
threshold = 0.5; % Threshold for binary decision
decodedBits = manchester_decode(ookSignal, threshold);

%% Step 5: Evaluation Metrics
% Calculate Bit Error Rate (BER) and Energy Efficiency
% BER = number of bit errors / total bits
% Energy Efficiency = ratio of 'ON' time (LED ON) to total time
[ber, energyRatio] = calculate_ber(originalBits, decodedBits, manchesterSignal);

%% Step 7: Real-Time Transmission Animation
% Animate the encoding and OOK modulation in real-time
frameDelay = 0.05; % Delay per frame (adjust to slow down/speed up)
animate_transmission(manchesterSignal, ookSignal, frameDelay);

%% Step 6: Visualization
% Plot the original bits, Manchester encoded signal,
% OOK modulated signal, and decoded bits
plot_results(originalBits, manchesterSignal, ookSignal, decodedBits);

%% Display Metrics
% Print BER and energy efficiency to console
fprintf('Bit Error Rate (BER): %.4f\n', ber);
fprintf('Energy Efficiency (ON-time ratio): %.2f%%\n', energyRatio * 100);

% ================================================================
% --- Function Definitions ---
% ================================================================

%% Function: Manchester Encoding
function encoded = manchester_encode(bits)
    % Pre-allocate output array: each bit becomes 2 bits
    encoded = zeros(1, 2 * length(bits));
    % Loop through each bit and encode
    for i = 1:length(bits)
        if bits(i) == 1
            encoded(2*i-1:2*i) = [0 1]; % LOW to HIGH for '1'
        else
            encoded(2*i-1:2*i) = [1 0]; % HIGH to LOW for '0'
        end
    end
end

%% Function: OOK Modulation
function modulated = ook_modulate(signal)
    % For this simple case, OOK is direct mapping: 
    % 1 means LED ON, 0 means LED OFF
    modulated = signal; 
end

%% Function: Manchester Decoding
function decoded = manchester_decode(signal, threshold)
    % Convert to binary: signal > threshold → 1, else 0
    signal = double(signal > threshold);
    % Reshape into 2-row matrix: each column represents a Manchester pair
    bits = reshape(signal, 2, []);
    decoded = zeros(1, size(bits,2)); % Pre-allocate output
    % Loop through each Manchester pair and decode
    for i = 1:size(bits,2)
        if isequal(bits(:,i)', [0 1])
            decoded(i) = 1; % LOW to HIGH → '1'
        elseif isequal(bits(:,i)', [1 0])
            decoded(i) = 0; % HIGH to LOW → '0'
        else
            decoded(i) = NaN; % Invalid Manchester code
        end
    end
    % Replace any NaNs (errors) with zeros
    decoded(isnan(decoded)) = 0;
end

%% Function: BER & Energy Ratio
function [ber, energyRatio] = calculate_ber(original, received, encodedSignal)
    % Count number of bit errors
    errors = sum(original ~= received);
    % Calculate Bit Error Rate
    ber = errors / length(original);
    % Energy ratio = fraction of '1's in the encoded signal (LED ON time)
    energyRatio = sum(encodedSignal) / length(encodedSignal);
end

%% Function: Plot Results
function plot_results(original, encoded, modulated, received)
    % Create time axes for each signal
    t1 = 1:length(original);
    t2 = linspace(1, length(original), length(encoded));
    t3 = t2;
    t4 = t1;

    % Plot original binary data
    figure;
    subplot(4,1,1);
    stairs(t1, original, 'LineWidth', 2);
    title('Original Binary Data'); ylim([-0.2 1.2]); grid on;

    % Plot Manchester encoded signal
    subplot(4,1,2);
    stairs(t2, encoded, 'LineWidth', 2);
    title('Manchester Encoded Signal'); ylim([-0.2 1.2]); grid on;

    % Plot OOK modulated signal
    subplot(4,1,3);
    stairs(t3, modulated, 'LineWidth', 2);
    title('OOK Modulated Signal'); ylim([-0.2 1.2]); grid on;

    % Plot received decoded bits
    subplot(4,1,4);
    stairs(t4, received, 'LineWidth', 2);
    title('Received Demodulated Bits'); ylim([-0.2 1.2]); grid on;

    xlabel('Time');
end

%% Function: Real-Time Transmission Animation
function animate_transmission(encoded, modulated, delay)
    % Animate both Manchester and OOK signals frame-by-frame
    n = length(encoded);
    figure('Name','Real-Time Transmission','NumberTitle','off');
    for i = 1:n
        % Update Manchester signal subplot
        subplot(2,1,1);
        stairs(1:i, encoded(1:i), 'b', 'LineWidth', 2);
        title('Real-Time Manchester Encoding'); ylim([-0.2 1.2]);
        xlim([1 n]); grid on;

        % Update OOK signal subplot
        subplot(2,1,2);
        stairs(1:i, modulated(1:i), 'r', 'LineWidth', 2);
        title('Real-Time OOK Signal'); ylim([-0.2 1.2]);
        xlim([1 n]); grid on;

        drawnow; % Force update
        pause(delay); % Wait before next frame
    end
end
