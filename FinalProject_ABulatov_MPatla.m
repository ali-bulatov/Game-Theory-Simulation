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
    TEMPTATION = 1.5;
    % Sucker's payoff - when you cooperate and other one cheats
    S_PAYOFF = 0;
    % Reward for both cooperating
    REWARD = 1;
    % Both players cheat
    PUNISHMENT = 0;

    l=50;   % Grid dimensions lxl
    % Randomly distribute amount of cooperators and defectors
    % Cooperator = 0, Defector = 1
    GRID=int8(rand(l,l));   
    
    % Uncomment and comment default grid to set all players to cooperators and put one defector
    % in the middle, with temptation>1.4 draws beatiful fractals
    %GRID = zeros(l);
    %GRID(25,25) = 1;
    
    % Score matrix with scores of each player
    SCORE=(zeros(l));
    % Output image for simulation 
    OUTPUT=zeros(l);
    
    % Main Simulation Loop
    for i=1:10000
        % 1. each agent accumulates the payoff obtained by playing
        %  the game with all its neighbours and itself
        for idx = 1:numel(GRID)
            X = GRID(idx);
            % Play with itself
            score = playGame(X, X);
            N = getNeighbors(idx);
            % Compute scores by playing with each neighbor
            for n = 1:numel(N)
                score = score + playGame(X, N(n));
            end
            SCORE(idx) = score;
        end
        
        % Store best strategies in a matrix
        bestStrategies = zeros(l);
        % 2. the best agent in the neighbourhood is selected to reproduce
        for idx = 1:numel(GRID)
            % Set own strategy as the best to start
            bestStrategy = GRID(idx);
            highestScore = SCORE(idx);
            [N,M] = getNeighbors(idx);
            % Compare the score with neighbors and choose the strategy
            % of the one with the highest score
            for n = 1:numel(M)
                neighbourScore = M(n);
                neighborStrategy = N(n);
                if (neighbourScore > highestScore) 
                    highestScore = neighbourScore;
                    bestStrategy = neighborStrategy;
                end
            end
            bestStrategies(idx) = bestStrategy;  
        end
                
        % 3. prepare the next generation
        for idx = 1:numel(GRID)
            % Set strategies 0 - cooperator, 1 - defector, 
            % 2 - new cooperatot, 3 - new defector
            s = GRID(idx);
            if s == bestStrategies(idx)
                s = s;
            else
                s = bestStrategies(idx) + 2;
            end
            % Binarize the strategy grid
            GRID(idx) = binarize(s);
            % Save output
            OUTPUT(idx) = s;
        end
        
        % Plot the strategies
        image(OUTPUT,'CDataMapping','scaled');
        colorbar
        
        pause(0.01);
        if ~ishghandle(h_fig)   % Quit if user closes the figure window
            break;
        end
    end
    
    % Play 1 round of a game between 2 players
    function [m] = playGame(x,y)
        % Calculate reward: 0|2 -> 0 (cooperator)
        %           1|3 -> 1 (defector)
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

    % Get the players' neighbors
    function [n,m] = getNeighbors(index)
        % Convert from linear indicies to subscripts
        sz = [l l];
        [x,y] = ind2sub(sz,index);  
        % neighboring strategies 
        n = [];
        % neighboring scores
        m = [];
        % Check for out of bound indecies
        if x-1 >= 1 && y+1 <= l
            n = [n, GRID(x-1,y+1)]; % bottom left
            m = [m, SCORE(x-1,y+1)];
        end
        if y + 1 <= l
            n = [n, GRID(x,y+1)]; % bottom
            m = [m, SCORE(x,y+1)]; 
        end
        if x + 1 <= l && y + 1 <= l
            n = [n, GRID(x+1,y+1)]; % bottom right
            m = [m, SCORE(x+1,y+1)];
        end
        if x - 1 >= 1
            n = [n, GRID(x-1,y)];  % left
            m = [m, SCORE(x-1,y)];  
        end
        if x + 1 <= l
            n = [n, GRID(x+1,y)]; % right
            m = [m, SCORE(x+1,y)]; 
        end
        if x - 1 >= 1 && y - 1 >= 1
            n = [n, GRID(x-1,y-1)]; % top left
            m = [m, SCORE(x-1,y-1)]; 
        end
        if y - 1 >= 1
            n = [n, GRID(x,y-1)];  % top
            m = [m, SCORE(x,y-1)];  % top
        end
        if x + 1 <= l && y - 1 >= 1
            n = [n, GRID(x+1,y-1)]; % top right
            m = [m, SCORE(x+1,y-1)]; % top right
        end
    end

    % transform from 0|2 -> 0 (cooperator), 1|3 -> 1 (defector)
    function [a] = binarize(str)
        if str < 2
            a = str;
        else
            a = str - 2;
        end
    end
end