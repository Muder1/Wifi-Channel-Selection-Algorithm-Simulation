# Wifi-Channel-Selection-Algorithm-Simulation

A MATLAB-based simulation of a dynamic Wi-Fi channel selection system that compares multiple channel selection strategies under varying wireless network conditions.

## Overview

Wi-Fi performance is significantly affected by interference and channel congestion. Static channel allocation often results in poor network performance when channel conditions change over time.

This project simulates a dynamic wireless environment with 11 Wi-Fi channels and evaluates three different channel selection algorithms:

- **Fixed Channel Selection**
- **Greedy Channel Selection**
- **Smart Channel Selection**

The algorithms are compared using metrics such as Signal-to-Noise Ratio (SNR), throughput, effective throughput, and channel switching frequency.

---

## Features

- Simulation of a dynamic Wi-Fi environment
- Time-varying signal strength and interference
- SNR-based channel evaluation
- Three channel selection algorithms
- Throughput estimation using Shannon's Capacity Formula
- Performance comparison through graphical analysis
- Modular MATLAB implementation

---

## Project Structure

```
.
├── main.m
├── generate_environment.m
├── calculate_snr.m
├── fixed_selector.m
├── greedy_selector.m
├── smart_selector.m
├── throughput_model.m
├── plot_environment.m
├── plot_algorithm_results.m
└── README.md
```

---

## File Description

| File | Description |
|------|-------------|
| `main.m` | Main simulation script that initializes parameters, executes all algorithms, computes metrics, and generates plots. |
| `generate_environment.m` | Simulates signal strength and noise for all Wi-Fi channels over time. |
| `calculate_snr.m` | Computes Signal-to-Noise Ratio (SNR) for each Wi-Fi channel. |
| `fixed_selector.m` | Implements the Fixed Channel Selection algorithm. |
| `greedy_selector.m` | Selects the channel with the highest instantaneous SNR. |
| `smart_selector.m` | Implements a smart channel selection algorithm using moving-average SNR, hysteresis threshold, minimum dwell time, and scan interval. |
| `throughput_model.m` | Estimates throughput using Shannon's Capacity Formula. |
| `plot_environment.m` | Generates plots of the simulated wireless environment. |
| `plot_algorithm_results.m` | Visualizes the performance comparison of all channel selection algorithms. |

---

## Algorithms

### Fixed Algorithm
- Always selects a predefined Wi-Fi channel.
- No channel switching is performed.

### Greedy Algorithm
- Selects the channel with the highest instantaneous SNR.
- Achieves high throughput but switches channels frequently.

### Smart Algorithm
The Smart algorithm improves channel stability by using:

- Moving-average SNR
- Hysteresis threshold
- Minimum dwell time
- Periodic channel scanning
- Switching penalty

This reduces unnecessary channel changes while maintaining high communication performance.

---

## Simulation Parameters

| Parameter | Value |
|-----------|------:|
| Number of Channels | 11 |
| Simulation Steps | 1000 |
| Moving Average Window | 5 |
| Hysteresis Threshold | 3 dB |
| Minimum Dwell Time | 10 iterations |
| Scan Interval | 5 iterations |
| Switching Penalty | 0.5 |

---

## Performance Metrics

The simulation compares the algorithms using:

- Average Signal-to-Noise Ratio (SNR)
- Average Throughput
- Effective Throughput
- Number of Channel Switches

---

## Output

Running `main.m` generates:

### Console Output
- Average SNR
- Throughput
- Effective Throughput
- Number of Channel Switches

### Graphs
- Signal Strength
- Noise Level
- Average SNR
- SNR Heatmap
- Selected Channel vs Time
- Channel Switching Events
- Channel Usage Distribution
- Throughput Comparison
- Effective Throughput Comparison

---

## Requirements

- MATLAB R2021b or later
- No additional toolboxes required

---

## How to Run

1. Clone the repository.

```bash
git clone https://github.com/yourusername/WiFi-Channel-Selection.git
```

2. Open the project in MATLAB.

3. Run:

```matlab
main
```

The simulation will automatically display the results and generate the comparison plots.

---

## Future Improvements

- Reinforcement Learning-based channel selection
- Real Wi-Fi trace integration
- Simulink implementation
- RTL implementation for FPGA deployment
- Multi-user and multi-access point simulation

---

## Author

**Muder Batterywala**

B.Tech. Electrical Engineering  
Indian Institute of Technology Gandhinagar

---
