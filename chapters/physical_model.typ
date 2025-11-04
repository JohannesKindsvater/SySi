#import "../config.typ": *

= Physikalisches Modell und Systemtheoretische Beschreibung
#inline-note(
  rect: caution-rect,
  fill: orange,
)[Physikalische Betrachtung des Modells im Umfang von circa ein bis zwei Seiten, d.h. Skizze und kurze Beschreibung der physikalischen Gesetze. Meist lässt sich ein guter Stromkreis finden.]

#[
  #set heading(numbering: none, outlined: false)
  === Übertragung in die Systemtheorie
]

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Übertragen der physikalischen Betrachtung in die Systemtheorie. Am Ende sollte die Übertragungsfunktion $G(s)$ bekannt sein.]
\
Im nächsten Schritt müssen die Eingangs- ($u_1$, $u_2$, $u_3$, ...), Ausgangs- ($y_1$, $y_2$, $y_3$, ...), Zustands- ($z_1$, $z_2$, $z_3$, ...) und Störgrößen des Systems festgelegt werden.

#space

#[
  #set align(center)
  #table(
    stroke: (_, y) => if y == 0 { (bottom: 0.5pt) },
    table.vline(x: 1, stroke: (dash: "solid", thickness: 0.5pt)),
    table.vline(x: 2, stroke: (dash: "solid", thickness: 0.5pt)),
    columns: (auto, auto, auto),
    table.header([Physikalische Größe], [Physikalische Einheit], [Systemtheorie]),
  )]

#space

#math.equation(
  block: true,
  numbering: none,
  $ G(s) = dots $,
)
