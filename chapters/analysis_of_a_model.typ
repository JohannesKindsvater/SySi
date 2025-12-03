#import "../config.typ": *

#set heading(numbering: "1.")
#set math.equation(numbering: "1.")

= Analyse des Modells

Im folgenden Abschnitt wird das System eines $P T_3 overline(T_2)^'$-Glieds mit folgender Übertragungsfunktion analysiert:
$
  G(s) = Y(s)/U(s) = (s-1)^2/(s+1)^3 = (s^2 - 2s + 1)/(s^3 + 3s^2 + 3s + 1)
$ <uebertragungsfunktion>

== Eigenschaften des Systems

Folgend eine Liste der Eigenschaften des Systems, die sich aus der Übertra-
gungsfunktion G(s) ergibt: \

- *Nennergrad - Zählergrad = 1*,
  dadurch ist das System *nicht sprungfähig*, antwortet aber *sofort* mit einer *Steigung*. Außerdem ist die *D-Matrix* (welche einem *Sprung am Anfang* ensprechen würde) gleich *0*.

- Besitzt *zweifache Nullstelle bei +1 *

- Besitzt *dreifache Polstelle bei -1*

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

\

-> Mit Frequenzgang kann man stationäre ... aus dem Bode Diagramm ablesen -> Nur für konstante Signale, sin, cos (nicht für beliebige Signale)

\

$
  x(t) & = e^(A t) dot x(0) + integral_0^t e^A(t-tau)B u(tau) d tau \
  y(t) & = C e^(A t) dot x(0) + C integral_0^t e^A(t-tau)B u(tau) d tau + D u(t)
$

\
\

Die explizite Darstellung wurde in MATLAB mithilfe der Symbolic Math Toolbox berechnet. Durch symbolische Integration der Zustandsgleichung *$dot(x) = A x + B u$* unter Verwendung des Matrixexponentials `expm` ergibt sich für einen Einheitssprung $u(t)=1$ folgende Zeitfunktion:

#space

#align(
  `2
    y(t) = 1 - 2 t  exp(-t) - exp(-t)`,
  center,
)
\
$
  y(t) = 1 - 2t^2e^(-t)-e^(-t)
$


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

ich habe im keks beispiel gesehen dass dort auch noch y(t) mit aufgeführt war, aber hier nicht. soll das so sein?

Für unser System gilt:

$
  x(t) = x(0) + integral^t_0 mat(-3, -1.5, -1; 2, 0, 0; 0, 0.5, 0; delim: "[") x(tau) + vec(2, 0, 0, delim: "[") u(tau) d tau
$

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Matritzen aus `ss(sys)` einsetzen und ggf. zusammenfassen]

=== Differentialgleichung <dgl>
Die Differentialgleichung ergibt sich meist aus dem physikalischen Modell und ist in unserem Fall mit den *Anfangswerten* wie folgt definiert:

\


$
  G(s) = Y(s)/U(s) = (s^2 - 2s + 1)/(s^3 + 3s^2 + 3s + 1)
$

$
  (s^3 + 3s^2 + 3s + 1) dot Y(s) = (s^2 - 2s + 1) dot U(s)
$

$
  (s^3 + 3s^2 + 3s + 1) dot Y(s) = (s^2 - 2s + 1) dot U(s)
$

hier steht im endeffekt das selbe wie direkt im chapter darunter, wir können das hier also entweder streichen oder das darunterrichtig?

\

#inline-note(
  rect: caution-rect,
  fill: orange,
)[TODO / / schauen ob wir das behalten weil wir kein physikalisches system haben]

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

--> Anfanfgswerte sollten ungleich 0 sein
$
  vec(y(0), dot(y)(0), dot.double(y)(0), delim: "[") = vec(1, 0, 0, delim: "[")
$

#inline-note(
  rect: caution-rect,
  fill: orange,
)[TODO]

== Übertragungsfunktion

