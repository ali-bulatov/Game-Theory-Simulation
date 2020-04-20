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
            N = getNeighbors(idx);
            disp(getNeighbors(5));
           % for n = 1:numel(N)
           %     score = score + playGame(X, N);
           % end
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

    function [n] = getNeighbors(index)
        sz = [l l];
        [x,y] = ind2sub(sz,index);  
        n = [];
        disp (index + " index is " + x + " " + y );
        if x-1 >= 1 && y+1 <= l
            n = [n, GRID(x-1,y+1)]; % bottom left
        end
        if y + 1 <= l
            n = [n, GRID(x,y+1)]; % bottom
        end
        if x + 1 <= l && y + 1 <= l
            n = [n, GRID(x+1,y+1)]; % bottom right
        end
        if x - 1 >= 1
            n = [n, GRID(x-1,y)];  % left
        end
        if x + 1 <= l
            n = [n, GRID(x+1,y)]; % right
        end
        if x - 1 >= 1 && y - 1 >= 1
            n = [n, GRID(x-1,y-1)]; % top left
        end
        if y - 1 >= 1
            n = [n, GRID(x,y-1)];  % top
        end
        if x + 1 <= l && y - 1 >= 1
            n = [n, GRID(x+1,y-1)]; % top right
        end
    end
end








