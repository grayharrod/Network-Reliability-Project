    %% Function runSingleLinkSim()
% Simulates the number of transmissions required to send an application
% message consisting of K packets across a single link network.
%
% Parameters:
%   K - Number of packets in the application message
%   p - Probability of packet failure on the link
%   N - Number of simulation iterations
%
% Returns:
%   result - Average number of individual link transmissions required 
%            across all simulations

function result = runSingleLinkSim(K, p, N)

    % Preallocate array to store total transmissions for each simulation
    simResults = ones(1, N);

    % Loop over each simulation iteration
    for i = 1:N
        txAttemptCount = 0;   % Count of individual link transmissions
        pktSuccessCount = 0;  % Number of packets successfully transmitted

        % Loop until all K packets are successfully transmitted
        while pktSuccessCount < K

            % Attempt transmission of one packet
            txAttemptCount = txAttemptCount + 1;
            r = rand;  % Random number to check packet success

            % Retry transmission until packet succeeds
            while r < p
                r = rand;  % Generate new random success check
                txAttemptCount = txAttemptCount + 1;  % Count retry
            end

            % Packet successfully transmitted
            pktSuccessCount = pktSuccessCount + 1;
        end

        % Record total transmissions for this simulation
        simResults(i) = txAttemptCount;
    end

    % Return the average number of transmissions across all simulations
    result = mean(simResults);

end
