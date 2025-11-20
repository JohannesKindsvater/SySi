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
#figure(
  image("../images/2-Tank-System-beschriftet.png", width: 100%),
  caption: [Zwei-Tank-System],
)

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

    table.cell([$Q_12$]),
    table.cell([$dot(V)$]),
    table.cell([$x_3$]),

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
    (d V_T_1)/(d t) = d(A_1 dot x_1)/(d t) = A_1 dot d(x)/(d t) = A_1 dot dot(x_1) \
    (d V_T_2)/(d t) = d(A_2 dot x_2)/(d t) = A_2 dot d(x)/(d t) = A_2 dot dot(x_2)
  $,
)

#space

Gleichzeitig ist die Volumenbilanz, der Volumenstrom der durch $Q_E$ reinfließt, subtrahiert mit dem Volumenstrom der durch $Q_12$ abfließt:

#space

#math.equation(
  block: true,
  numbering: "(1)",
  $
    (d V_T_1)/(d t) = Q_E - Q_12 \
    (d V_T_2)/(d t) = Q_12 - Q_A
  $,
)

\
\
#space
Daraus folgt:

#math.equation(
  block: true,
  numbering: "(1)",
  $
    A_1 dot dot(x_1) = Q_E - Q_12\
    A_2 dot dot(x_2) = Q_12 - Q_A
  $,
)

#space

Für die Modellierung der Abflüsse wird das Gesetz von Torricelli herangezogen. Dieses beschreibt den Ausfluss einer Flüssigkeit aus einem offenen Behälter unter dem Einfluss der Schwerkraft. Da Tank 1 über ein Rohr am Boden verfügt, durch welches das Wasser frei in Tank 2 fällt, und Tank 2 ebenfalls einen freien Ausfluss besitzt, hängen die Volumenströme nichtlinear von der jeweiligen Füllstandshöhe $x$ ab.

#space

Die allgemeinen Abflüsse $Q_12$ und $Q_A$ lassen sich somit ersetzen durch:

#space

#math.equation(
  block: true,
  numbering: "(1)",
  $
    Q_12 = k dot sqrt(x_1)\
    Q_A = k dot sqrt(x_2)
  $,
)

#space
Der Parameter $k$ ist dabei die Ventilkonstante. Er fasst die Geometrie des Ausflussrohrs, die Erdbeschleunigung $g$ sowie den hydraulischen Widerstand zusammen. Setzt man diese Beziehungen in die Volumenbilanzgleichungen ein, erhält man das physikalische Modell in Form eines nichtlinearen Differentialgleichungssystems:

#space

#math.equation(
  block: true,
  numbering: "(1)",
  $
    dot(x_1) = 1/A_1 (Q_A - k_1 dot sqrt(x_1))\
    dot(x_2) = 1/A_2(k_1 dot sqrt(x_1) - k_2 dot sqrt(x_2))
  $,
)

#space

Da dieses System aufgrund der Wurzelfunktion nichtlinear ist, ist für die weitere systemtheoretische Betrachtung eine Linearisierung um den Arbeitspunkt erforderlich.
\
\
Von nun an wird mit dem $P T_3 overline(T_2)^'$ System fortgefahren.

\
\

-> Linearisieren mit Ruhelagen (um Arbeitspunkt)
