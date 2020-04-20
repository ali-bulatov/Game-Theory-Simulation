% Final Project: Game Theory Simulation
% By Ali Bulatov and Mohammed Patla
% Written for INFO48874
% April 17th 2020

clear;
clc;
main();

function main()
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
    l=3;
    GRID=int8(rand(l,l));
    % Score matrix with scores of each player
    SCORE=(zeros(l));

    for i=1:1
        % 1. each agent accumulates the payoff obtained by playing
        %  the game with all its neighbours and itself
        for idx = 1:numel(GRID)
            X = GRID(idx);
            score = playGame(X, X);
            
            for n = 1:numel(idx)
                score = score + playGame(X, n);
            end
            SCORE(idx) = score;
        end
        
        image(GRID,'CDataMapping','scaled');
        colorbar
        
        pause(0.5);
        if ~ishghandle(h_fig)   % Quit if user closes the figure window
            break;
        end
    end

    function [m] = playGame(x,y)
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
                m = "Error";
                disp("Strategy should be either 0 or 1.");
        end
    end
end