%% driver_generate_all_figures.m
% CENG-4213 Network Engineering
% Network Reliability Modeling Project
%
% This script runs all simulation tasks (1–5) for multiple K values and
% generates the required figures.
%
% NOTE: Ensure all run*.m function files are in the same directory.

clear; close all; clc;

%% ------------------------------------------------------------------------
% Global Parameters
% -------------------------------------------------------------------------
Ks = [1, 5, 15, 50, 100];      % Number of packets
N = 1000;                      % Simulation iterations per p
pVals = 0.01:0.01:0.99;        % Range of failure probabilities
colors = lines(numel(Ks));     % Distinct colors for each K value

%% ------------------------------------------------------------------------
% Task 1: Single Link Network
% -------------------------------------------------------------------------
for kidx = 1:numel(Ks)
    K = Ks(kidx);

    % Analytical (calculated) transmissions
    calc = K ./ (1 - pVals);

    % Monte Carlo simulation
    sim = arrayfun(@(p) runSingleLinkSim(K, p, N), pVals);

    % Plot per-K result
    figure('Name', sprintf('Task1_K_%d', K));
    semilogy(pVals, calc, '-', 'LineWidth', 1.6, 'Color', colors(kidx,:)); hold on;
    semilogy(pVals, sim, 'o', 'MarkerFaceColor', 'none', 'Color', colors(kidx,:));
    grid on;
    xlabel('Failure Probability');
    ylabel('Average Transmissions');
    title(sprintf('Task 1 – Single Link: K = %d', K));
    legend('Calculated', 'Simulated', 'Location', 'NorthWest');
end

% Combined figure for all K
figure('Name','Task1_AllK'); hold on;
for kidx = 1:numel(Ks)
    K = Ks(kidx);
    calc = K ./ (1 - pVals);
    sim = arrayfun(@(p) runSingleLinkSim(K, p, N), pVals);

    semilogy(pVals, calc, '-', 'LineWidth', 1.6, 'Color', colors(kidx,:));
    semilogy(pVals, sim, 'o', 'MarkerFaceColor', 'none', 'Color', colors(kidx,:));
end
xlabel('Failure Probability');
ylabel('Average Transmissions');
title('Task 1 – All K Values');
legend(arrayfun(@(x) sprintf('K=%d', x), Ks, 'UniformOutput', false), 'Location', 'NorthWest');
grid on;

%% ------------------------------------------------------------------------
% Task 2: Two Series Links
% -------------------------------------------------------------------------
for kidx = 1:numel(Ks)
    K = Ks(kidx);

    % Monte Carlo simulation
    sim = arrayfun(@(p) runTwoSeriesLinkSim(K, p, N), pVals);

    % Analytical transmissions: each packet success = (1 - p)^2
    calc = K ./ ((1 - pVals).^2);

    % Plot per-K result
    figure('Name', sprintf('Task2_K_%d', K));
    semilogy(pVals, calc, '-', 'LineWidth', 1.6, 'Color', colors(kidx,:), ...
        'DisplayName', sprintf('Calculated (K=%d)', K)); hold on;
    semilogy(pVals, sim, 'o', 'MarkerFaceColor', 'none', 'Color', colors(kidx,:), ...
        'DisplayName', sprintf('Simulated (K=%d)', K));
    grid on;
    xlabel('Failure Probability');
    ylabel('Average Transmissions');
    title(sprintf('Task 2 – Two Series Links: K = %d', K));
    legend('show', 'Location', 'NorthWest');
end

% Combined figure for all K
figure('Name','Task2_AllK'); hold on;
for kidx = 1:numel(Ks)
    K = Ks(kidx);
    sim = arrayfun(@(p) runTwoSeriesLinkSim(K, p, N), pVals);
    calc = K ./ ((1 - pVals).^2);

    semilogy(pVals, calc, '-', 'LineWidth', 1.6, 'Color', colors(kidx,:), ...
        'DisplayName', sprintf('Calc K=%d', K));
    semilogy(pVals, sim, 'o', 'MarkerFaceColor', 'none', 'Color', colors(kidx,:), ...
        'DisplayName', sprintf('Sim K=%d', K));
end
xlabel('Failure Probability');
ylabel('Average Transmissions');
title('Task 2 – All K Values (Two Series Links)');
legend('show', 'Location', 'NorthWest');
grid on;

