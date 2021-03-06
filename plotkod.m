function plotkod(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 13-May-2018 16:29:59

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Marker','*','LineStyle','none','Parent',axes1);
set(plot1(1),'DisplayName','lamba2 = 0');
set(plot1(2),'DisplayName','0,1');
set(plot1(3),'DisplayName','0,2');
set(plot1(4),'DisplayName','0,3');
set(plot1(5),'DisplayName','0,4');
set(plot1(6),'DisplayName','0,5');
set(plot1(7),'DisplayName','0,6');
set(plot1(8),'DisplayName','0,7');
set(plot1(9),'DisplayName','0,8');
set(plot1(10),'DisplayName','0,9');
set(plot1(11),'DisplayName','1');

% Create ylabel
ylabel({'Arrival rate at relay'},'FontSize',14);

% Create xlabel
xlabel({'lambda1'},'FontSize',14);

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'OuterPosition',[0 0 1 1]);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.827605930730638 0.145750928980215 0.0583670715249662 0.247148288973384]);

