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
[Bild]

Die oben aufgeführte Skizzierung stellt ein $P T_2$ System dar, welches auf zwei $P T_1$ Gliedern, repräsentiert durch die beiden Tänke, dargestellt wird.

Im nächsten Schritt müssen die Eingangs- ($u_1$, $u_2$, $u_3$, ...), Ausgangs- ($y_1$, $y_2$, $y_3$, ...), Zustands- ($x_1$, $x_2$, $x_3$, ...) und Störgrößen des Systems festgelegt werden.

#space

#[
  #set align(center)
  #table(
    stroke: (_, y) => if y == 0 { (bottom: 0.5pt) },
    table.vline(x: 1, stroke: (dash: "solid", thickness: 0.5pt)),
    table.vline(x: 2, stroke: (dash: "solid", thickness: 0.5pt)),
    columns: (auto, auto, auto),
    table.header([Physikalische Größe], [Physikalische Einheit], [Systemtheorie]),
    table.cell([$Q_E$]),
    table.cell([$dot(V)$]),
    table.cell([$u$]),

    table.cell([$h_1$]),
    table.cell([$m$]),
    table.cell([$x_1$]),

    table.cell([$h_2$]),
    table.cell([$m$]),
    table.cell([$x_2$]),

    table.cell([$Q_AA$]),
    table.cell([$dot(V)$]),
    table.cell([$z$]),

    table.cell([$h_2$]),
    table.cell([$m$]),
    table.cell([$y$]),
  )]

#space

Um die Übertragsfunktion aufstellen zu können, wird vorerst das Volumen eines jeden Tanks spezifiziert:
#space

#math.equation(
  block: true,
  numbering: "(1)",
  $
    V_T_1 = A_1 dot x_1 \
    V_T_2 = A_2 dot x_2
  $,
)
#space

Aus der zeitlichen Ableitung des Volumens folgt:
#space

#math.equation(
  block: true,
  numbering: "(1)",
  $
    (d V_1)/(d t) = d(A_1 dot x_1)/(d t) = A_1 dot d(x)/(d t) = A_1 dot dot(x_1) \
    (d V_2)/(d t) = d(A_2 dot x_2)/(d t) = A_2 dot d(x)/(d t) = A_2 dot dot(x_2)
  $,
)

#space

Gleichzeitig ist die Volumenbilanz, der Volumenstrom der durch $Q_E$ reinfließt, subtrahiert mit dem Volumenstrom der durch $Q_12$ abfließt:

#space

#math.equation(
  block: true,
  numbering: "(1)",
  $
    (d V_1)/(d t) = Q_E - Q_12 \
    (d V_1)/(d t) = Q_12 - Q_A
  $,
)

#space

#math.equation(
  block: true,
  numbering: "(1)",

  $
    (d V_1)/(d t) = Q_E - Q_12 \
    (d V_1)/(d t) = Q_12 - Q_A
  $,
)

