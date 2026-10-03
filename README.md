# PowerfulPanther — Game Proposal

## Overview

PowerfulPanther is a 2D pixel-art platformer where a small cat named ***Mao*** runs, jumps, and transforms into a panther to find their way home. The core idea is simple: the path forward depends on ***Mao***'s form. Some routes need the strength of a panther(bigger version), others are only open to a small kitten.

- **Genre:** 2D side-scrolling puzzle platformer
- **Engine:** GameMaker (GML)
- **Perspective:** Side view, tile-based levels (32 × 32 px tiles)
- **Player:** Single player

## Theme: Losing Power

In PowerfulPanther, losing power is not a punishment: it is the way forward. The game's message is *sometimes losing power is the only way home*.

- **Level design:** Many paths are only open to the kitten. Players must give up their power on purpose to move on.
- **Story:** The journey ends at a tiny cat flap in Mao's front door. To get home, Mao must let go of the panther's power.

## Story & Main Character

Mao is a small orange-and-white pixel cat who has lost their way home. Players can rename Mao at the start of the game.

On the journey, Mao discovers a hidden power: they can transform into a mighty panther. As a panther, Mao uses that strength to break through obstacles the kitten never could.

Each level is one stretch of the road home, and its look matches that part of the journey. The road ends at Mao's front door.

## Player Flow

Players go from the title screen to naming their cat, then play through the levels in order until the ending.

[embedded content: player flow · 5 screens, 1 level loop]

- **Title screen:** Start the game.
- **Name your cat:** The player types a name for their cat. If they skip it, the cat is called Mao. The game uses this name from then on.
- **Play a level:** Clearing a level leads to the next one. A stuck player can restart the current level at any time.
- **Ending screen:** Mao squeezes through the cat flap and arrives home.

## Core Mechanics

The game is built on two mechanics: **movement** and **transforming**. Movement gets Mao around the level; transforming between kitten and panther decides which pathways Mao can use.

### Movement

- **Run left and right** across platforms.
- **Jump** onto ledges and over gaps. Holding the jump button gives a higher jump; tapping it gives a short hop.
- **Forgiving controls:** Mao can still jump for a brief moment after stepping off a ledge, so near-misses feel fair.

### Kitten and Panther

Mao can switch between two forms: **Kitten** (small) and **Panther** (big). Each form opens different pathways.

|                     | Kitten Mao                                   | Panther Mao                                                   |
| ------------------- | -------------------------------------------- | ------------------------------------------------------------- |
| Body size           | Fits through gaps one tile high              | Twice as tall and wide\*\*\*(TBC)\*\*\*                       |
| Pathways it can use | Narrow tunnels, low passages, small openings | Routes that need weight or reach                              |
| What it can do      | Squeeze through tight spaces                 | Break cracked blocks, hold down switches, reach higher ledges |
| What it cannot do   | Too light to press switches or break blocks  | Too large to enter narrow pathways                            |

**Space rule:** Mao can only become a panther if there is room. Inside a narrow tunnel, Mao stays a kitten until they reach an open area. This means players must plan **where** to transform, not just **when**.

### Hairballs

Hairballs are the main obstacle. They drop at random during each level, so no two runs play out exactly the same.

- **Random drops:** Hairballs fall at random times and places in the level.
- **Sometimes blocking:** Where a hairball lands decides whether it blocks Mao's path. Some land out of the way; others close off the route ahead.

## Controls

The game uses a keyboard with four actions; the size switch key is a proposal.

| Action                       | Keys                               |
| ---------------------------- | ---------------------------------- |
| Move left                    | A / Left arrow                     |
| Move right                   | D / Right arrow                    |
| Jump                         | Space / W (hold for a higher jump) |
| Transform (kitten / panther) | Shift (proposed)                   |

## Goal & Ending

The first version targets 3–5 short levels. Each level ends at an exit, and the whole game ends when Mao gets home. This ending is the game's statement on the theme. All game long, the player relies on power, and in the end letting it go is the only way home.

## Art & Audio

The game has a cute, readable pixel-art style with an original soundtrack built around Mao.

- **Art:** Pixel sprites and a tile-based world on a 32 × 32 px grid. Kitten and Panther Mao have clearly different looks, so the player always knows which form is active.
- **Readability:** Pathway elements (tunnels, cracked blocks, switches) each get a distinct look, so players can tell at a glance which form a path needs.
- **Music:** TBC