Ein System kann auch durch die dazugehörige Übertragungsfunktion beschrieben werden, welche sich aus der Ein- und Ausgangsdifferentialgleichung mithilfe der Laplace Transformation ergibt. Die Übertragungsfunktion wurde durch die physikalische Betrachung hergeleitet und zu Beginn (@uebertragungsfunktion) benannt. Sie lautet:

\

$
  G(s) = (s^2 - 2s + 1)/(s^3 + 3s^2 + 3s + 1)
$


== Systemantworten
=== Gewichtsfunktion / Impulsantwort $delta(t)$
Die Gewichtsfunktion $g(t)$, auch Impulsantwort genannt, ist die Antwort des Systems auf einen Dirac-Impuls $delta(t)$ am Eingang.

In Matlab kann die Impulsantwort mit `impulse(sys)` geplottet werden. Die analytische Berechnung ist über `g(t) = ilaplace(G(s))` möglich. Die Ausgabe `exp(-t) - 4*t*exp(-t) + 2*t^2*exp(-t)` von Matlab bedeutet:

//exp(-t) - 4*t*exp(-t) + 2*t^2*exp(-t)

$
  g(t) = e^(-t) - 4 t e^(-t) + 2 t^2 e^(-t)
$

#figure(
  image("../images/ImpulseResponse12.png", width: 94%),
  caption: [Impulsantwort des Systems],
)

=== Übergangsfunktion / Sprungantwort $1(t)$
Die Übergangsfunktion ist die Antwort auf den Einheitssprung $1(t)$ und somit ohne Einheiten. Die Sprungantwort dagegen ist die Antwort auf einen technischen Einheitssprung und somit mit Einheiten.

Die Übergangsfunktion kann in Matlab mit `step(sys)` geplottet werden. Die analytische Berechnung erfolgt mit `h(t) = ilaplace(G(s)/s)`. Die Ausgabe `1 - 2*t^2*exp(-t) - exp(-t)` von Matlab bedeutet:

$
  h(t) = 1 - 2 t^2 e^(-t) - e^(-t)
$


#figure(
  image("../images/Sprungantwort.svg", width: 95%),
  caption: [Sprungantwort],
)

== Frequenzgang
Zum Frequenzgang $G(j omega)$ gelangt man, indem man die Variable $s$ durch $j omega$ in der Übertragungsfunktion $G(s)$ ersetzt. Hierbei steht $omega$ für die Kreisfrequenz in $(r a d)/ s$ (Erinnerung: $omega = 2 pi f$) und $j$ für die imaginäre Einheit. Da in der Systemtheorie $i$ für den Strom steht, wird für die imaginäre Einheit nicht $i$, sondern $j$ verwendet, um Verwechslungen zu vermeiden. Das bedeutet, dass für jede Frequenz $omega$, $G(j omega)$ eine komplexe Zahl mit Real- und Imaginärteil oder Betrag mit Phase darstellt.
Systemtheoretisch entspricht der Frequenzgang $G(j omega)$ einem Schritt der komplexen Funktion von $G(s)$ entlang der imaginären Achse: $G(s)|_(s=j omega)$

Mithilfe des Cursors kann in Matlab an der Kurve des Frequenzgangs $G(j omega)$, dargestellt in einem Bode- oder Nyquist-Diagramm, entlang gefahren werden, sodass der Real- und Imaginärteil zu dem jeweiligen Punkt angezeigt wird.

=== Bode-Diagramm
Im Bode-Diagramm ist der Betrag des Frequenzgangs über $omega$ in Dezibel sowie die Phasenverschiebung des Frequenzgangs über $omega$ in Grad dargestellt. Genau genommen sind dies die Amplitudenverstärkung und Phasenverschiebung, die ein Sinus an der jeweiligen Frequenz $omega$ stationär erfährt, d.h. die Eigenvorgänge sind abgeklungen $(t -> infinity)$. Um eine bessere Darstellung der Kurven zu erzeugen, wird beim Bode-Diagramm eine doppelt logarithmische Darstellung verwendet. Die Diagramm-Achse, auf der $omega$ aufgetragen ist, ist dabei logarithmisch skaliert, während der Betrag in Dezibel (dB) angegeben wird. In Matlab kann der Plot mit dem Befehl `bode(sys)` erstellt werden.


