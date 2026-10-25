# System Design Prep

Daily 45-minute system design mock interviews, run with Claude as the interviewer, plus estimation drills. Every mock is timed, scored, and followed by a model solution with diagrams.

## How a session works

1. A problem arrives each morning (warm-up → core interview level → senior-style).
2. 45 minutes on the clock: requirements → estimations → API & data model → high-level design → deep dives → wrap-up.
3. The design is drawn in Excalidraw and reviewed from screenshots.
4. A full model solution with diagrams.
5. Weak spots from each mock feed into the next one.

## Repo layout

| Path | What's in it |
|---|---|
| `mocks/day-NN-<topic>/README.md` | The problem and the model solution, plus the points a strong answer covers |
| `mocks/day-NN-<topic>/*.mermaid` | Reference architecture and key-flow diagrams |
| `mocks/day-NN-<topic>/my-diagram.png` | My Excalidraw diagram from the session (when exported) |
| `excalidraw/` | Raw `.excalidraw` source files |
| `cheat-sheet/estimation.md` | Back-of-the-envelope formulas and numbers |

## Progress

| Day | Problem | Phase |
|---|---|---|
| 1 | [URL shortener](mocks/day-01-url-shortener/) | Warm-up |
