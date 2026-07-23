function plot_environment(signal_history,noise_history,snr_history)

figure;
plot(mean(signal_history,2),'LineWidth',2);
grid on;
xlabel('Time Step');
ylabel('Signal Strength (dB)');
title('Average Signal Strength vs Time');

figure;
plot(mean(noise_history,2),'LineWidth',2);
grid on;
xlabel('Time Step');
ylabel('Noise Level (dB)');
title('Average Noise Level vs Time');

figure;
plot(mean(snr_history,2),'LineWidth',2);
grid on;
xlabel('Time Step');
ylabel('SNR (dB)');
title('Average SNR vs Time');

figure;
imagesc(snr_history);
colorbar;
xlabel('Wi-Fi Channel');
ylabel('Time Step');
title('SNR Distribution Across Wi-Fi Channels');

average_channel_snr = mean(snr_history);
figure;
bar(1:11, average_channel_snr);
grid on;
xlabel('Wi-Fi Channel');
ylabel('Average SNR (dB)');
title('Average SNR of Each Wi-Fi Channel');

end