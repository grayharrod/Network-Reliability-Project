%% Function runCustomCompoundNetworkSim()
% Simulates the number of transmissions required to send an application
% message consisting of K packets across a compound network with different
% failure probabilities per link:
% - Links A and B are in parallel with probabilities p1 and p2
% - Link C follows in series with probability p3
%

% Parameters:
%   K  - Number of packets in the application message
%   p1 - Probability of failure for link A
%   p2 - Probability of failure for link B
%   p3 - Probability of failure for link C
%   N  - Number of simulation iterations
%
           

function result = runCustomCompoundNetworkSim(K, p1, p2, p3, N)

    % Preallocate array to store total transmissions for each simulation
    simResults = ones(1, N);

    % Loop over each simulation iteration
    for i = 1:N
        txAttemptCount = 0;   % Count of individual link transmissions
        pktSuccessCount = 0;  % Number of packets successfully transmitted

        % Loop until all K packets are successfully transmitted
        while pktSuccessCount < K

            % Attempt transmission across parallel links A||B
            txAttemptCount = txAttemptCount + 1;   % Counts as 1 attempt
            a_ok = rand > p1;  % Link A success
            b_ok = rand > p2;  % Link B success

            % If both parallel links fail, retry
            if ~(a_ok || b_ok)
                continue;  % Retry the whole attempt
            end

            % Attempt transmission across series link C
            txAttemptCount = txAttemptCount + 1;   % Counts as 1 attempt
            c_ok = rand > p3;  % Link C success

            % Packet succeeds only if C succeeds
            if c_ok
                pktSuccessCount = pktSuccessCount + 1;
            end
        end

        % Record total transmissions for this simulation
        simResults(i) = txAttemptCount;
    end

    % Return the average number of transmissions across all simulations
    result = mean(simResults);

end
