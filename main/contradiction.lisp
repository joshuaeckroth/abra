(in-package :abra)

;;; Code for handling contradictions 

#|
1. Convert the beliefs/justifications into nodes/edges in a graph.
2. BFT starting with the contradictory beliefs as seeds.
3. Nodes at each level are sorted by age. (heuristic)
4. Turn undirected edges into directed edges based on visitation order,
   always pointing from the source to the target.
5. Stop traversing when (a) no more edges (b) all edges are labeled.
6. Edges with a direction cannot be made bidirectional.

This should give us a directed tree with roots at the contradictory beliefs.
We can then start at one of the roots and collect beliefs, and the justifications
that act as edges, and store those as the explanation for one side of the argument.
Additionally, I think that all observations should appear in each argument regardless
of connectivity.

We might suppress justifications so that they can only appear on one side of 
the argument (at least we would rank them lower). This would help prevent the
regeneration of the contradiction.
|#

(defun resolve-contradiction (side1 side2 world wm)
  (let ((bgrph (build-belief-graph world wm)))
  ))

(defun build-belief-graph (world wm)
)