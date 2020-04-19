% Final Project: Game Theory Simulation
% By Ali Bulatov and Mohammed Patla
% Written for INFO48874
% April 17th 2020

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