#figure(
  image("../images/Bode.svg", width: 95%),
  caption: [Bode-Plot],
)


=== Nyquist-Plot / Ortskurve
Im Nyquist-Plot wird der über $omega$ parametrisierte Frequenzgang $G(j omega)$ als Kurve in der komplexen Ebene mit Real- und Imaginärteil dargesetllt. Die Kurve des Frequenzgangs $G(j omega)$ wird in Matlab für $omega$ von $- infinity$ bis $+ infinity$ angezeigt. Der Nyquist Plot kann mithilfe des `nyquist(sys)` Befehls in Matlab erstellt werden.

#figure(
  image("../images/Nyquist.svg", width: 95%),
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
  image("../images/Simulink_integrator1.png", width: 80%),
  caption: [Simulink Schaltung mit Integratoren],
)

#inline-note(
  rect: caution-rect,
  fill: orange,
)[Eigene Ausgabe einsetzen]

#[
  #set heading(numbering: none, outlined: false)
  === Stationärer Vorgang
]

Der stationäre Vorgang beschreibt diejenige Phasenverschiebung und Amplitudenverstärkung, welche ein Sinussignal am Eingang mit einer konstanten Frequenz im eingeschwungenen Zustand erfährt. Für ein Eingangssignal $u(t) = a dot sin(omega_0 t+ phi_0)$ ergibt sich der stationäre Ausgang $y_("stat")$ gemäß folgender Beziehung:

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

Im Folgenden werden diese Größen exemplarisch für eine Kreisfrequenz von $omega = 10^(-1) (r a d)/s$ ermittelt. Dies erfolgt durch drei Methoden: analytische Berechnung, Ablesen aus dem Bode-Diagramm und Messung im Zeitbereich (Oszilloskop).

#inline-note(
  rect: caution-rect,
  fill: orange,
)[In dem folgenden Abschnitt muss die Phasenverschiebung und Amplitudenverstärkung zuerst analytisch berechnet und anschließend aus dem Bode-Plot und Oszilloskop abgelesen werden. Unten befindet sich eine kurze Zusammenfassung der Vorgehensweise.]

#[
  #set heading(numbering: none, outlined: false)
  === Analytische Berechnung
]

Für das gegebene System lässt sich die Übertragungsfunktion durch Faktorisierung (binomische Formeln) vereinfacht darstellen als $G(s) = (s-1)^2 / (s+1)^3$. Durch die Substitution $s = j omega$ können die allgemeinen Formeln für Betrag und Phase hergeleitet werden:

$
  |G(j omega)| & = frac(|j omega - 1|^2, |j omega + 1|^3) \
               & = frac((sqrt(1+omega^2))^2, (sqrt(1+omega^2))^3) \
               & = frac(1, sqrt(1+omega^2))
$
\
$
  arg(G(j omega)) & = arg((j omega - 1)^2) - arg((j omega + 1)^3) \
                  & = (2 pi - 2 arctan(omega)) - 3 arctan(omega) \
                  & = - 5 arctan(omega)
$

Für die betrachtete Testfrequenz $omega = 0.1 (r a d)/s$ ergeben sich durch Einsetzen folgende Werte:

#[
  #set math.equation(numbering: none)
  $
       |G(j 0.1)| & := (1 + 0.1^2)^(-1/2) approx 0.995 approx 1 \
    arg(G(j 0.1)) & := -5 arctan(0.1) approx -0.497 r a d approx -28.5 degree
  $
]
Wir erwarten also eine nahezu unveränderte Amplitude und eine Phasenverzögerung von rund $-29 degree$.

#[
  #set heading(numbering: none, outlined: false)
  === Analyse des Bode-Diagramms
]

Die analytischen Ergebnisse sollen nun durch das Bode-Diagramm verifiziert werden.

#figure(
  image("../images/Bode_Mit_Punkt_Oben.png", width: 80%),
  caption: [Amplitudengang des Bode-Plots mit Markierung bei $omega = 10^(-1) (r a d)/s$],
)

