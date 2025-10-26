%% Function runTwoSeriesLinkSim()
% Simulates the number of transmissions required to send an application
% message consisting of K packets across two links in series.
% Parameters:
%   K - Number of packets in the application message
%   p - Probability of failure for each individual link
%   N - Number of simulation iterations
%
% Returns:
%   result - Average number of individual link transmissions required 
%            across all simulations

function result = runTwoSeriesLinkSim(K, p, N)

    % Preallocate array to store total transmissions for each simulation
    simResults = ones(1, N);

    % Loop over each simulation iteration
    for i = 1:N
        txAttemptCount = 0;   % Count of individual link transmissions
        pktSuccessCount = 0;  % Number of packets successfully transmitted

        % Loop until all K packets are successfully transmitted
        while pktSuccessCount < K

            % Attempt across the two series links
            txAttemptCount = txAttemptCount + 2;  % One attempt for each link
            a_ok = rand > p;  % Link A success
            b_ok = rand > p;  % Link B success

            % Packet succeeds only if both links succeed
            if a_ok && b_ok
                pktSuccessCount = pktSuccessCount + 1;
            end
        end

        % Record total transmissions for this simulation
        simResults(i) = txAttemptCount;
    end

    % Return the average number of transmissions across all simulations
    result = mean(simResults);

end
