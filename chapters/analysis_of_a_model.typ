#import "../config.typ": *

#set heading(numbering: "1.")
#set math.equation(numbering: "1.")

= Analyse des Modells
#inline-note(
  rect: caution-rect,
  fill: orange,
)[Übertragungsfunktion anpassen]

Im folgenden Abschnitt wird das System eines $P T_3 overline(T_2)^'$-Glieds mit folgender Übertragungsfunktion analysiert:
$
  G(s) = Y(s)/U(s) = (s^2 - 2s + 1)/(s^3 + 3s^2 + 3s + 1)
$ <uebertragungsfunktion>

== Eigenschaften des Systems

Folgend eine Liste der Eigenschaften des Systems, die sich aus der Übertra-
gungsfunktion G(s) ergibt: \

- *Nennergrad - Zählergrad = 1*,
  dadurch ist das System *nicht sprungfähig*, antwortet aber *sofort* mit einer *Steigung*. Außerdem ist die *D-Matrix* (welche einem *Sprung am Anfang* ensprechen würde) gleich *0*.

- Besitzt *zwei Nullstellen*

- Besitzt *dreifache Polstelle*

- *Nichtminimalphasig*

== Eingabe des Systems in Matlab

Bei der Eingabe der Übertragungsfunktion in Computeralgebra wird in Matlab zunächst die symbolische Variable $s$ über den Befehl `syms` eingeführt. Daraufhin kann über den selben Befehl die Übertragungsfunktion $G(s)$ definiert werden. Die Eingabe des konkreten Systems in Matlab erfolgt dann über:
#codefigure(caption: none, reference: none)[```
syms s G(s);
G(s) = (s^2 - 2*s + 1)/(s^3 + 3*s^2 + 3*s + 1);
sys = tf([1 -2 1], [1 3 3 1]);
```]

Wichtig dabei ist, dass bei der Eingabe einer Gleichung in Matlab die Operatoren, wie die Multiplikation, explizit in der Formel ausgeschrieben werden. So muss zum Beispiel für den Term $3·s$ das Multiplikationszeichen explizit aufgeführt werden. Bei einer Eingabe von 3s wird eine Fehlermeldung ausgegeben und die Eingabe des System schlägt fehl.

Zum Aufbau der Analyse des Modells ist anzumerken, dass die Darstellungsformen absteigend anhand ihres Informationsgehalts sortiert sind, sodass die erste Darstellung die informationsreichste ist.

== Explizite Darstellung des Übertragungsoperators
Die explizite Darstellung ist in unserem Beispiel eine Folgerung aus der Zustandsraumdarstellung. Für die Berechnung von $A$, $B$, $C$, $D$ sei auf @zustandsraumdarstellung verwiesen. Zudem ist zu beachten, dass in Matlab die `expm` für die Exponentialfunktion verwendet werden muss, da die Matrixmultiplikation und nicht die Hadamardmultiplikation benötigt wird. Somit ist die Zustandsraumdarstellung mit den dazugehörigen Anfangswerten bekannt, womit die explizite Darstellung nach folgender Formel berechnet werden kann:

$
  x(t) & = e^(A t) dot x(0) + integral_0^t e^A(t-tau)B u(tau) d tau \
  y(t) & = C e^(A t) dot x(0) + C integral_0^t e^A(t-tau)B u(tau) d tau + D u(t)
$

\
\

In unserem Fall ergibt sich:


$//Hier die Matrizen einsetzen und die Formeln vereinfachen
$




$
  A & = mat(
        -3, -1.5, -1;
        2, 0, 0;
        0, 0.5, 0;
      )
$

$
  B & = mat(
        2;
        0;
        0;
      )
$

$ C & = mat(0.5, -0.5, 0.5;) $

$ D & = mat(0) $


== Implizite Darstellung
=== Zustandsraumdarstellung <zustandsraumdarstellung>

Die allgemeine Form des Zustandsraums lautet:

$
  dot(x) & = A x+ B u \
       y & = C x+ D u
$

Matlab kann die Zustandsraumdarstellung durch den Befehl `ss(sys)` berechnen, die Ausgabe von Matlab für das beschriebene System beschreibt folgende
Zustandsraumdarstellung:

#space

$
  dot(x) & = mat(-3, -1.5, -1; 2, 0, 0; 0, 0.5, 0; delim: "[")x + vec(2, 0, 0, delim: "[")u \
       y & = mat(0.5, -0.5, 0.5, delim: "[")x + vec(0, delim: "[")u
$
// $
//   y = mat(0.5, -0.5, 0.5, delim: "[")x + vec(0, delim: "[")u
// $

#space

// Für unser Beispiel gilt mit den *Anfangswerten*:

// $
//   A = mat(0; 0; 0; 0; 0;)
// $



Ein System kann auch mit der dazugehörigen Zustandsraumdarstellung eingegeben werden, indem die Matrizen $A$, $B$, $C$, $D$ belegt werden und der Befehl `sys = ss(A, B, C, D)` verwendet wird. Hieraus ergibt sich mit `tf(sys)` erneut die Übertragungsfunktion, welche auch mit folgender Formel manuell berechnet werden kann, wobei $I$ die Einheitsmatrix darstellt.

$
  G(s) = C(s I-A)^(-1)B+ D
$

Ohne Matlab kann die Zustandsraumdarstellung aus der Übertragungsfunktion in einfachen Fällen mithilfe einer Substitution, d.h. Einführen neuer Zustände, gelöst werden. Für Systeme, in denen auch $dot(u)$, $accent(u, ¨)$,$dots$ vorkommt, ist die Vorgehensweise teilweise komplexer. Im Rahmen dieser Arbeit wird diese Vorgehensweise deshalb nicht weiter erläutert, sondern lediglich auf den entsprechenden #link("https://de.wikipedia.org/wiki/Zustandsraumdarstellung#Regelungsnormalform")[Wikipedia Eintrag] verwiesen, in welchem die Vorgehensweise ausführlich erklärt ist. Bei sprungfähigen Systemen ist zunächst zusätzlich eine Polynomdivision erforderlich. In mehrgrößen Fällen wird die Ermittlung der Zustandsraumdarstellung noch komplexer und aufwändiger.

#[
  #set heading(numbering: none, outlined: false)
  === Anfangswerte
]
#inline-note(
  rect: caution-rect,
  fill: orange,
)[Herrn Gröll fragen, ob dieser Abschnitt drinbleiben soll]

Die Anfangswerte werden für die Simulation benötigt, da der Start der Funktion definiert sein muss. Verwendet werden hierbei immer die linksseitigen Grenzwerte, damit eventuelle Sprünge nicht miteinbezogen werden. Das bedeutet:

$
       y(0^-) & = C x(0^-) + D u(0^-) \
  dot(y)(0^-) & = C A x(0^-) + C B u(0^-) + D dot(u)(0^-)
$

Hierbei können die Summanden, welche $u$, $dot(u)$, $accent(u, ¨)$,$dots$ beinhalten, vernachlässigt werden, da die linksseitigen Anfangswerte der Signale gleich 0 sind. Die Anfangswerte des Zustandsraumes $x$ müssen zusätzlich mit denen der Ein-Ausgangs-Differentialgleichung $y$ korrespondieren. Aus obiger Berechnung ergibt sich somit folgendes:

$
  mat(y; dot(y); accent(y, ¨);) & = mat(c^T; c^T A; c^T A^2;) mat(x_1; x_2; x_3;) \
            mat(x_1; x_2; x_3;) & = mat(c^T; c^T A; c^T A^2;)^(-1) mat(y; dot(y); accent(y, ¨);)
$

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Übertragen auf konkretes Beispiel, Anfangswerte beachten]

=== Integralgleichung
Die Integralgleichung ist allgemeiner als die Differentialgleichung, da diese "mild Solutions" ergibt, welche zusätzlich auch Sprünge abbilden können. Sie ergibt sich aus der Differentialgleichung durch Integration mit $integral_0^t$.

$
  x(t) = x(0) + integral^t_0 A x(tau) + B u(tau) d tau
$

Für unser System gilt:

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Matritzen aus `ss(sys)` einsetzen und ggf. zusammenfassen]

=== Differentialgleichung <dgl>
Die Differentialgleichung ergibt sich meist aus dem physikalischen Modell und ist in unserem Fall mit den *Anfangswerten* wie folgt definiert:

#math.equation(
  $$,
)

#inline-note(
  rect: caution-rect,
  fill: orange,
)[TODO]

== Ein- und Ausgangs-Differentialgleichung
Die Ein-Ausgangs-Differentialgleichung ergibt sich aus der Differentialgleichung (@dgl) durch Eliminieren des Zustandes und ist für unser System mit den Anfangswerten wie folgt definiert:

$
  G(s) = Y(s)/U(s) = (s^2 - 2s + 1)/(s^3 + 3s^2 + 3s + 1)
$

$
  (s^3 + 3s^2 + 3s + 1) Y(s) = (s^2 - 2s + 1) U(s)
$

$
  dot.triple(y) + 3 dot.double(y) + 3 dot(y) + y = dot.double(u) - 2 dot(u) + u
$

#space

Hierbei gilt für die Anfangswerte:

$
  vec(y, dot(y), dot.double(y), delim: "[") = vec(0, 0, 0, delim: "[")
$

#inline-note(
  rect: caution-rect,
  fill: orange,
)[TODO]

== Übertragungsfunktion

Ein System kann auch durch die dazugehörige Übertragungsfunktion beschrieben werden, welche sich aus der Ein- und Ausgangsdifferentialgleichung mithilfe der Laplace Transformation ergibt. Die Übertragungsfunktion wurde durch die physikalische Betrachung hergeleitet und zu Beginn (@uebertragungsfunktion) benannt. Sie lautet:

#inline-note(
  rect: caution-rect,
  fill: orange,
)[TODO]

== Systemantworten
=== Gewichtsfunktion / Impulsantwort $delta(t)$
Die Gewichtsfunktion $g(t)$, auch Impulsantwort genannt, ist die Antwort des Systems auf einen Dirac-Impuls $delta(t)$ am Eingang.

In Matlab kann die Impulsantwort mit `impulse(sys)` geplottet werden. Die analytische Berechnung ist über `g(t) = ilaplace(G(s))` möglich. Die Ausgabe `...` von Matlab bedeutet:

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Hier einmal die Ausgabe von Matlab schön in
  #[
    #set text(font: "libertinus serif")
    typst
  ] formattiert hinschreiben]
#inline-note(
  rect: caution-rect,
  fill: orange,
)[`impulse(sys)` Plot einfügen]
#figure(
  image("../images/ImpulseResponse12.png", width: 80%),
  caption: [Impulsantwort des Systems],
)

=== Übergangsfunktion / Sprungantwort $1(t)$
Die Übergangsfunktion ist die Antwort auf den Einheitssprung $1(t)$ und somit ohne Einheiten. Die Sprungantwort dagegen ist die Antwort auf einen technischen Einheitssprung und somit mit Einheiten.

Die Übergangsfunktion kann in Matlab mit `step(sys)` geplottet werden. Die analytische Berechnung erfolgt mit `h(t) = ilaplace(G(s)/s)`. Die Ausgabe `...` von Matlab bedeutet:

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Hier einmal die Ausgabe von Matlab schön in
  #[
    #set text(font: "libertinus serif")
    typst
  ] formattiert hinschreiben]
#inline-note(
  rect: caution-rect,
  fill: orange,
)[`steps(sys)` Plot einfügen]

#figure(
  image("../images/Sprungantwort.svg", width: 70%),
  caption: [Sprungantwort],
)

== Frequenzgang
Zum Frequenzgang $G(j omega)$ gelangt man, indem man die Variable $s$ durch $j omega$ in der Übertragungsfunktion $G(s)$ ersetzt. Hierbei steht $omega$ für die Kreisfrequenz in $(r a d)/ s$ (Erinnerung: $omega = 2 pi f$) und $j$ für die imaginäre Einheit. Da in der Systemtheorie $i$ für den Strom steht, wird für die imaginäre Einheit nicht $i$, sondern $j$ verwendet, um Verwechslungen zu vermeiden. Das bedeutet, dass für jede Frequenz $omega$, $G(j omega)$ eine komplexe Zahl mit Real- und Imaginärteil oder Betrag mit Phase darstellt.
Systemtheoretisch entspricht der Frequenzgang $G(j omega)$ einem Schritt der komplexen Funktion von $G(s)$ entlang der imaginären Achse: $G(s)|_(s=j omega)$

Mithilfe des Cursors kann in Matlab an der Kurve des Frequenzgangs $G(j omega)$, dargestellt in einem Bode- oder Nyquist-Diagramm, entlang gefahren werden, sodass der Real- und Imaginärteil zu dem jeweiligen Punkt angezeigt wird.

=== Bode-Diagramm
Im Bode-Diagramm ist der Betrag des Frequenzgangs über $omega$ in Dezibel sowie die Phasenverschiebung des Frequenzgangs über $omega$ in Grad dargestellt. Genau genommen sind dies die Amplitudenverstärkung und Phasenverschiebung, die ein Sinus an der jeweiligen Frequenz $omega$ stationär erfährt, d.h. die Eigenvorgänge sind abgeklungen $(t -> infinity)$. Um eine bessere Darstellung der Kurven zu erzeugen, wird beim Bode-Diagramm eine doppelt logarithmische Darstellung verwendet. Die Diagramm-Achse, auf der $omega$ aufgetragen ist, ist dabei logarithmisch skaliert, während der Betrag in Dezibel (dB) angegeben wird. In Matlab kann der Plot mit dem Befehl `bode(sys)` erstellt werden.

#inline-note(
  rect: caution-rect,
  fill: orange,
)[`bode(sys)` Plot einfügen]

#figure(
  image("../images/Bode.svg", width: 70%),
  caption: [Bode-Plot],
)

=== Nyquist-Plot / Ortskurve
Im Nyquist-Plot wird der über $omega$ parametrisierte Frequenzgang $G(j omega)$ als Kurve in der komplexen Ebene mit Real- und Imaginärteil dargesetllt. Die Kurve des Frequenzgangs $G(j omega)$ wird in Matlab für $omega$ von $- infinity$ bis $+ infinity$ angezeigt. Der Nyquist Plot kann mithilfe des `nyquist(sys)` Befehls in Matlab erstellt werden.

#inline-note(
  rect: caution-rect,
  fill: orange,
)[`nyquist(sys)` Plot einfügen]

#figure(
  image("../images/Nyquist.svg", width: 70%),
  caption: [Nyquist-Plot],
)

=== Simulink

#[
  #set heading(numbering: none, outlined: false)
  === Schaltung mit transfer function
]

Die Schaltung kann in Simulink einfach realisiert werden, indem der "Transfer Fcn" Baustein aus der Simulink Continous Toolbox verwendet wird. Durch Doppelklick auf den Baustei lässt sich die korrekte Übertragungsfunktion eingeben. In unserem Beispiel ergibt sich die nachfolgende Schaltung, wobei ein Sinus mit einer Frequenz von 5Hz verwendet wird:

#figure(
  image("../images/Simulink_transfer_function.png", width: 80%),
  caption: [Simulink Schaltung mit tf Baustein],
)

#[
  #set heading(numbering: none, outlined: false)
  === Schaltung mit Integratoren
]

Alternativ zur Eingabe der Übergangsfunktion lässt sich das System auch durch Integratoren aufbauen. Hierfür wird die Eingangs- und Ausgangsdifferentialgleichung nach der höchsten Ableitung umgestellt und integriert. Die Differentialgleichung ergibt sich durch Auflösen nach der höchsten Ableitung und entsprechender Rückkopplung. Der Vorteil ist, dass hierbei Anfangswerte gesetzt werden können. Unsere Simulink Schaltung ist wie folgt aufgebaut:

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Eigene Schaltung einfügen]

#figure(
  image("../images/Simulink_integrator.png", width: 80%),
  caption: [Simulink Schaltung mit Integratoren],
)

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Eigene Ausgabe einsetzen]

#figure(
  image("../images/Simulink_Oszillator_3Hz.png", width: 80%),
  caption: [Oszilloskop für Frequenz von $3 (r a d)/s$],
)

#[
  #set heading(numbering: none, outlined: false)
  === Stationärer Vorgang
]

Der stationäre Vorgang ist diejenige Phasenverschiebung und Amplitudenverstärkung, welcher ein Sinus am Eingang mit einer konstanten Frequenz stationär erfährt. Für den Sinus $u(t) = a dot sin(omega_0 t+ phi_0)$ am Eingang ergibt sich der stationäre Vorgang $y_("stat")$ wie nach folgender Formel mit den Bestandteilen:

$
           y(t) & = "Eigenvorgang" + y_("stat")(t) \
  y_("stat")(t) & = |G(j omega_0)| dot a dot sin(omega_0t+ phi_0 + arg(G(j omega_0))) \
$
\
#[
  #set math.equation(
    numbering: none,
  )
  $
    "Amplitudenverstärkung" & := |G(j omega_0)| \
       "Phasenverschiebung" & := arg(G(j omega_0))
  $
]

Exemplarisch soll hierbei die Phasenverschiebung und Amplitudenverstärkung aus dem Oszilloskop und dem Bode-Plot abgelesen werden, sowie zusätzlich manuell berechnet werden. Für den Vergleich wird eine Frequenz von $omega = dots (r a d)/s$ betrachtet.

#inline-note(
  rect: caution-rect,
  fill: orange,
)[In dem folgenden Abschnitt muss die Phasenverschiebung und Amplitudenverstärkung zuerst analytisch berechnet und anschließend aus dem Bode-Plot und Oszilloskop abgelesen werden. Unten befindet sich eine kurze Zusammenfassung der Vorgehensweise.]

+ Analytische Berechnung
  - $omega j$ in $G(s)$ einsetzen und Betrag und Argument bestimmen.
  - Für die Berechnung des Argumentes in Matlab `atan2` nutzen, um die Quadrantenbeziehungen zu berücksichtigen.
+ Ablesen aus Bode Plot
  - Screenshot, auf dem im oberen und unteren Plot jeweils die Frequenz $omega$ durch Anklicken hervorgehoben ist.
  - Verstärkung [dB] aus Bode-Plot ablesen und mit $20 log(K) =...$ in Frequenz [Hz] umrechnen.
  - Phasenverschiebung [$(r a d)/s$ ] aus Diagramm ablesen und in Grad umrechnen.
+ Ablesen aus Simulink Oszilloskop
  - Screenshot des Oszilloskops, der die Amplitude zeigt.
  - Screenshot des Oszilloskops, der die Phasenverschiebung zeigt.
  - Berechnen der Verstärkung $K$.
  - Berechnen der Phasenverschiebung $phi.alt$ (Vorzeichen beachten, d. h. Verschiebung nach rechts oder links).

== Statische Kennlinie (Statikinformationen)
Der jeweilige Verlauf der statischen Kennlinie ist dabei abhängig vom Verhalten des Systems. Für ein System mit $P$-Verhalten ist die statische Kennlinie eine Ursprungsgerade mit der statischen Verstärkung $K$ als Steigung. Bei Systemen mit $D$-Verhalten entspricht die statische Kennlinie der $x$-Achse. Sowohl bei Systemen mit $I$-Verhalten, als auch bei instabilen Systemen lässt sich rein formal keine statische Kennlinie angeben. Bei instabilen Systemen ist dies darin begründet, dass die Eigenvorgänge nicht abklingen, sondern aufklingen. Im Gegensatz zu einem stabilen System schwingt sich ein instabiles System auch nach einiger Zeit nicht ein, die Lösungen laufen umgangsprachlich gesagt davon. Eine mögliche Darstellung der statischen Kennlinie für Systeme mit $I$-Verhalten ist es, die $y$-Achse als statische Kennlinie zu verwenden.

Um eine statische Kennlinie aufzunehmen, stellt man einen konstanten Wert für die Eingangsvariable $u$ ein. Wenn alle Eigenvorgänge abgeklungen sind, liest man den zugehörigen Ausgangswert, $y$, ab. Dieses Vorgehen wiederholt man für mehrere Punkte, sodass sich eine Abfolge von Messpunkten ergibt, welche anschließend durch eine Linie verbunden werden können. In Matlab kann zur Hilfe der Befehl `dcgain(sys)` verwendet werden, der die statische Verstärkung berechnet.

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Herrn Gröll fragen, ob die nachfolgenden Gleichungen drin bleiben sollen]

Im Fall mehrerer Ausgänge lässt sich die Verstärkungsmatrix $K$ berechnen, indem die Zustandsraumdarstellung verwendet wird und $dot(x)= 0$ gesetzt wird. Anschließend kann die nach $x$ aufgelöste Gleichung in $y= C x+ D u$ eingesetzt werden.

$
  x & = A x+ B u =^! 0 \
  y & = C x+ D u \
    \
  y & = C(-A^(-1)B u) + D u= (-C A^(-1)B+ D) dot u \
  y & := K u \
  K & =-C A^(-1)B+ D
$

== Pol-Nullstellen-Plot (Dynamikinformationen)
Da der Pol-Nullstellen-Plot keine Information über die statische Verstärkung $K$ enthält, ist er weniger aussagekräftig. Er kann mit dem `pzplot(sys)` Befehl in Matlab erstellt werden.

Die Pole der Übertragungsfunktion $G(s)$ korrespondieren mit den Eigenwerten der Systemmatrix $A$ unter der Voraussetzung, dass das System vollständig steuerbar und beobachtbar ist. Das heißt, es darf keine Pol-Nullstellen-Kürzung auftreten. An dem Plot ist erkennbar, dass das System einen Pol bei 0 hat und somit instabil ist.

#inline-note(
  rect: caution-rect,
  fill: orange,
)[`pzplot(sys)` Plot einfügen]

#figure(
  image("../images/Pol_Nullstellen_Diagramm.svg", width: 70%),
  caption: [Pol-Nullstellen-Plot],
)
