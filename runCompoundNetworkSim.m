%% Function runCompoundNetworkSim()
% Simulates the number of transmissions required to send an application
% message consisting of K packets across a compound network:
% - Links A and B are in parallel
% - Link C follows in series
% Parameters:
%   K - Number of packets in the application message
%   p - Probability of failure for each individual link
%   N - Number of simulation iteration

function result = runCompoundNetworkSim(K, p, N)

    % Preallocate array to store total transmissions for each simulation
    simResults = ones(1, N);

    % Loop over each simulation iteration
    for i = 1:N
        txAttemptCount = 0;   % Count of individual link transmissions
        pktSuccessCount = 0;  % Number of packets successfully transmitted

        % Loop until all K packets are successfully transmitted
        while pktSuccessCount < K

            % Attempt transmission across parallel links A||B
            txAttemptCount = txAttemptCount + 1;   % A||B counts as one attempt
            a_ok = rand > p;  % Link A success
            b_ok = rand > p;  % Link B success

            % If parallel links fail, skip C and retry
            if ~(a_ok || b_ok)
                continue;  % Retry the whole attempt
            end

            % Attempt transmission across series link C
            txAttemptCount = txAttemptCount + 1;   % C counts as one attempt
            c_ok = rand > p;  % Link C success

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