*Betragsgang:*
Der Betragsgang beginnt bei kleinen Frequenzen mit einer horizontalen Geraden, was charakteristisch für ein System mit Proportionalverhalten (P-Verhalten) ist. An der Stelle $omega approx 10^(-1) (r a d)/s$ lesen wir einen Betrag von:

$ D approx 0 d B $

Die Umrechnung in die statische Verstärkung $K$ erfolgt über:
$
  K = 10^(D/20) = 10^(0/20) = 1
$
Dies bestätigt die analytische Berechnung der Amplitudenverstärkung von $approx 1$.

\

#figure(
  image("../images/Bode_Mit_Punkt_Unten.png", width: 80%),
  caption: [Phasengang des Bode-Plots mit Markierung bei $omega = 10^(-1) (r a d)/s$],
)

*Phasengang:*
Im unteren Teil des Diagramms lesen wir für die Frequenz $omega = 10^(-1) (r a d)/s$ einen Phasenwinkel von:

$ phi approx 331 degree $

Unter Berücksichtigung der Periodizität entspricht dies:
$ phi = 331 degree - 360 degree = -29 degree $

Dieser Wert deckt sich exakt mit der analytisch berechneten Phasenverschiebung. Das negative Vorzeichen bestätigt, dass der Ausgang dem Eingang nacheilt.

#[
  #set heading(numbering: none, outlined: false)
  === Analyse im Zeitbereich (Oszilloskop)
]

Abschließend betrachten wir die Sprungantwort bzw. das Verhalten bei sinusförmiger Anregung im Simulink-Oszilloskop.

#figure(
  image("../images/Simulink_Oszillator_0.1Hz.png", width: 80%),
  caption: [Simulink Oszilloskop-Aufnahme bei Anregung mit $omega = 0.1 (r a d)/s$],
)

*Phasenverschiebung:*
Im Oszilloskop ist erkennbar, dass die blaue Ausgangskurve der gelben Eingangskurve zeitlich verzögert folgt. Wir lesen eine zeitliche Verzögerung (Time Delay) von ca. $Delta t approx 5 s$ ab.
Zur Überprüfung berechnen wir die erwartete Zeitverzögerung aus der zuvor ermittelten Phase $phi = -29 degree$ und der Periodendauer $T = (2 pi)/0.1 approx 63 s$:

$
  Delta t = (|phi|)/(360 degree) dot T = (29)/(360) dot 63 s approx 5.07 s
$
Der abgelesene Wert von ca. 5 Sekunden stimmt somit mit der Theorie überein.

*Amplitudenverstärkung:*
Das Eingangssignal (gelb) weist eine Amplitude von 1 auf. Das Ausgangssignal (blau) erreicht im eingeschwungenen Zustand (soweit im Bild sichtbar) ebenfalls nahezu die Amplitude 1 (bzw. 0.995). Dies bestätigt die Verstärkung von $K approx 1$.

#[
  #set heading(numbering: none, outlined: false)
  === Fazit
]

Die Untersuchung des Systems bei der Frequenz $omega = 0.1 (r a d)/s$ zeigt eine vollständige Übereinstimmung aller drei Methoden:

1. *Analytisch:* Verstärkung $approx 1$, Phase $approx -29 degree$.
2. *Bode-Diagramm:* $0 d B$ (Faktor 1) und $331 degree$ ($-29 degree$).
3. *Oszilloskop:* Amplitude $approx 1$ und Zeitverzögerung $approx 5 s$ (entspricht $-29 degree$).

Das System verhält sich bei dieser niedrigen Frequenz betragsmäßig wie ein P-Glied (Verstärkung 1), weist jedoch aufgrund der Nullstellen in der rechten Halbebene bereits eine signifikante Phasenverzögerung auf ("Allpass-Charakteristik" bzgl. der Betragsanteile, aber Addition der Phasenanteile).


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

#figure(
  image("../images/Pol_Nullstellen_Diagramm.svg", width: 70%),
  caption: [Pol-Nullstellen-Plot],
)