%% ------------------------------------------------------------------------
% Task 3: Two Parallel Links
% -------------------------------------------------------------------------
for kidx = 1:numel(Ks)
    K = Ks(kidx);
    sim = arrayfun(@(p) runTwoParallelLinkSim(K, p, N), pVals);

    % Plot per-K result
    figure('Name', sprintf('Task3_K_%d', K));
    semilogy(pVals, sim, 'o', 'MarkerFaceColor', 'none', 'Color', colors(kidx,:));
    grid on;
    xlabel('Failure Probability');
    ylabel('Average Transmissions');
    title(sprintf('Task 3 – Two Parallel Links: K = %d', K));
    legend('Simulated', 'Location', 'NorthWest');
end

% Combined figure
figure('Name','Task3_AllK'); hold on;
for kidx = 1:numel(Ks)
    K = Ks(kidx);
    sim = arrayfun(@(p) runTwoParallelLinkSim(K, p, N), pVals);
    semilogy(pVals, sim, 'o', 'MarkerFaceColor', 'none', 'Color', colors(kidx,:));
end
xlabel('Failure Probability');
ylabel('Average Transmissions');
title('Task 3 – All K Values (Simulated)');
legend(arrayfun(@(x) sprintf('K=%d', x), Ks, 'UniformOutput', false), 'Location', 'NorthWest');
grid on;

%% ------------------------------------------------------------------------
% Task 4: Compound Network
% -------------------------------------------------------------------------
for kidx = 1:numel(Ks)
    K = Ks(kidx);
    sim = arrayfun(@(p) runCompoundNetworkSim(K, p, N), pVals);

    figure('Name', sprintf('Task4_K_%d', K));
    semilogy(pVals, sim, 'o', 'MarkerFaceColor', 'none', 'Color', colors(kidx,:)); hold on;
    grid on;
    xlabel('Failure Probability');
    ylabel('Average Transmissions');
    title(sprintf('Task 4 – Compound Network: K = %d', K));
    legend('Simulated', 'Location', 'NorthWest');
end

% Combined figure
figure('Name','Task4_AllK'); hold on;
for kidx = 1:numel(Ks)
    K = Ks(kidx);
    sim = arrayfun(@(p) runCompoundNetworkSim(K, p, N), pVals);
    semilogy(pVals, sim, 'o', 'MarkerFaceColor', 'none', 'Color', colors(kidx,:));
end
xlabel('Failure Probability');
ylabel('Average Transmissions');
title('Task 4 – All K Values (Simulated)');
legend(arrayfun(@(x) sprintf('K=%d', x), Ks, 'UniformOutput', false), 'Location', 'NorthWest');
grid on;

%% ------------------------------------------------------------------------
% Task 5: Custom Compound (different probabilities)
% -------------------------------------------------------------------------
% Removed clearvars/close all/clc to preserve previous figures

Ks = [1, 5, 10];             % K values for curves
N = 50;                      % simulation iterations
pRange = 0.01:0.01:0.99;     % variable probability from 1% to 99%
colors = lines(numel(Ks));   % color per K value

% Define figure settings: [p1_fixed, p2_fixed, p3_fixed, varying_link]
figSettings = {
    0.10, 0.60, [], 3;   % Figure 1: p3 varies
    0.60, 0.10, [], 3;   % Figure 2: p3 varies
    0.10, [], 0.60, 2;   % Figure 3: p2 varies
    0.60, [], 0.10, 2;   % Figure 4: p2 varies
    [], 0.10, 0.60, 1;   % Figure 5: p1 varies
    [], 0.60, 0.10, 1;   % Figure 6: p1 varies
};

for f = 1:size(figSettings,1)
    p1_fixed = figSettings{f,1};
    p2_fixed = figSettings{f,2};
    p3_fixed = figSettings{f,3};
    varyingLink = figSettings{f,4};  % 1=p1, 2=p2, 3=p3
    
    figure('Name',sprintf('Task5_Figure%d',f)); hold on;
    
    for kidx = 1:numel(Ks)
        K = Ks(kidx);
        simResults = zeros(size(pRange));
        
        for idx = 1:numel(pRange)
            switch varyingLink
                case 1
                    p1 = pRange(idx); p2 = p2_fixed; p3 = p3_fixed;
                case 2
                    p1 = p1_fixed; p2 = pRange(idx); p3 = p3_fixed;
                case 3
                    p1 = p1_fixed; p2 = p2_fixed; p3 = pRange(idx);
            end
            simResults(idx) = runCustomCompoundNetworkSim(K, p1, p2, p3, N);
        end
        
        semilogy(pRange, simResults, '-', 'LineWidth', 1.5, 'Color', colors(kidx,:), ...
            'DisplayName', sprintf('K=%d', K));
    end
    
    xlabel('Varying Failure Probability');
    ylabel('Average Transmissions (log scale)');
    title(sprintf('Task 5 – Figure %d', f));
    legend('show','Location','NorthWest');
    grid on;
end


