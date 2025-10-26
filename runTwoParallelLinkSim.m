%% Function runTwoParallelLinkSim()
% Simulates the number of transmissions required to send an application
% message consisting of K packets across two parallel links.
% Parameters:
%   K - Number of packets in the application message
%   p - Probability of failure for each individual link
%   N - Number of simulation iterations
%
% Returns:
%   result - Average number of transmissions required across all simulations

function result = runTwoParallelLinkSim(K, p, N)

    % Preallocate array to store total transmissions for each simulation
    simResults = ones(1, N);

    % Loop over each simulation iteration
    for i = 1:N
        txAttemptCount = 0;   % Total transmission attempts for this simulation
        pktSuccessCount = 0;  % Number of packets successfully transmitted

        % Loop until all K packets are successfully transmitted
        while pktSuccessCount < K
            txAttemptCount = txAttemptCount + 1;  % One attempt across both links

            % Check success for each parallel link
            a_ok = rand > p;  % Link A success
            b_ok = rand > p;  % Link B success

            % Packet succeeds if either link succeeds
            if a_ok || b_ok
                pktSuccessCount = pktSuccessCount + 1;
            end
        end

        % Record total transmissions for this simulation
        simResults(i) = txAttemptCount;
    end

    % Return the average number of transmissions across all simulations
    result = mean(simResults);

end
