# Game-Theory-Simulation
 This is a project that simulates and visualises the prisoner's dillema.
 It implements the spatial prisoner's dilemma game proposed by Nowak & May (1992) [1].
### Details
In this model, agents are placed in a grid, where in each round:
<ul>
 <li>every individual accumulates the payoff obtained by playing the prisoner's dilemma game with all its immediate neighbours and itself (only for the current round);</li>
 <li>after this, each agent copies the strategy of the best performing agent in its neighbourhood (including itself).</li>
</ul>
This simple, and purely deterministic, spatial version of the prisoner's dilemma game, with no memories among players and no strategical elaboration, can generate chaotically changing spatial patterns, including kaleidoscopes, dynamic fractals, gliders, and so on.

#### Example Outputs

![](/img/state_1.png)
![](/img/state_2.png)

#### References
---
[1] Nowak, M. A., & May, R. M. (1992). Evolutionary games and spatial chaos. Nature, 359(6398), 826. DOI:     http://dx.doi.org/10.1038/359826a0
