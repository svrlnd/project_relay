%% First case
Q1 = 0;
Q2 = 0;
Q0 = 0;
D = 0;

p10 = 0.9;
p13 = 0.25;
p20 = 0.9;
p23 = 0.25;
p03 = 0.9;

% Sannolikhet att vi skickar när vi har köer:
q1 = 0.3;
q2 = 0.3;
q0 = 0.45;

lambda1 = 0.1; %lambda1 = linspace(0,1,11); Gör så vi kan plotta grejer mot olika lambdavärden
lambda2 = 0.1; %lambda2 = linspace(0,1,11); Vet ej om det ska va så 
lambda0 = 0;
ankomster1 = rand(10000,1) <= lambda1;
ankomster2 = rand(10000,1) <= lambda2;
                                                                                
timeslots = zeros(1,10000);


%gör nåt som fyller på timeslotsen när dom blir upptagna
%if timeslot "i" är fylld kan vi inte transmitta nåt (sätt nån spärr genom if-sats)
for i = 1:length(timeslots)
    
    
    
    if ankomster1(i) == 1
        Q1 = Q1 + 1;
    end
    
    if ankomster2(i) == 1
        Q2 = Q2+1;
    end
    
    % Här hanterar vi ankomster till R baserat på om det är grejer som ska
    % skickas eller inte
    if (Q1 == 0 && Q2 == 0)
        lambda0 = 0;
    elseif (Q1 > 0 && Q2 > 0)
        lambda0 = q1 * p10 + q2 * p20;
    elseif (Q1 == 0 && Q2 > 0)
        lambda0 = q2 * p20; 
    elseif (Q1 > 0 && Q2 == 0)
        lambda0 = q1 * p10;
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




