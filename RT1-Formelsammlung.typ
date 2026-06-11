#set page(margin: 2cm, numbering: "1")
#set text(font: "New Computer Modern", size: 12pt)
#set heading(numbering: "1.1")

// --- EIGENE BEFEHLE FÜR MEHR ÜBERSICHT ---
// Grauer Kasten für besonders wichtige Formeln
#let important(body) = block(
  fill: rgb("#f4f4f4"), 
  inset: 14pt, 
  radius: 4pt, 
  width: 100%, 
  stroke: 1pt + rgb("#ddd"),
  body
)

#let placeholder(text) = block(
  width: 100%, 
  height: 60pt, 
  fill: luma(245), 
  stroke: 0.5pt , //luma(150), 
  radius: 2pt,
  align(center + horizon)[[_ Skizze: #text _]]
)


#let laplace = "⊶"

#outline()
#pagebreak()

= DGL aufstellen und BSB zeichnen
+ (Physikalische) Grundgleichungen aufstellen
+ Nach der höchsten Ableitung auflösen
+ Mit Integrierer BSB zeichnen:
  $ integral (d x(t)) / (d t) d t = x(t) $

*Beispiel Füllstand:*
$ (d h(t)) / (d t) = 1 / A (Q_"zu"(t) - Q_"ab"(t)) $

#figure(image("media/image3.jpg", width: 50%), caption: [Blockschaltbild Füllstand])
== Bauteil-Gleichungen & Kräfte
- *Spule:* $ u_L(t) = L (d i(t)) / (d t) $
- *Kondensator:* $ i_c(t) = C dot (d u_c(t)) / (d t) $
- *Gewichtskraft:* $ F_G = m dot g $
- *Federkraft:* $ F_s = c dot Delta x = c(x_e - x_a) $
- *Trägheitskraft:* $ F_T = m dot a = m dot (d^2 x(t)) / (d t^2) $
- *Dämpfungskraft*: $ F_D = D dot ((d x_e)/(d t) - (d x_a)/(d t) ) $

*(Pfeil entgegen Zählrichtung Position ansetzen! -> Kräfte addieren für Kräftebilanz)*
== Rechnen mit BSB
*Wichtig:* Alle Änderungen müssen so vollzogen werden, dass sich bei der Übertragungsfunktion nichts ändert! Schleifenverstärkung ändert sich auch nicht.



#important[
  #table(
    columns: (auto, 1fr, 1fr),
    align: (left, center, center),
    
    [*Verschaltung*], [*Übertragungsfunktion $F_"ges"$*], [*Ausgangssignal $X_a$*],
    [Reihenschaltung], [$F_"ges" = F_1 dot F_2$
    #image("media/image5.jpg")], [$X_a = F_1 dot F_2 dot X_e$
    #image("media/image6.jpg")],
    [Parallelschaltung], [$F_"ges" = F_1 + F_2$
    #image("media/image7.jpg")], [$X_a = (F_1 + F_2) dot X_e$
    #image("media/image8.jpg")],
    [Kreisschaltung], [$F_"ges" = F_"vor" / (1 + F_"vor" dot F_"rück")$
    #image("media/image9.jpg")], [$X_a = F_"ges" dot X_e$
    #image("media/image10.jpg")]
  )
]
#important[#table(columns: (1fr, 1fr),
align: (center, center),
[*Abzweigungen*],[],
[#image("media/image11.jpg")], [#image("media/image12.jpg")],
[#image("media/image13.jpg")], [#image("media/image14.jpg")],
[*Summations Punkte*],[],
[#image("media/image15.jpg")], [#image("media/image16.jpg")],
[#image("media/image17.jpg")], [#image("media/image18.jpg")]
)

]

#pagebreak()
= Linearisierung im BSB (Nichtlineare Strecke)

#figure(image("media/image4.jpg", width: 60%), caption: [Linearisierung BSB])

+ *Stationären Betriebspunkt berechnen* ($X_0$ z.B. $r_0$ vorgegeben):
  - *Alle Integrierereingänge sind Null!* -> Für alle Zweige Wert hinschreiben.
+ *Formeln für nichtlineare Strecken aufschreiben.*
+ *(Partielle) Ableitungen bilden und stationäre Werte einsetzen.*
  
  _Beispiel für $b = sqrt(a \/ x^2)$_:
  $ Delta b = (partial b) / (partial a) |_(a_0, x_0) dot Delta a + (partial b) / (partial x) |_(a_0, x_0) dot Delta x $
  $ Delta b = K_a dot Delta a + K_x dot Delta x $
+ *Neues BSB zeichnen* mit allen Größen als $Delta$!

#figure(image("media/image19.jpg", width: 40%), caption: [Beispiel Nichtlineares Glied])

#pagebreak()

= DGL Lösen im Laplace-Bereich
+ *DGL in Laplace-Bereich transformieren:*
  - Ableitung: $ dot(x)(t) ⊶ s dot X(s) - x(0^+) $
  - Integral: $ integral x(t) d t ⊶ 1/s dot X(s) $
  - _Annahme:_ Alle Anfangswerte sind 0! Sonst $x(0^+)$ beachten.
+ *Nach Übertragungsfunktion umstellen:*
  - Für Einheitssprungantwort $U_e(s) = 1 / s$ einsetzen.
+ *Mit Laplace-Tabelle rücktransformieren:*
  - Doppelbrüche beseitigen!

== Differenzgrad Zähler / Nenner ($d$)
$d < 0$: instabiles System, nicht realisierbar!

#table(
  columns: (auto, auto, auto, auto),
  align: center,
  [*$d$*], [*Beispiel $F(s)$*], [*Verhalten* ], [Sprungantwort],
  [$d=0$], [$2$], [Ausgang springt],[#image("media/image21.jpg",)],
  [$d=1$], [$3 / (1+2s)$], [Knick im Ursprung],[#image("media/image22.jpg")],
  [$d=2$], [$9 / ((s+2)(s+3))$], [Waagrechte Tangente im Ursprung ], [#image("media/image23.jpg")]
)

#pagebreak()

= Charakteristische Gleichung & Regelkreise

#important[
  *Charakteristische Gleichung (geschlossener RK):*
  $ 1 + F_R(s) dot F_S(s) = Z_o(s) + N_o(s) = 0 $
  _Nullstellen der char. Gl. sind Polstellen des geschlossenen RK! => Für Hurwitzbedingung verwenden._
]

*Kenngrößen:*
#image("media/image24.jpg")

== Relevante Übertragungsfunktionen
#important[
  === *Führungs-Übertragungsfunktion* (soll 1 sein für $t -> infinity$):
  $ F_W = X / W = (F_R F_S) / (1 + F_R F_S) quad -> quad F_W(s=0) = 1 $
  
  === *Stell-Übertragungsfunktion:*
  $ F_Y = Y / W = F_R / (1 + F_R F_S) $
  
  === *Stör-Übertragungsfunktion* (soll 0 sein für $t -> infinity$):
  $ F_Z = X / Z = (-F_S) / (1 + F_R F_S) quad -> quad F_Z(s=0) = 0 $

  === *Regeldifferenz*
  $ X_d =lim_(s -> 0) s (W(s) - X(s)) = lim_(s -> 0) s (W(s) - W (s) F_W (s)) 
  #linebreak()
  = lim_(s -> 0) s (W(s) (1 - (F_S (s) F_R (s)) / (1 + F_S (s) F_R (s)))) = lim_(s -> 0) s (W(s) / (1 + F_S (s) F_R (s))) $
  mit $W(s) = 1/s$ für den Einheitssprung

]#pagebreak()
== Grenzwerte (Standard-Regelkreis)

+ Grenzwerte Sätze:

    Reminder: $bold(cal(L)(sigma(t)) = 1 / s)$

  + *Endwertsatz*

    $ lim_(t -> oo) f(t) = lim_(s -> 0) s * F(s) $
    $ "Für Einheitssprung" ->  bold(lim_(t -> oo) f(t) = lim_(s -> 0) F(s)) $
    *Voraussetzung:* Der Grenzwert im Zeitbereich muss existieren. 

  + *Anfangswertsatz*
    $ lim_(t -> 0^+) f(t) = lim_(s -> oo) s * F(s) $
    $ "Für Einheitssprung" ->  bold(lim_(t -> 0^+) f(t) = lim_(s -> oo) F(s)) $
    *Voraussetzung:* Der Grenzwert $\lim_{s \to oo} s F(s)$ muss existieren.


+ Führungseingang aktiv 
  ($W(s) ⊶ w(t)$, $Z(s) = 0$):


  $x_d (infinity) = lim_(s->0) [s dot (1 - F_W) dot W(s)]$

  $y(infinity) = (w(infinity)) / (F_S(s=0)) |_(x_d(infinity)=0) #linebreak() "Bei P/PD-Regler:" y(infinity) = K_p dot x_d(infinity)$

+ Störeingang aktiv 
  ($Z(s) = z(t)$, $W(s) = 0$):


  $x_d(infinity) = lim_(s->0) [s dot F_S / (1 + F_R F_S) dot Z(s)]$#linebreak()
  $x(infinity) = -x_d(infinity) = -lim_(s->0) [s dot F_S / (1 + F_R F_S) dot Z(s)]$ #linebreak()

== Gutes Führungsverhalten:

Anregelzeit ($T_"An"$) und Ausregelzeit ($T_"Aus"$) sollen kurz sein. Regelabweichung $x_d$ und Überschwingweite sollen klein sein.

$ macron(u) = (x_"max" - x(infinity)) / (x(infinity)) $
$ T_"ein" approx 3 dot T_"RK" quad "(95% erreicht)" $
$ T_"RK" = "größte Systemzeitkonstante" \/ "langsamste Polstelle" $

#figure(image("media/image27.jpg", width: 60%), caption: [Toleranzband und Kenngrößen])


#pagebreak()

= Regler-Auswahl und Strecken
== Regler-Übersicht
#table(
  columns: (auto, auto, 1fr),
  align: (left, center, left),
  [*Regler*], [*Übertragungsfunktion $F_R(s)$*], [*Einfluss auf den geschlossenen Kreis*],
  [P-Regler], [$K_P$], [Macht das System schneller ($omega_0$ steigt), aber oft schwingender (Dämpfung $D$ sinkt).],
  [I-Regler], [$K_I / s$], [Beseitigt die bleibende Regelabweichung, macht das System aber träger und instabiler ($D$ sinkt stark).],
  [PI-Regler], [$K_P dot (1 + s dot T_N) / (s dot T_N)$], [Kombiniert P- und I-Vorteile. Erlaubt oft die Kompensation einer Streckenzeitkonstanten.],
  [PD-Regler \ (real)], [$K_P dot (1 + T_V dot s) / (1 + T_D dot s)$], [Der D-Anteil bremst rechtzeitig ab. *Erhöht die Dämpfung $D$* und stabilisiert das System.],
  [PID-Regler \ (ideal)], [$K_P dot ((1 + T_N s) dot (1 + T_V s)) / (T_N dot s)$], [Alleskönner: Keine bleibende Abweichung (I), schnell (P) und gut gedämpft (D).],
  [PID-Regler \ (real / PIDT_D)], [$K_P dot ((1 + T_N s)(1 + T_V s)) / (T_N s (1 + T_D s))$], [Wie idealer PID, aber realisierbar durch Tiefpassfilterung ($T_D$) hoher Frequenzen.]
)

== Symbolverzeichnis & Erklärungen
#table(
  columns: (auto, 1fr),
  align: (center, left),
  [*Symbol*], [*Bedeutung / Funktion*],
  [$K_P$], [*Proportionalbeiwert (Reglerverstärkung):* Bestimmt die Stärke des direkten, proportionalen Eingriffs.],
  [$K_I$], [*Integrationsbeiwert:* Verstärkungsfaktor des I-Anteils.],
  [$T_N$], [*Nachstellzeit:* Bestimmt das Gewicht des I-Anteils. Je kleiner $T_N$, desto aggressiver integriert der Regler.],
  [$T_V$], [*Vorhaltzeit:* Bestimmt das Gewicht des D-Anteils. Sie gibt an, wie stark der Regler auf die Änderungsgeschwindigkeit reagiert.],
  [$T_D$], [*Verzögerungszeitkonstante (Filterzeit):* Macht den D-Anteil realisierbar, indem sie hochfrequentes Rauschen dämpft (Tiefpass).],
  [$D$], [*Dämpfungsgrad:* Maß für das Schwingungsverhalten. \ ($D < 1$: schwingend, $D = 1$: aperiodischer Grenzfall, $D > 1$: kriechend)],
  [$omega_n$], [*Ungedämpfte Eigenkreisfrequenz:* Frequenz, mit der das System ohne Dämpfung schwingen würde.],
  [$hat(w)$], [*Sprunghöhe:* Die Amplitude des Eingangssprungs ($hat(w) = 1$ für den Einheitssprung).]
)

#set page(margin: 1cm, flipped: true)
== Regelstrecken-Übersicht

#table(
  columns: (1.2fr, 2fr, 2fr, 1.2fr, 1.2fr, 1.2fr),
  align: (left, left, center, center, center, center),
  stroke: 0.5pt + black,
  
  // Kopfzeile
  [*Regelstrecke*], [*Übertragungsfunktion*], [*Sprungantwort*], [*Pol/Nullstellen-Diagramm*], [*Ortskurve*], [*Verlauf im Bode-Diagramm*],

  // 1. PT1-Strecke
  [
    *$P T_1$-Strecke*
  ],
  [
    $ F(s) = X(s)/Y(s) = K_s / (1+s dot T) $
    mit $K_s = x(infinity) / y(infinity)$ \
    wenn Einheitssprung: $K_s = x(infinity)$ \
    da $y(t > 0) = 1 = y(infinity)$
  ],
  [ #image("media/image43.jpg") ],
  [ #image("media/image44.jpg") ],
  [ #image("media/image45.jpg") ],
  [ #image("media/image46.jpg") ],

  // 2. PT2-Strecke (nicht schwingungsfähig)
  [
    *$P T_2$-Strecke (nicht schwing- ungsfähig)* \ \
    wenn $#highlight(fill: yellow)[$D > 1$]$ \
    und/oder \
    *2 reelle Pole* $"Rightarrow"$ \
    nicht schwing.fähig
  ],
  [
    $ F(s) = K_s / ((1+s T_1) dot (1+s T_2)) $ \
    mit $T_1, T_2$: Zeitkonstanten
  ],
  [
    #image("media/image47.jpg")
    $T_Sigma = T_1 + T_2 approx 63% "des Endwerts"$
  ],
  [ #image("media/image49.jpg") ],
  [ #image("media/image50.jpg") ],
  [ #image("media/image51.jpg") ],

  // 3. PT2-Strecke (schwingungsfähig)
  [
    *$P T_2$-Strecke (schwing- ungsfähig)* \ \
    wenn $#highlight(fill: yellow)[$0 < D < 1$]$ \
    und /oder \
    *konj. komplexes Polpaar* $"Rightarrow"$ \
    schwing.fähig
  ],
  [
    $ F(s) = (K_s dot omega_0^2) / (s^2 + 2 D omega_0 s + omega_0^2) $ \
    mit $omega_0, D$ aus charakteristischen Gleichung \ \
    *schwingungsfähig*, wenn bei \
    Nennerpolynom: \
    $Delta = b^2 - 4a c > 0$ \
    *stabil*, wenn Realteil der \
    Polstellen negativ ist!
  ],
  [
    #image("media/image48.jpg")

    
  ],
  [
    #image("media/image52.jpg")
  
  ],
  [ #image("media/image53.jpg") ],
  [ #image("media/image54.jpg") ],

  // 4. I-Strecke
  [
    *I-Strecke* (ohne Verzögerung)
  ],
  [
    $ F(s) = K_"IS" / s $ \
    mit $K_"IS" =$ Integrierbeiwert \
    (Steigung der \
    Einheits-Sprungantwort)
  ],
  [ #image("media/image55.jpg") ],
  [ #image("media/image56.jpg") ],
  [ #image("media/image57.jpg") ],
  [ #image("media/image58.jpg") ],

  // 5. IT1-Strecke
  [
    *$I T_1$-Strecke* \
    (Reihenschaltung \
    von $P T_1$- und \
    I-Strecke)
  ],
  [
    $ F(s) = K_"IS" / (s dot (1+s T_1)) $
  ],
  [ #image("media/image59.jpg") ],
  [ #image("media/image60.jpg") ],
  [ #image("media/image61.jpg") ],
  [ #image("media/image62.jpg") ],

  // 6. DT1-Strecke
  [
    *$D T_1$-Strecke*
  ],
  [
    $ F(s) = (K_"DS" dot s) / (1+s T_1) $ \ \
    $T_1 =$ Tangente wie bei $P T_1$! \ \
    $K_"DS" = T_1 dot x(0^+)$
  ],
  [ #image("media/image63.jpg") ],
  [ #image("media/image64.jpg") ],
  [ #image("media/image65.jpg") ],
  [ #image("media/image66.jpg") ],

  // 7. Allpass 1. Ordnung
  [
    *Allpass* 1. Ordnung
  ],
  [
    $ F(s) = K_s dot (1-T s) / (1+T s) $
  ],
  [ #image("media/image67.jpg") ],
  [ #image("media/image68.jpg") ],
  [ #image("media/image69.jpg") ],
  [ #image("media/image70.jpg") ],

  // 8. Totzeit-Strecke
  [
    *Totzeit*-Strecke
  ],
  [
    $ F(s) = e^(-s dot T_t) $
  ],
  [ #image("media/image71.jpg") ],
  [ #image("media/image73.jpg") ],
  [ #text(size: 20pt,fill: red)[X] ],
  [ #image("media/image74.jpg") ]
)

#set page(margin: 2cm, numbering: "1",  flipped: false)

#figure(image("media/image35.jpg", width: 80%), caption: [Welcher Regler passt zu welcher Strecke?])

== Regelung $P T_1$

=== Regelung $P T_1$ mit P-Regler:
$F_R(s) = K_p quad text("und") quad F_S(s) = K_S / (1 + T_1 s) $

$=> F_W(s) = (F_R F_S) / (1 + F_R F_S) = (K_p K_S) / (1 + K_p K_S) 1 / (1 + T_1 / (1 + K_p K_S) s) = K_W 1 / (1 + T_W s) $

$F_Y(s) = F_R / (1 + F_R F_S) = (K_p * (1 + T_1 s)) / (1 + K_p K_S + T_1 s) $

$=> y(oo) = K_p / (1 + K_p K_S); quad y(0^+) = K_p $

$laplace x(t) = (K_p K_S) / (1 + K_p K_S) [1 - e^(-t / (T_1 / (1 + K_p K_S)))] = K_W [1 - e^(-t/T_W)] $

(Führungs-Sprungantwort mit Einheitssprung) \ \
#underline[Problem:] *bleibende Regeldifferenz* $x_d(oo) = w(oo) - K_W$

=== Regelung $P T_1$ mit I-Regler:
$ F_R(s) = K_I / s quad text("und") quad F_S(s) = K_S / (1 + T_1 s) $
$ => F_W(s) = (F_R F_S) / (1 + F_R F_S) = (K_I * K_S) / (K_I * K_S + s(1 + T_1 s)) $
Der I-Regler ist stationär genau für $F_W(s=0) = 1$, also somit genau im Führungsverhalten. Führungsgröße=const. \
$=> w(oo) = x(oo)$ \
Durch Koeffizientenvergleich mit schwingungsfähigen $P T_2$-System kann man Dämpfung D bestimmen. $=>$
$ F_W(s) = ((K_I K_S)/T_1) / (s^2 + 1/T_1 s + (K_I K_S)/T_1) = (K_W * omega_0^2) / (s^2 + 2 * D * omega_0 * s + omega_0^2) $
$ text("mit ") D = 1 / (2 sqrt(T_1 K_I K_S)) quad text("und") quad omega_0 = sqrt((K_I K_S)/T_1) $
Für $K_I > 1 / (4 * T_1 * K_S)$ und $D < 1$ ist der Regelkreis schwingungsfähig! ($D = 0.5 dots 1$ ist sinnvoll) \
Störübertragungsfunktion $F_Z(s)$:
$ F_Z(s) = X(s)/Z(s) = (- F_S) / (1 + F_R F_S) = (-K_S * s) / (K_I K_S + s(1 + T_1 s)) quad (D T_2 text("-Verhalten")) => $
$ F_Z(s=0) = 0 => text("Störgröße Z wird völlig ausgeregelt!") $

#v(1em)
=== Regelung $P T_1$ mit PI-Regler
$ F_R(s) = K_p (1 + s T_N) / (s T_N) $
Ziel: dynamische Kompensation der Polstelle $=>$ Wahl #highlight(fill: yellow)[$T_N = T_1$]!
$ => F_O(s) = K_p (1 + T_N s) / (T_N s) * K_S / (1 + T_1 s) = (K_p K_S) / (T_1 s) $
Führungs-Üfkt (nach dynamischer Kompensation):
$ F_W(s) = 1 / (1 + T_1 / (K_p K_S) s) $

#table(
    columns: (auto, 1fr, 35%),
    align: (left, left, center),
    stroke: 1pt + black,
    [$P T_1$+P-Regler], [schnell, kein Schwingen, bleibende Regeldifferenz], image("media/image28.jpg", width: 80%),
    [$P T_1$+I-Regler], [Schwingneigung, keine bleibende Regeldifferenz], image("media/image29.jpg", width: 80%),
    [$P T_1$+PI-Regler], [kein Schwingen, keine bleibende Regeldifferenz], image("media/image30.jpg", width: 80%)
)

#v(1em)
== Regelung $P T_2$
=== Regelung $P T_2$ mit PI-Regler: 
Übertragungsfunktion für offenen Regelkreis $F_O(s)$:
$ F_O(s) = K_p * (1 + T_N s) / (T_N s) * K_S / ((1 + T_1 s)(1 + T_2 s)) quad text("mit ") T_N = T_1 > T_2 $
Dyn. Komp. (Kürzen) der *größten* Streckenzeitkonstante! \
Führungs-Übertragungsfunktion $F_W(s)$:
$ F_W(s) = (K_p K_S) / (K_p K_S + T_N s(1 + T_2 s)) quad text("mit gekürztem ") T_1 $
(stationär genau und schwingungsfähig für große $K_P$!) \
Abklingkonstante: $2 * D * omega_0 = 1/T_2$



#underline[Regelung $P T_2$ mit realem PD-Regler:] \
Übertragungsfunktion für offenen Regelkreis $F_O(s)$:
$ F_O(s) = K_p * (1 + T_V s) / (1 + T_D s) * K_S / ((1 + T_1 s)(1 + T_2 s)) quad text("mit ") T_V = T_1 > T_2 $
dynamische Kompensation der *größten* Streckenzeitkonstante! \
Abklingkonstante: $2 * D * omega_0 = 1/T_2 + 1/T_D$ (schneller und besser als PI)

#v(1em)
#underline[Regelung $P T_2$ mit idealem PID-Regler:] \
Übertragungsfunktion für offenen Regelkreis $F_O(s)$:
$ F_O(s) = K_p * ((1 + T_N s)(1 + T_V s)) / (T_N s) * K_S / ((1 + T_1 s)(1 + T_2 s)) quad text("mit ") T_N = T_1, T_V = T_2 $
dynamische Kompensation *beider* Streckenzeitkonstanten! $=> F_O(s) = (K_p K_S) / (T_N s)$ \
Führungs-Übertragungsfunktion $F_W(s)$:
$ F_W(s) = (K_p K_S) / (K_p K_S + T_N s) = 1 / (1 + T_N / (K_p K_S) s) $
(stationär genau und schwingungsfähig für große $K_P$!)

#table(
    columns: (auto, 1fr, 35%),
    align: (left, left, center),
    stroke: 1pt + black,
    [$P T_2$+PI-Regler], [langsamer als PD, RK neigt zu Instabilität], image("media/image31.jpg", width: 80%),
    [$P T_2$+PD-Regler], [schneller als PI, bleibende Regeldifferenz, große Stellsignale], image("media/image32.jpg", width: 80%),
    [$P T_2$+PID-Regler], [schnell, keine bleibende Regeldifferenz], image("media/image33.jpg", width: 80%)
)

#v(1em)
== Regelung $I T_1$
=== Regelung $I T_1$-Strecke mit P-Regle
$ F_S(s) = K_(I S) / (s * (1 + s T_1)), quad F_R(s) = K_p $
stationär *genau* im *Führungsverhalten* \
*nicht* stationär *genau* im *Störverhalten* \
=> Abweichungen bei Störungen! \
Regelkreis schwingungsfähig bei großen $K_p$

#v(1em)
=== Regelung $I T_1$-Strecke mit I-Regler
$ F_S(s) = K_(I S) / (s * (1 + s T_1)), quad F_R(s) = K_I / s $
*immer instabil weil s-Term vom Grad 1 fehlt!* \
$=>$ $I T_1$-Strecke kann nicht mit I-Regler geregelt werden!

#v(1em)
=== Regelung $I T_1$-Strecke mit PI-Regler
$ F_S(s) = K_(I S) / (s * (1 + s T_1)), quad F_R(s) = K_p (1 + T_N s) / (T_N s) $
dynamische Kompensation nicht möglich \
Nur stabil für $T_N > T_1$! $=>$ Wahl nach #underline[symmetrischen Optimum] \
#underline[symmetrisches Optimum:]
$ T_N attach(=, t: !) 4 * T_Sigma $
$ K_P attach(=, t: !) 1 / (2 K_(I S) T_Sigma) quad text("mit ") T_Sigma text(" als Summe aller Zeitkonstanten ") T_1, T_2... $
$=>$ I-Regler bei I-Strecken neigen zu Instabilität \
#underline[Allgemein gilt:] \
*I-Anteil:* sorgt für stationäre Genauigkeit und destabilisiert den RK \
*D-Anteil:* sorgt für schnelleres und stabilisierendes Verhalten, verstärkt aber das Messrauschen und führt zu großen Stellsignalen. \
*Grundsätzlich* muss $K_P$ als Kompromiss zws. Schnelligkeit und Dämpfung gewählt werden.


#important[
  *Der Analoge PI-Regler (Op-Amp):*
  
  #figure(image("media/image36.jpg", width: 70%), caption: [Analoger PI-Regler (Op-Amp)])
]
#important()[
    *Digitale Regler-Realisierung:*

    Faustformel für Abtasttakt $T_(a b)$: $T_(a b) <= 0.1 / omega_0$ \
Kennkreisfrequenz $omega_0$: \
Koeffizientenvergleich mit Üfkt zweiten Grades \
Bsp: $F(s) = (K * omega_0^2) / (s^2 + 2*D*omega_0*s + omega_0^2) -> omega_0$ auslesen
]
#pagebreak()

= Stabilität von Regelkreisen

Für einen stabilen Regelkreis müssen alle Lösungen der charakteristischen Gleichung, somit alle Polstellen, in der linken s-Halbebene liegen.

#v(1.5em)
== Hurwitz-Kriterium 
Algebraisches Verfahren, welches *nicht* für Totzeitstrecken anwendbar ist. 
Ausgehend von char. Gl. in Polynomform: 
$ ... a_3 s^3 + a_2 s^2 + a_1 s + a_0 = 0 $
=== Hurwitzbedingung 1:
  *Alle* Koeffizienten $a_0 ... a_n != 0$ *und* das *gleiche* Vorzeichen haben!
=== Hurwitzbedingung 2:
  Hurwitz-Determinanten müssen positiv sein ($H_i > 0; quad i = 1 ... (n-1)$) \
  $=>$ Bis $H_2$ für charakt. Gl. vom Grad 3 (mit $s^3$)!

$ H_1 = a_1 attach(>, t: !) 0 $
$ H_2 = det mat(a_1, a_3; a_0, a_2) = a_1 a_2 - a_0 a_3 attach(>, t: !) 0 $
$ H_3 = det mat(a_1, a_3, a_5; a_0, a_2, a_4; 0, a_1, a_3) = a_1 a_2 a_3 + a_0 a_1 a_5 - a_1^2 a_4 - a_0 a_3^2 attach(>, t: !) 0 $
Die Komponenten der Matrizen kommen direkt aus der char. Gl.!

#v(2em)

// ==========================================
// Nyquist-Kriterien
// ==========================================
== Nyquist-Kriterien
=== Vereinfachtes Nyquist-Kriterium für geschlossenen Rk
*Grafisches* Verfahren! *Nur* für *stabile offene* Rk \
(wenn alle Pole des offenen Rk ($F_S F_R$) auf linker p-Halbebene liegen, höchstens Doppelpol im Ursprung)

#v(1em)
#image("media/image41.jpg", width: 40%)
*Stabil*, wenn Punkt *-1* beim *"Abfahren"* der Ortskurve *immer auf der linken* Seite liegt!
 
#v(1.5em)
#text(size: 11pt, weight: "bold")[Amplituden- und Phasenrand:]
#image("media/image40.jpg", width: 40%)

*Amplitudenrand* $A_"rand"$: Bei $omega_"krit"$ ist $F_o(j omega_"krit") = (-1) / A_"rand"$ 

*Phasenrand* $phi_"rand"$: Bei $omega_D$ (Durchtrittsfrequenz) ist $|F_o(j omega_D)| = 1$ 

*Kritische Verstärkung:* $K_(P_"Krit") = A_"rand" * K_p <=> A_"rand" = K_(P_"Krit") / K_p$

#v(1em)
* $omega_"krit"$ berechnen: $s = (j omega)$ in char. Gl. einsetzen, Imaginärteil gleich 0 setzen, nach $omega$ auflösen!
* $K_(P_"Krit")$ berechnen: $s = (j omega)$ in char. Gl. einsetzen, *Realteil* gleich 0 setzen, $omega = omega_"Krit"$ einsetzen, nach $K_p$ auflösen!

#v(2em)
=== Verallgemeinertes Nyquist-Kriterium
Immer anwendbar auf Üfkt des offenen Rk ($F_R F_S$)!

+ $Delta phi_"Stabil" = (n_p + n_i / 2) * pi$ berechnen, mit: \
  $n_p =$ Anzahl instabile Pole, $n_i =$ Anzahl Pole im Ursprung \
  im offenen Regelkreis!
+ *Drehung* Verbindungslinien von Ortskurve zu *-1* ermitteln \
  $=>$ Bei Anfang der Ortskurve ($omega = 0$) beginnen, Linien zum Punkt *-1* zeichnen, insgesamte Drehung berechnen. \
  Gegen den UZS: positives $Delta phi_"Mess"$, mit UZS: negativ.

#v(1em)
#image("media/image42.jpg", width: 50%)
#v(1em)
*Kriterium:* Geschlossener RK ist *stabil*, wenn Phasendrehung $Delta phi_"Mess"$ von $F_o(j omega)$ bezüglich des Punktes -1 für $omega = 0 ... oo$ den Wert
$ Delta phi_"Stabil" = (n_p + n_i / 2) * pi $
besitzt.
#pagebreak()

= Laplace-Transformationstabelle 

#align(center)[
  #table(
    columns: (auto, 1fr, 1fr),
    align: (center, left, left),
    stroke: 0.5pt + luma(200),
    fill: (col, row) => if row == 0 { luma(240) } else { none },
    
    // Kopfzeile
    [*Nr.*], [*Zeitfunktion $f(t)$*], [*Laplace-Transformierte $F(s)$*],
    
    // Bild 1 (Nr. 1 - 18)
    [1], [$ delta("Impuls") delta(t) $], [$ 1 $],
    [2], [$ "Sprungfunktion" sigma(t) $], [$ 1 / s $],
    [3], [$ t $], [$ 1 / s^2 $],
    [4], [$ t^2 $], [$ 2 / s^3 $],
    [5], [$ t^3 $], [$ 6 / s^4 $],
    [6], [$ t^n $], [$ (n!) / s^(n+1) $],
    [7], [$ e^(-a t) $], [$ 1 / (s + a) $],
    [8], [$ t dot e^(-a t) $], [$ 1 / (s + a)^2 $],
    [9], [$ t^2 dot e^(-a t) $], [$ 2 / (s + a)^3 $],
    [10], [$ (t - (a t^2) / 2) dot e^(-a t) $], [$ s / (s + a)^3 $],
    [11], [$ (1 - 2 a t + ((a t)^2) / 2) dot e^(-a t) $], [$ s^2 / (s + a)^3 $],
    [12], [$ t^n dot e^(-a t) $], [$ (n!) / (s + a)^(n+1) $],
    [13], [$ 1 - e^(-a t) $], [$ a / (s dot (s + a)) $],
    [14], [$ e^(-a t) - e^(-b t) $], [$ (b - a) / ((s + a)(s + b)) $],
    [15], [$ a e^(-a t) - b e^(-b t) $], [$ ((a - b) dot s) / ((s + a)(s + b)) $],
    [16], [$ 1 + (b e^(-a t) - a e^(-b t)) / (a - b) $], [$ (a dot b) / (s dot (s + a)(s + b)) $],
    [17], [$ 1 - (1 + a t) dot e^(-a t) $], [$ a^2 / (s dot (s + a)^2) $],
    [18], [$ a t - 1 + e^(-a t) $], [$ a^2 / (s^2 dot (s + a)) $],
    
    // Bild 2 (Nr. 19 - 33)
    [19], [#text(size: 10pt)[$ e^(-a t) / ((b - a)(c - a)) + e^(-b t) / ((c - b)(a - b)) + e^(-c t) / ((a - c)(b - c)) $]], [$ 1 / ((s + a)(s + b)(s + c)) $],
    [20], [#text(size: 8pt)[$ 1 / (a b c) { 1 - [ (b c dot e^(-a t)) / ((b - a)(c - a)) - (c a dot e^(-b t)) / ((c - b)(a - b)) - (a b dot e^(-c t)) / ((a - c)(b - c)) ] } $]], [$ 1 / (s (s + a)(s + b)(s + c)) $],
    [21], [$ sin(omega_0 t) $], [$ omega_0 / (s^2 + omega_0^2) $],
    [22], [$ cos(omega_0 t) $], [$ s / (s^2 + omega_0^2) $],
    [23], [$ sin(omega_0 t + phi) $], [$ (s sin(phi) + omega_0 cos(phi)) / (s^2 + omega_0^2) $],
    [24], [$ 1 - cos(omega_0 t) $], [$ omega_0^2 / (s dot (s^2 + omega_0^2)) $],
    [25], [$ 1 / 2 t sin(omega_0 t) $], [$ (omega_0 dot s) / (s^2 + omega_0^2)^2 $],
    [26], [$ 1 / 2 (sin(omega_0 t) - omega_0 t dot cos(omega_0 t)) $], [$ omega_0^3 / (s^2 + omega_0^2)^2 $],
    [27], [$ 1 / 2 (sin(omega_0 t) + omega_0 t dot cos(omega_0 t)) $], [$ (omega_0 dot s^2) / (s^2 + omega_0^2)^2 $],
    [28], [$ sin^2(omega_0 t) $], [$ (2 omega_0^2) / (s dot (s^2 + 4 omega_0^2)) $],
    [29], [$ cos^2(omega_0 t) $], [$ (s^2 + 2 omega_0^2) / (s dot (s^2 + 4 omega_0^2)) $],
    [30], [$ e^(-a t) dot sin(omega_0 t) $], [$ omega_0 / ((s + a)^2 + omega_0^2) $],
    [31], [$ e^(-a t) dot cos(omega_0 t) $], [$ (s + a) / ((s + a)^2 + omega_0^2) $],
    [32], [$ 1 / omega_e e^(-delta t) sin(omega_e t) $ \ _mit: $delta = D dot omega_0; D < 1; omega_e = omega_0 dot sqrt(1 - D^2)$_], [$ 1 / (omega_0^2 + 2 D omega_0 s + s^2) $],
    [33], [$ 1 - e^(-delta t) / omega_e (delta sin(omega_e t) + omega_e cos(omega_e t)) $ \ _Abkürzungen siehe Nr. 32; $D < 1$_], [$ omega_0^2 / (s dot (omega_0^2 + 2 D omega_0 s + s^2)) $]
  )
]