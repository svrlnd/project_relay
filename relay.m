%% First case


% Probability of transmission attempt from S1,S2 and R if queues > 0
q1 = 0.3;
q2 = 0.3;
q0 = 0.45;

% Transmission success probabilities
p10 = 0.9;
p13 = 0.25;
p20 = 0.9;
p23 = 0.25;
p03 = 0.9;

lambda1 = linspace(0,1,11);  % Gör så vi kan plotta grejer mot olika lambdavärden
lambda2 = linspace(0,1,11); 

ankomster0 = zeros(10000,1);
ankomster10 = zeros(10000,1);
ankomster20 = zeros(10000,1);
ankomster0D = zeros(10000,1);
ankomster1D = zeros(10000,1);
ankomster2D = zeros(10000,1);
ankomsterD = zeros(10000,1);

msg10 = q1 * p10;
msg1D = q1 * p13;
msg20 = q2 * p20;
msg2D = q2 * p23;
msg0 = q0 * p03;

timeslots = zeros(10000,1);

RelayArrivals = zeros(11,11);
arrivalRateRelay = zeros(11,11);
Q_array = zeros(11,11);
Q_prob = zeros(11,11);




for j = 1:length(lambda1)
    ankomster1 = rand(10000,1) <= lambda1(j); % Arrivals to S1
    
    for k = 1:length(lambda2)
    ankomster2 = rand(10000,1) <= lambda2(k); % Arrivals to S2
    
    Q1 = 0;
    Q2 = 0;
    Q0 = 0;
    D = 0;
    RelayFails = 0;
    DestinationFails = 0;
        
        for i = 1:length(timeslots)
    
    
            % If arrival, add one to the queue in S1
            if ankomster1(i) == 1
                Q1 = Q1 + 1;
            end
    
            % If arrival, add one to the queue in S2
            if ankomster2(i) == 1
                Q2 = Q2 + 1;
            end
    
            % Arrivals at R coming from S1, and at D coming from S1
            if (Q1 > 0)
                ankomster10(i) = rand(1,1) <= msg10;
                ankomster1D(i) = rand(1,1) <= msg1D; 
            end
    
            % Decreases Q1 by one if attempted transmission to R or D
            if (ankomster10(i) == 1 || ankomster1D(i) == 1)
                Q1 = Q1 - 1;
            end
    
            % Arrivals at R coming from S2, and at D coming from S2
            if (Q2 > 0)
                ankomster20(i) = rand(1,1) <= msg20; 
                ankomster2D(i) = rand(1,1) <= msg2D; 
            end
    
            % Decreases Q1 by one if attempted transmission to R or D
            if (ankomster20(i) == 1 || ankomster2D(i) == 1)
                Q2 = Q2 - 1;
            end
    
            % Arrivals at R as a linear combination of arrivals from S1 and S2
            ankomster0(i) = ankomster10(i) + ankomster20(i);
    
            % If S1 and S2 send in same time slot, collision occurs and packet goes
            % back for retransmission
            if (ankomster10(i) == 1 && ankomster20(i) == 1)
                ankomster0(i) = 0;
                Q1 = Q1 + 1;
                Q2 = Q2 + 1;
                RelayFails = RelayFails + 1;
            end
    
            % Adds an arrival at each successful transmission to relay
            if (ankomster0(i) == 1)
                Q0 = Q0 + 1; 
                RelayArrivals(j,k) = RelayArrivals(j,k) + 1;
            end
        
            % Arrivals at D coming from R
            if (Q0 > 0)
                ankomster0D(i) = rand(1,1) <= msg0; 
            end
    
            if (ankomster0D(i) == 1)
                Q0 = Q0 - 1;
            end
    
            % Arrivals at D depending on transmissions from S1, S2 and R
            ankomsterD(i) = ankomster1D(i) + ankomster2D(i) + ankomster0D(i);
    
            % If S1 and S2 send to D in the same time slot, collision occurs and packets go
            % back for retransmission. 
            % If S1 or S2 sends to D at the same time as R, collision occurs. 
            % If all three nodes send to D at the samt time, collision occurs.
            if (ankomster1D(i) == 1 && ankomster2D(i) == 1 && ankomster0D(i) == 0)
                ankomsterD(i) = 0;
                Q1 = Q1 + 1;
                Q2 = Q2 + 1;
                DestinationFails = DestinationFails + 1;

            elseif (ankomster1D(i) == 1 && ankomster2D(i) == 0 && ankomster0D(i) == 1)
                ankomsterD(i) = 0;
                Q1 = Q1 + 1;
                Q0 = Q0 + 1;
                DestinationFails = DestinationFails + 1;
        
            elseif (ankomster1D(i) == 0 && ankomster2D(i) == 1 && ankomster0D(i) == 1)
                ankomsterD(i) = 0;
                Q2 = Q2 + 1;
                Q0 = Q0 + 1;
                DestinationFails = DestinationFails + 1;
        
            elseif (ankomster1D(i) == 1 && ankomster2D(i) == 1 && ankomster0D(i) == 1)
                ankomsterD(i) = 0;
                Q1 = Q1 + 1;
                Q2 = Q2 + 1;
                Q0 = Q0 + 1;
                DestinationFails = DestinationFails + 1;
            end
    
            % If S1 or S2 sends to R at the same time as R sends to D, R cant overhear and "collision" occurs. 
            if (ankomster0D(i) == 1 && ankomster10(i) == 1)
                ankomster10(i) = 0;
                Q1 = Q1 + 1;
        
            elseif (ankomster0D(i) == 1 && ankomster20(i) == 1)
                ankomster20(i) = 0;
                Q2 = Q2 + 1;
            end
    
            % If S1 sends to D at the same time as it successfully sends to R, R throws away packet. Same for S2.
            if (ankomster1D(i) == 1 && ankomster0(i) == 1)
                if (ankomster10 == 1)
                    Q0 = Q0 - 1;
                end 
    
            elseif (ankomster2D(i) == 1 && ankomster0(i) == 1)
                if (ankomster20 == 1)
                    Q0 = Q0 - 1;
                end
            end
    
    
    
    
            % Adds an arrival to destination for each successful transmission
            if (ankomsterD(i) == 1) 
                D = D + 1;
            end
    
            if (Q0 > 10)
                Q_array(j,k) = Q_array(j,k) + 1;
            end
            
            
        end
        
        arrivalRateRelay(j,k) = RelayArrivals(j,k) / 10000;
        Q_prob(j,k) = Q_array(j,k) / 10000;
        
        
    end
    
