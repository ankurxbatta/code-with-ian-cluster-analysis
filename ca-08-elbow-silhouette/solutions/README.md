# CA-8 Solutions — Choosing k: Elbow Method & Silhouette Width

Worked solutions. Try the problems first — the struggle is the lesson.

---

## Problem 1 — Read the elbow

(a) Drops: 210.5 − 118.2 = **92.3**; 118.2 − 84.6 = **33.6**; 84.6 − 61.3 = **23.3**; 61.3 − 55.8 = **5.5**; 55.8 − 51.2 = **4.6**. The drops collapse after k = 4 (23.3 → 5.5): the elbow suggests **k = 4**.

(b) Total WSS always falls as k grows — every extra center can only move points closer to a center. If "smallest WSS wins" were the rule, k = n (every point its own cluster, WSS = 0) would always win, which is useless. The elbow is not about the smallest value; it is about where extra clusters stop earning their keep.

---

## Problem 2 — Silhouette by hand

(a) s(Q): a = average distance from Q to its own cluster {P, Q} = QP = |4 − 2| = **2**. Rival cluster {R, S}: QR = |4 − 9| = 5, QS = |4 − 11| = 7, so b = (5 + 7)/2 = **6**. s(Q) = (6 − 2)/max(2, 6) = 4/6 = **0.667**.

(b) s(P): a = PQ = 2; b = (PR + PS)/2 = (7 + 9)/2 = 8; s(P) = (8 − 2)/8 = **0.75**.
s(R): a = RS = 2; b = (RP + RQ)/2 = (7 + 5)/2 = 6; s(R) = (6 − 2)/6 = **0.667**.
s(S): a = SR = 2; b = (SP + SQ)/2 = (9 + 7)/2 = 8; s(S) = (8 − 2)/8 = **0.75**.

(c) Average = (0.75 + 0.667 + 0.667 + 0.75)/4 = 2.834/4 = **0.709**. Every width is solidly positive and the average sits well above 0.5: the two clusters are compact (small a) and well separated (large b) — a well-clustered dataset.

---

## Problem 3 — b is a MINIMUM

(a) b1 = 3 (X to M, single point). b2 = (8 + 10)/2 = **9**. b = min(3, 9) = **3** — the closest rival cluster sets b.
(b) s(X) = (3 − 1)/max(1, 3) = 2/3 = **0.667**.
(c) The classmate's 7 mixes a near rival (M, distance 3) with a far one ({N, O}, average 9) into one mushy number. The notes insist b is the MINIMUM over rival clusters, because the silhouette asks "how close is the nearest threat?" — averaging all rivals together hides the close one and inflates the score (0.857 vs the correct 0.667).

---

## Problem 4 — Elbow + silhouette in R (iris)

Expected output (seed 123; your k-means WSS may wobble slightly run to run):

- WSS: 596.0, 220.9, 138.9, 113.3, 90.2, 79.5, 70.2, 62.4, 54.9, 48.1
- Drops: 375.1, 82.0, 25.6, 23.1, 10.7, 9.3, 7.8, 7.4, 6.8

(a) The drops fall off a cliff early (375.1 → 82.0) then ease down (25.6, 23.1, 10.7, …). A reasonable read: the bend sits around k = 3 — but notice how smooth the curve is after k = 2. Any answer in {2, 3, 4} with a drops-based justification is defensible.
(b) Neither of you is "right" — that is the point. The typed notes name the iris curve as the example of NO clear elbow and warn: do not force one. Two honest readers can pick different k from the same smooth bend, which is exactly why the silhouette's numerical rule exists.
(c) Average silhouette widths peak at **k = 2** (0.5818), then 0.4566, 0.4091, … The starred rule picks the highest point: **k = 2**.
(d) They disagree because they score different things. The elbow watches tightness only (WSS always improves with more clusters, so it stops where tightness stops improving fast). The silhouette demands compact AND separated clusters — splitting iris into more pieces makes each piece tighter but less separated, so the average width drops. Different lenses, different answers; that is why the notes pair each method with its algorithm (elbow ↔ k-means, silhouette ↔ PAM).

---

## Problem 5 — Read three scores

(a) s = 0.85 → **well placed** (close to +1: loyal to its cluster, far from rivals). s = −0.15 → **likely misclassified** (negative: on average closer to a rival cluster than its own). s = 0.02 → **on the border** (near 0: torn between its cluster and a rival).
(b) Negative means a > b: the point's average distance to its OWN cluster exceeds its minimum average distance to a rival cluster. Next: look at which rival cluster set b (the `neighbor` column of `silhouette()`), and consider moving the point there — or questioning whether the clusters are real.
(c) No — an average near 0 means most points sit on borders, i.e. the clusters are neither compact nor separated. Either k is wrong or the data is not clusterable (back to episode 7's question).
