%% First case
s1 = 0;
s2 = 0;
R = 0;
D = 0;
p10 = 0.9;
p13 = 0.25;
p20 = 0.9;
p23 = 0.25;
p03 = 0.9;
q1 = 0.3;
q2 = 0.3;
q0 = 0.45;
lambda1 = linspace(0,1,11); % Gör så vi kan plotta grejer mot olika lambdavärden
lambda2 = linspace(0,1,11); %
lambda0 = lambda1 * p10 + lambda2' * p20; % Här ska vi ha en linj.kombination av 
                                          % lambda1 och lambda2. (MEN vafan
                                          % det här är ju bara då vi har 0
                                          % kö) kuk ollon
numberOfSlots = 10000;
timeslots = zeros(1,10000);



for i = 1:numberOfSlots 
    %gör nåt som fyller på timeslotsen när dom blir upptagna
    %if timeslot "i" är fylld kan vi inte transmitta nåt (sätt nån spärr genom if-sats)
    
    
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




