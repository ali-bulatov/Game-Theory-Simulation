% Final Project: Game Theory Simulation
% By Ali Bulatov and Mohammed Patla
% Written for INFO48874
% April 17th 2020

clear;
 % Seed, change this (or remove) for different initial conditions
rng(2);  
h_fig = figure;
% PAYOFF MATRIX
% Reward for cheating
TEMPTATION = 1;
% Sucker's payoff - when you cooperate and other one cheats
S_PAYOFF = 0;
% Reward for both cooperating
REWARD = 1;
% Both players cheat
PUNISHMENT = 0;

% Automaton grid automaton_dimensions X automaton_dimensions
% Cooperator = 0, Defector = 1
automaton_dimensions=50;
GRID=int8(rand(automaton_dimensions,automaton_dimensions));
% Cells up and down 
up=[2:automaton_dimensions 1];
down=[automaton_dimensions 1:automaton_dimensions-1];

for i=1:100000
    neighbours=GRID(up,:)+GRID(down,:)+GRID(:,up)+GRID(:,down)+...
        GRID(up,up)+GRID(up,down)+GRID(down,up)+GRID(down,down);
    
    pause(0.5);
    if ~ishghandle(h_fig)   % Quit if user closes the figure window
        break;
    end
end

function [m] = PlayGame(x,y)
    rewardType = x * 2 + y;
    switch rewardType
        case 0 
            m = REWARD;  % CC: Reward for mutual cooperation
        case 1
            m = S_PAYOFF;  % CD: Sucker's payoff 
        case 2
            m = TEMPTATION;  % DC: Temptation to defect
        case 3
            m = PUNISHMENT;  % DD: Punishment for mutual defection
        otherwise
            disp("Strategy should be either 0 or 1.");
    end
end