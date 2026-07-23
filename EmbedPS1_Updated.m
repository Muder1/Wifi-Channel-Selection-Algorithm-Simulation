clc;
clear;
close all;

%% PARAMETERS

num_steps = 1000;
num_channels = 11;

history_length = 5;

THRESHOLD = 3;          % dB
MIN_DWELL = 10;         % iterations
SCAN_INTERVAL = 5;      % iterations
SWITCH_PENALTY = 0.5;

%% STORAGE

snr_window = NaN(num_channels,history_length);

signal_history = zeros(num_steps,num_channels);
noise_history  = zeros(num_steps,num_channels);
snr_history    = zeros(num_steps,num_channels);

%% FIXED ALGORITHM

fixed_channel = fixed_selector();

fixed_channel_history = zeros(num_steps,1);
fixed_snr_history = zeros(num_steps,1);

%% GREEDY ALGORITHM

greedy_channel_history = zeros(num_steps,1);
greedy_snr_history = zeros(num_steps,1);

greedy_previous_channel = 6;

greedy_switch_count = 0;
greedy_switch_events = zeros(num_steps,1);
greedy_penalty = zeros(num_steps,1);


%% SMART ALGORITHM

smart_channel = 6;

smart_dwell_counter = MIN_DWELL;      % Allow switching initially

smart_switch_count = 0;

smart_channel_history = zeros(num_steps,1);
smart_snr_history = zeros(num_steps,1);

smart_switch_events = zeros(num_steps,1);
smart_penalty = zeros(num_steps,1);

%% Throughput History

fixed_throughput = zeros(num_steps,1);
greedy_throughput = zeros(num_steps,1);
smart_throughput = zeros(num_steps,1);

%% Effective Throughput

fixed_effective = zeros(num_steps,1);
greedy_effective = zeros(num_steps,1);
smart_effective = zeros(num_steps,1);


%% ============================
%% MAIN SIMULATION
%% ============================

for t = 1:num_steps

    % Generate environment

    [signal,noise] = generate_environment(t);

    snr = calculate_snr(signal,noise);

    % Store data

    signal_history(t,:) = signal;
    noise_history(t,:) = noise;
    snr_history(t,:) = snr;

    %-----------------------------------------
    % Update Moving Average Window
    %-----------------------------------------

    snr_window(:,1:end-1) = snr_window(:,2:end);

    snr_window(:,end) = snr';

    average_snr = mean(snr_window,2,'omitnan');

    %-----------------------------------------
    % FIXED
    %-----------------------------------------

    fixed_channel_history(t) = fixed_channel;

    fixed_snr_history(t) = snr(fixed_channel);

    %-----------------------------------------
    % GREEDY
    %-----------------------------------------

    greedy_channel = greedy_selector(snr);

    greedy_channel_history(t) = greedy_channel;

    greedy_snr_history(t) = snr(greedy_channel);

    if greedy_channel ~= greedy_previous_channel

        greedy_switch_count = greedy_switch_count + 1;

        greedy_switch_events(t) = 1;

    end

    greedy_previous_channel = greedy_channel;
    greedy_penalty(t) = SWITCH_PENALTY * greedy_switch_events(t);


    %-----------------------------------------
    % SMART
    %-----------------------------------------

    previous_smart_channel = smart_channel;

    [smart_channel,...
     smart_dwell_counter,...
     smart_switch_count] = ...
     smart_selector(...
         average_snr,...
         smart_channel,...
         smart_dwell_counter,...
         smart_switch_count,...
         t,...
         THRESHOLD,...
         MIN_DWELL,...
         SCAN_INTERVAL);
    
    smart_channel_history(t) = smart_channel;
    smart_snr_history(t) = snr(smart_channel);
    
    if smart_channel ~= previous_smart_channel
        smart_switch_events(t) = 1;
    end
    

    smart_penalty(t) = SWITCH_PENALTY * smart_switch_events(t);

    %% Throughput

    fixed_throughput(t) = ...
        throughput_model(fixed_snr_history(t));

    greedy_throughput(t) = ...
        throughput_model(greedy_snr_history(t));

    smart_throughput(t) = ...
        throughput_model(smart_snr_history(t));


    fixed_effective(t) = fixed_throughput(t);

    greedy_effective(t) = ...
        greedy_throughput(t) ...
        - greedy_penalty(t);

    smart_effective(t) = ...
        smart_throughput(t) ...
        - smart_penalty(t);

end

%% ============================
%% RESULTS
%% ============================

fprintf("\n");
fprintf("===============================================================\n");
fprintf("%-12s %-12s %-12s %-12s\n", ...
        "Metric","Fixed","Greedy","Smart");
fprintf("===============================================================\n");

fprintf("%-12s %-12.2f %-12.2f %-12.2f\n", ...
        "Avg SNR", ...
        mean(fixed_snr_history), ...
        mean(greedy_snr_history), ...
        mean(smart_snr_history));

fprintf("%-12s %-12.2f %-12.2f %-12.2f\n", ...
        "Throughput", ...
        mean(fixed_throughput), ...
        mean(greedy_throughput), ...
        mean(smart_throughput));

fprintf("%-12s %-12.2f %-12.2f %-12.2f\n", ...
        "Effective Throughput", ...
        mean(fixed_effective), ...
        mean(greedy_effective), ...
        mean(smart_effective));

fprintf("%-12s %-12d %-12d %-12d\n", ...
        "Switches", ...
        0, ...
        greedy_switch_count, ...
        smart_switch_count);

fprintf("===============================================================\n");

%% ============================
%% PLOTS
%% ============================

plot_environment(signal_history,noise_history,snr_history);

plot_algorithm_results(...
    fixed_snr_history,...
    greedy_snr_history,...
    smart_snr_history,...
    fixed_channel_history,...
    greedy_channel_history,...
    smart_channel_history,...
    greedy_switch_events,...
    smart_switch_events,...
    fixed_throughput,...
    greedy_throughput,...
    smart_throughput,...
    fixed_effective,...
    greedy_effective,...
    smart_effective);