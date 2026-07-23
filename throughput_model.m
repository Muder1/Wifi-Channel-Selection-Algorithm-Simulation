function throughput = throughput_model(snr_db)

% Convert dB to linear scale
snr_linear = 10^(snr_db/10);

% Normalized Shannon Capacity
throughput = log2(1 + snr_linear);

end