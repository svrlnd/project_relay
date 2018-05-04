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

lambda1 = 0.1; %lambda1 = linspace(0,1,11); Gör så vi kan plotta grejer mot olika lambdavärden
lambda2 = 0.1; %lambda2 = linspace(0,1,11); Vet ej om det ska va så 
lambda0 = 0;
ankomster1 = rand(10000,1) <= lambda1;
ankomster2 = rand(10000,1) <= lambda2;
ankomster0 = zeros(10000,1);
ankomster10 = zeros(10000,1);
ankomster20 = zeros(10000,1);

msg1 = q1 * p10;
msg2 = q2 * p20;

timeslots = zeros(10000,1);

Q1 = 0;
Q2 = 0;
Q0 = 0;
D = 0;
RelayArrivals = 0;
RelayFail = 0;

%gör nåt som fyller på timeslotsen när dom blir upptagna typ
%if timeslot "i" är fylld kan vi inte transmitta nåt (sätt nån spärr genom if-sats)
for i = 1:length(timeslots)
    
    
    % If arrival, add one to the queue in S1
    if ankomster1(i) == 1
        Q1 = Q1 + 1;
    end
    
    % If arrival, add one to the queue in S2
    if ankomster2(i) == 1
        Q2 = Q2 + 1;
    end
    

    % Arrival intensity at R depending on queue situation in S1 and S2
    if (Q1 == 0 && Q2 == 0)
        lambda0 = 0;
    elseif (Q1 > 0 && Q2 > 0)
        lambda0 = msg1 + msg2;
    elseif (Q1 == 0 && Q2 > 0)
        lambda0 = msg2; 
    elseif (Q1 > 0 && Q2 == 0)
        lambda0 = msg1;
    end
    
    % Arrivals at R coming from S1
    ankomster10(i) = rand(1,1) <= msg1;
    
    % Arrivals at R coming from S2
    ankomster20(i) = rand(1,1) <= msg2; 
    
    % Arrivals at R as a linear combination of arrivals from S1 and S2
    ankomster0(i) = ankomster10(i) + ankomster20(i);
    
    % If S1 and S2 send in same time slot, collision occurs
    if (ankomster0(i) == 2)
        ankomster0(i) = 0;
        RelayFail = RelayFail + 1;
    end
    
    % Adds an arrival at each successful transmission to relay
    if (ankomster0(i) == 1)
        RelayArrivals = RelayArrivals + 1;
    end
   
    % Decreases Q1 by one if successful transmission to R
    if (ankomster10 == 1)
        Q1 = Q1 - 1;
    end
    
    % Decreases Q1 by one if successful transmission to R
    if (ankomster20 == 1)
        Q2 = Q2 - 1;
    end
        
            
end


%% Second case
s1;
s2;
R;
D;
p10 = 0.9;
p13 = 0.4;
p20 = 0.9;
p23 = 0.4;
p03 = 0.95;
q1 = 0.3;
q2 = 0.3;
q0 = 0.45;
lambda1 = linspace(0,1,11); %Gör så vi kan plotta grejer mot olika lambdavärden
lambda2 = linspace(0,1,11); %
lambda0;
timeslots = zeros(1,10000);




