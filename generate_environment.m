function [signal, noise] = generate_environment(t)

num_channels = 11;

%% -------------------------------
% Base Signal Strength (dB)
%% -------------------------------

base_signal = [-50 -52 -55 -54 -53 -51 -52 -54 -56 -55 -53];

%% -------------------------------
% Base Noise (dBm)
%% -------------------------------

base_noise = [-70 -72 -74 -76 -78 -80 -82 -84 -86 -88 -90];

%% -------------------------------
% Signal Variation
%% -------------------------------

signal_variation = 2 * randn(1, num_channels);

signal = base_signal + signal_variation;

%% -------------------------------
% Channel-wise Traffic Load
%% -------------------------------

channel_load = 2 * sin(2*pi*t/200 + (1:num_channels));

%% -------------------------------
% Random Noise
%% -------------------------------

noise_variation = 3 * randn(1, num_channels);

%% -------------------------------
% Burst Interference
%% -------------------------------
% 5% probability of burst on each channel
% Burst magnitude varies between 10 dB and 15 dB

burst = (10 + 5*rand(1, num_channels)) .* (rand(1, num_channels) < 0.05);

%% -------------------------------
% Total Noise
%% -------------------------------

noise = base_noise ...
      + channel_load ...
      + noise_variation ...
      + burst;

end