end

%plotkod(lambda2, arrivalRateRelay)
plotkod(lambda2, Q_prob)




%% Second case
% Probability of transmission attempt from S1,S2 and R if queues > 0
q1 = 0.3;
q2 = 0.3;
q0 = 0.45;

% Transmission success probabilities
p10 = 0.9;
p13 = 0.4;
p20 = 0.9;
p23 = 0.4;
p03 = 0.95;

lambda1 = linspace(0,1,11);  % Gör så vi kan plotta grejer mot olika lambdavärden
lambda2 = linspace(0,1,11); 

ankomster0 = zeros(10000,1);
ankomster10 = zeros(10000,1);
ankomster20 = zeros(10000,1);
ankomster0D = zeros(10000,1);
ankomster1D = zeros(10000,1);
ankomster2D = zeros(10000,1);
ankomsterD = zeros(10000,1);

msg10 = q1 * p10;
msg1D = q1 * p13;
msg20 = q2 * p20;
msg2D = q2 * p23;
msg0 = q0 * p03;

timeslots = zeros(10000,1);


RelayArrivals = zeros(11,11);
arrivalRateRelay = zeros(11,11);
Q_array = zeros(11,11);
Q_prob = zeros(11,11);




for j = 1:length(lambda1)
    ankomster1 = rand(10000,1) <= lambda1(j); % Arrivals to S1
    
    for k = 1:length(lambda2)
    ankomster2 = rand(10000,1) <= lambda2(k); % Arrivals to S2
    
    Q1 = 0;
    Q2 = 0;
    Q0 = 0;
    D = 0;
    RelayFails = 0;
    DestinationFails = 0;
        
        for i = 1:length(timeslots)
    
    
            % If arrival, add one to the queue in S1
            if ankomster1(i) == 1
                Q1 = Q1 + 1;
            end
    
            % If arrival, add one to the queue in S2
            if ankomster2(i) == 1
                Q2 = Q2 + 1;
            end
    
            % Arrivals at R coming from S1, and at D coming from S1
            if (Q1 > 0)
                ankomster10(i) = rand(1,1) <= msg10;
                ankomster1D(i) = rand(1,1) <= msg1D; 
            end
    
            % Decreases Q1 by one if attempted transmission to R or D
            if (ankomster10(i) == 1 || ankomster1D(i) == 1)
                Q1 = Q1 - 1;
            end
    
            % Arrivals at R coming from S2, and at D coming from S2
            if (Q2 > 0)
                ankomster20(i) = rand(1,1) <= msg20; 
                ankomster2D(i) = rand(1,1) <= msg2D; 
            end
    
            % Decreases Q1 by one if attempted transmission to R or D
            if (ankomster20(i) == 1 || ankomster2D(i) == 1)
                Q2 = Q2 - 1;
            end
    
            % Arrivals at R as a linear combination of arrivals from S1 and S2
            ankomster0(i) = ankomster10(i) + ankomster20(i);
    
            % If S1 and S2 send in same time slot, collision occurs and packet goes
            % back for retransmission
            if (ankomster10(i) == 1 && ankomster20(i) == 1)
                ankomster0(i) = 0;
                Q1 = Q1 + 1;
                Q2 = Q2 + 1;
                RelayFails = RelayFails + 1;
            end
    
            % Adds an arrival at each successful transmission to relay
            if (ankomster0(i) == 1)
                Q0 = Q0 + 1; 
                RelayArrivals(j,k) = RelayArrivals(j,k) + 1;
            end
        
            % Arrivals at D coming from R
            if (Q0 > 0)
                ankomster0D(i) = rand(1,1) <= msg0; 
            end
    
            if (ankomster0D(i) == 1)
                Q0 = Q0 - 1;
            end
    
            % Arrivals at D depending on transmissions from S1, S2 and R
            ankomsterD(i) = ankomster1D(i) + ankomster2D(i) + ankomster0D(i);
    
            % If S1 and S2 send to D in the same time slot, collision occurs and packets go
            % back for retransmission. 
            % If S1 or S2 sends to D at the same time as R, collision occurs. 
            % If all three nodes send to D at the samt time, collision occurs.
            if (ankomster1D(i) == 1 && ankomster2D(i) == 1 && ankomster0D(i) == 0)
                ankomsterD(i) = 0;
                Q1 = Q1 + 1;
                Q2 = Q2 + 1;
                DestinationFails = DestinationFails + 1;

            elseif (ankomster1D(i) == 1 && ankomster2D(i) == 0 && ankomster0D(i) == 1)
                ankomsterD(i) = 0;
                Q1 = Q1 + 1;
                Q0 = Q0 + 1;
                DestinationFails = DestinationFails + 1;
        
            elseif (ankomster1D(i) == 0 && ankomster2D(i) == 1 && ankomster0D(i) == 1)
                ankomsterD(i) = 0;
                Q2 = Q2 + 1;
                Q0 = Q0 + 1;
                DestinationFails = DestinationFails + 1;
        
            elseif (ankomster1D(i) == 1 && ankomster2D(i) == 1 && ankomster0D(i) == 1)
                ankomsterD(i) = 0;
                Q1 = Q1 + 1;
                Q2 = Q2 + 1;
                Q0 = Q0 + 1;
                DestinationFails = DestinationFails + 1;
            end
    
            % If S1 or S2 sends to R at the same time as R sends to D, R cant overhear and "collision" occurs. 
            if (ankomster0D(i) == 1 && ankomster10(i) == 1)
                ankomster10(i) = 0;
                Q1 = Q1 + 1;
        
            elseif (ankomster0D(i) == 1 && ankomster20(i) == 1)
                ankomster20(i) = 0;
                Q2 = Q2 + 1;
            end
    
            % If S1 sends to D at the same time as it successfully sends to R, R throws away packet. Same for S2.
            if (ankomster1D(i) == 1 && ankomster0(i) == 1)
                if (ankomster10 == 1)
                    Q0 = Q0 - 1;
                end 
    
            elseif (ankomster2D(i) == 1 && ankomster0(i) == 1)
                if (ankomster20 == 1)
                    Q0 = Q0 - 1;
                end
            end
    
    
    
    
            % Adds an arrival to destination for each successful transmission
            if (ankomsterD(i) == 1) 
                D = D + 1;
            end
    
            if (Q0 > 10)
                Q_array(j,k) = Q_array(j,k) + 1;
            end
            
            
        end
        
        arrivalRateRelay(j,k) = RelayArrivals(j,k) / 10000;
        Q_prob(j,k) = Q_array(j,k) / 10000;
        
        
    end
    
end

%plotkod(lambda2, arrivalRateRelay)
plotkod(lambda2, Q_prob)




