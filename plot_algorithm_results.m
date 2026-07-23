function plot_algorithm_results(...
    fixed_snr,...
    greedy_snr,...
    smart_snr,...
    fixed_channel,...
    greedy_channel,...
    smart_channel,...
    greedy_switch_events,...
    smart_switch_events,...
    fixed_throughput,...
    greedy_throughput,...
    smart_throughput,...
    fixed_effective,...
    greedy_effective,...
    smart_effective)

figure;
plot(fixed_snr,'LineWidth',1.5);
hold on;
plot(greedy_snr,'LineWidth',1.5);
grid on;
xlabel('Time Step');
ylabel('SNR (dB)');
legend('Fixed','Greedy');
title('Fixed vs Greedy Channel Selection');

figure;
plot(fixed_snr,'LineWidth',1.5);
hold on;
plot(greedy_snr,'LineWidth',1.5);
plot(smart_snr,'LineWidth',1.5);
grid on;
xlabel('Time Step');
ylabel('SNR (dB)');
title('SNR Comparison of Channel Selection Algorithms');
legend('Fixed','Greedy','Smart','Location','best');

figure;
plot(fixed_channel,'LineWidth',1.5);
hold on;
plot(greedy_channel,'LineWidth',1.5);
plot(smart_channel,'LineWidth',1.5);
grid on;
xlabel('Time Step');
ylabel('Selected Channel');
yticks(1:11);
title('Selected Wi-Fi Channel');
legend('Fixed','Greedy','Smart','Location','best');

figure;
stem(greedy_switch_events,...
    'filled',...
    'DisplayName','Greedy');
hold on;
stem(smart_switch_events,...
    'filled',...
    'DisplayName','Smart');
grid on;
xlabel('Time Step');
ylabel('Switch Event');
title('Channel Switching Events');
legend('Location','best');

figure;
subplot(1,2,1);
histogram(greedy_channel,1:12);
grid on;
xlabel('Channel');
ylabel('Frequency');
title('Greedy Channel Usage');
subplot(1,2,2);
histogram(smart_channel,1:12);
grid on;
xlabel('Channel');
ylabel('Frequency');
title('Smart Channel Usage');

figure;
bar([...
    mean(fixed_throughput),...
    mean(greedy_throughput),...
    mean(smart_throughput)]);
grid on;
xticklabels({'Fixed','Greedy','Smart'});
ylabel('Normalized Throughput (bits/s/Hz)');
title('Average Throughput');

figure;
bar([...
    mean(fixed_effective),...
    mean(greedy_effective),...
    mean(smart_effective)]);
grid on;
xticklabels({'Fixed','Greedy','Smart'});
ylabel('Normalized Throughput (bits/s/Hz)');
title('Average Effective Throughput');

figure;
boxplot([...
    fixed_snr,...
    greedy_snr,...
    smart_snr],...
    'Labels',{'Fixed','Greedy','Smart'});
grid on;
ylabel('SNR (dB)');
title('Distribution of SNR');