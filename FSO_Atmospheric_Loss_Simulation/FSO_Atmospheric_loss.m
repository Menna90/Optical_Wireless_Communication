%====================================================================
% Free-Space Optical (FSO) Link: Received Power vs Distance Simulation
% This script models how the received optical power varies with distance
% under different weather conditions (clear air, light fog, heavy fog).
% It considers both free-space path loss (FSPL) and atmospheric attenuation.
%====================================================================

clc;        % Clear the command window
clear;      % Remove all variables from workspace
close all;  % Close all open figure windows

%% =================== Step 1: Define Parameters ===================

Pt_mW = 10;  % Transmitter optical power in milliwatts (mW)

d = 100:100:2000;  % Link distance vector from 100m to 2000m in 100m steps

wavelength = 1550e-9;  % Wavelength of optical signal in meters (1550 nm)

c = 3e8;  % Speed of light in meters per second

f = c / wavelength;  % Optical carrier frequency in Hz

% Define atmospheric attenuation coefficients (Beer-Lambert Law)
% Values are in dB per kilometer for typical conditions
gamma_clear = 0.1;       % Clear air (low attenuation)
gamma_light_fog = 10;    % Light fog (moderate attenuation)
gamma_heavy_fog = 100;   % Heavy fog (severe attenuation)

% Create cell array for weather condition labels (for legend)
weather_conditions = {'Clear Air', 'Light Fog', 'Heavy Fog'};

% Store attenuation coefficients in array for easy iteration
gammas = [gamma_clear, gamma_light_fog, gamma_heavy_fog];

% Define different line styles and markers for each condition in plot
styles = {'-o', '--s', ':^'};

%% =================== Step 2: Free-Space Path Loss ===================

% Calculate FSPL (for reference, not used directly in received power calc)
fspl_dB = calc_fspl(d, f, c);

%% =================== Step 3 & 4: Atmospheric Attenuation & Plot ===================

% Create new figure for plotting
figure;
hold on;      % Allow multiple plots on same axes
grid on;      % Add grid for better readability

% Loop through each weather condition
for i = 1:length(gammas)
    % Compute received power in dBm for current condition
    Pr_dBm = calc_received_power(Pt_mW, gammas(i), d);
    
    % Plot received power vs distance
    plot(d, Pr_dBm, styles{i}, 'LineWidth', 2, 'DisplayName', weather_conditions{i});
end

% Label axes and add title
xlabel('Distance (m)');
ylabel('Received Power (dBm)');
title('FSO Link - Received Power vs Distance');

% Add legend in lower-left corner
legend('Location', 'southwest');

% Apply final plot formatting
plot_results();

%% =================== Step 5: Function Definitions ===================

%----------------------------------------------------
% Function to calculate Free-Space Path Loss (FSPL)
%----------------------------------------------------
function fspl = calc_fspl(d, f, c)
    % d : Distance in meters
    % f : Frequency in Hz
    % c : Speed of light in m/s
    % Returns FSPL in dB
    fspl = 20 * log10(d) + 20 * log10(f) + 20 * log10(4*pi / c);
end

%----------------------------------------------------
% Function to calculate received power using Beer-Lambert Law
%----------------------------------------------------
function Pr_dBm = calc_received_power(Pt_mW, gamma, d)
    % Pt_mW : Transmitter power in mW
    % gamma : Attenuation in dB/km
    % d : Distance vector in meters
    gamma_per_m = gamma / 1000;  % Convert attenuation to dB/m
    % Compute received power in mW using Beer-Lambert exponential decay
    Pr_mW = Pt_mW * exp(-gamma_per_m .* d);
    % Convert received power to dBm
    Pr_dBm = 10 * log10(Pr_mW);
end

%----------------------------------------------------
% Function for final plot appearance
%----------------------------------------------------
function plot_results()
    % Customize axes appearance
    set(gca, 'FontSize', 12);    % Increase font size for readability
    xlim([100 2000]);            % Limit x-axis range to match distance vector
end
