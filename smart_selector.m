function [channel, dwell_counter, switch_count] = ...
    smart_selector(average_snr, ...
                   channel, ...
                   dwell_counter, ...
                   switch_count, ...
                   iteration, ...
                   threshold, ...
                   min_dwell, ...
                   scan_interval)

%---------------------------------------------------------
% SMART CHANNEL SELECTOR
%
% Inputs:
%   average_snr     -> Moving average SNR of all channels
%   channel         -> Current selected channel
%   dwell_counter   -> Number of iterations spent on current channel
%   switch_count    -> Total channel switches so far
%   iteration       -> Current simulation step
%   threshold       -> Minimum SNR improvement required (dB)
%   min_dwell       -> Minimum stay on a channel
%   scan_interval   -> Scan channels every N iterations
%
% Outputs:
%   channel
%   dwell_counter
%   switch_count
%---------------------------------------------------------

%% Increase dwell counter

dwell_counter = dwell_counter + 1;

%% Only scan every SCAN_INTERVAL iterations

if mod(iteration, scan_interval) ~= 0
    return;
end

%% Current channel quality

current_snr = average_snr(channel);

%% Best available channel

[best_snr, best_channel] = max(average_snr);

%% Decide whether to switch

if dwell_counter >= min_dwell

    if (best_snr - current_snr) > threshold

        channel = best_channel;

        dwell_counter = 0;

        switch_count = switch_count + 1;

    end

end

end