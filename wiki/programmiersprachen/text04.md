# Weitere grundlegende Konzepte

## Schleifen
Wir wissen, dass der Computer besser und schneller rechnen kann als jeder Mensch, 
aber es gibt etwas, wo der Abstand zwischen Mensch und Computer noch größer ist: 
**Immer wieder die selbe Tätigkeit verrichten, ohne Abweichung, ohne Müdigkeit, 
ohne Flüchtigkeitsfehler!**

Eine Schleife bedeutet, dass die gleiche Sequenz von Anweisungen immer wieder 
durchlaufen wird. Das ist also etwas, was dem Computer sehr entgegen kommt.

#### Ausstiegsbedingung / Fortführungsbedingung

Jede Schleife braucht eine Ausgangsbedingung. Ansonsten wäre es eine Endlosschleife 
und Endlosschleifen sind normalerweise eine verdammt schlechte Idee. Viele Sachen 
sind mögliche Ausstiegsbedingungen. Relativ häufige Beispiele sind:
- Der Computer soll Datensätze aus einer Datenbank auslesen, bis er mit allen 
Durchsätzen durch ist.
- Der Computer soll eine Datei Zeile für Zeile einlesen, bis er am Ende der 
Datei angelangt ist.
- Der Computer soll eine bestimmte Operation genau 8.357mal durchführen.
- Der Computer soll eine Operation so oft durchführen, bis das Ergebnis eine 
bestimmte Genauigkeit hat.
- Der Computer soll etwas so lange tun bis der Benutzer eine Eingabe getätigt hat.

In der Regel gilt: Die Ausstiegsbedingung kann als boolsche Bedingung formuliert 
werden, also die Bedingung liegt entweder vor oder nicht (true oder false). 
Die Umkehrung der Ausstiegsbedingung ist die Fortführungsbedingung. Sprich: Wenn 
kein Grund vorliegt, die Schleife abzubrechen, dann liegt offensichtlich ein 
Grund vor, die Schleife fortzusetzen. Beide Varianten gibt es, also dass eine 
Schleife entweder eine Ausstiegsbedingung oder eine Fortführungsbedingung 
benötigt und darauf muss man ein wenig achten.

#### Schleifentypen

Kommen wir nun zu den häufigen Schleifentypen:

###### for-Schleife

Die folgende Art, eine Schleife zu konstruieren, hat sich so durchgesetzt, dass 
im Prinzip keine Programmiersprache ohne diesen Schleifentyp auskommt:

```
  for (var x = 0; x < 1000; x++) {
    // Tu etwas wiederholt
  }
  // Weiter gehts nach der Schleife
```

Die for-Anweisung hat drei durch Semikolons getrennte Elemente:
  ```
  for (Initialisierung; Fortführungsbedingung; Schrittabschluss)
  ```
  - Initialisierung: Die Operation, die **vor** allen Schleifendurchläufen 
  durchgeführt wird. In der Regel wird hier, wie in dem Beispiel eine Variable 
  auf ihren Ausgangswert gesetzt. Das von mir benutzte var-Keyword zeigt, dass 
  die Variable direkt in der Schleife erst initialisiert wird. Wenn Euch x nach 
  dem Schleifendurchgang weiterhin zur Verfügung stehen soll als Wert, dann 
  müsst Ihr x vor der Schleife definieren. Wir haben gelernt, dass Variablen 
  einen Scope haben und in dieser Variante von mir ist der Scope der Variable 
  lediglich die Schleife selbst. x existiert nicht mehr nach der Schleife.
  - Fortführungsbedingung: **Vor dem ersten Durchgang und vor jedem weiteren 
  Durchgang** wird geprüft, ob diese Bedingung true ergibt. Wenn dem so ist, 
  dann wird die Schleife einmal durchlaufen.
  - Schrittabschluss: Nach dem Schleifendurchlauf wird diese Anweisung ausgeführt, 
  bevor die nächste Prüfung auf einen erneuten Schleifendurchlauf erfolgt.

  Der obige Code ist die häufigste Form einer solchen Schleife. x startet mit 0 
  und wird nach und nach hochgezählt bis 999 (also insgesamt 1.000 Durchläufe, da 
  x mit jedem Durchgang um 1 erhöht wird). Durch kreative Verwendung der Elemente 
  lassen sich dann andere Konstellationen abbilden:
  -  Alle ungeraden Zahlen unter 1000
    ```
    for (var x = 1; x < 1000; x = x + 2) {
      // Tu was
    }
    ```
  - Zahlen von -100 bis -200, in dieser Reihenfolge
    ```
    for (var x = -100; x >= -200; x--) {
      // Tu was
    }
    ```
  - Abbruch aufgrund der Erzielung eines bestimmten Ergebnisses anstatt aufgrund 
  einer bestimmten Zählvariable
    ```
    var ergebnis = 'noch nicht';
    for (var x = 0; ergebnis != 'jetzt aber'; x++) {
      // Tu was, was unter bestimmten Umständen dann ergebnis auf 'jetzt aber' setzt
    }

    // Dieses Vorgehen ist aber eigentlich ungünstig, selbst eine solche Schleife 
    // sollte also die maximale Anzahl von Schritten begrenzen, um keine 
    // Endlosschleife zu produzieren
    var ergebnis = 'noch nicht';
    for (var x = 0; ergebnis != 'jetzt aber' && x < 10000; x++) {
      // Tu was, was ggf. ergebnis auf 'jetzt aber' setzt
    }

    // Und selbst hier ist es besser, mit einem Schleifenabbruch zu arbeiten, 
    // dazu gleich mehr.
    ```
Wie man sieht ist die Schleifentyp sehr flexibel und lässt sich an die eigenen 
Bedingungen anpassen.

###### while-Schleife / Kopfgesteuerte Schleife

Die while-Schleife ist eine sogenannte Kopfgesteuerte Schleife. Das heißt, dass 
vor jedem Schleifendurchlauf geprüft wird, ob die Fortführungsbedingung noch 
vorliegt. Für die for-Schleife galt ähnliches.  Die for-Schleife ist eher dann 
anzuwenden, wenn die Anzahl der Durchläufe direkt zu Beginn der Schleife festliegt, 
zum Beispiel durch die Anzahl der Werte in einem Array. Die while-Schleife ist 
eher auf eine unbestimmte Anzahl von Durchläufen hin ausgelegt.

```
var ergebnis = 'noch nicht';
while (ergebnis == 'noch nicht') {
  // Tu etwas, was ggf. den Wert der Variablen ergebnis verändert.
}
```

Auch hier bietet es sich in der Regel an, eine Zählvariable zu nutzen, um 
Endlosschleifen dann wenigstens irgendwann abzubrechen.

```
var ergebnis = 'noch nicht';
var zaehler = 0;
while (ergebnis == 'noch nicht' && zaehler < 10000) {
  // Tu etwas, was ggf. den Wert der Variablen ergebnis verändert.
  zaehler++;
}
```

###### do-while-Schleife / Fußgesteuerte Schleife

do-while ist ähnlich aufgebaut. Der Unterschied ist nur, dass der Schleifeninhalt 
zumindest einmal durchlaufen wird, weil die Fortführungsbedingung erst am Ende 
der Schleife geprüft wird.

```
var ergebnis = 'noch nicht';
do {
  // Tu etwas, was ggf. den Wert der Variablen ergebnis verändert
} while (ergebnis == 'noch nicht');
```

#### Kontrollbefehle

In den meisten Sprachen gibt es darüber hinaus die Möglichkeit, aus der Schleife 
heraus das weitere Verhalten der Schleife zu beeinflussen, insbesondere:
- die Anweisung `break;`, ausgelöst irgendwo in der Schleife, führt dazu, dass 
die Schleife abgebrochen wird.
  ```
  for (var x = 0; x < 1000; x++) {
    if (bedingungFuerVorzeitigenAusstiegLiegtVor) {
      break;
    }
  }
  ```
  Diese Schleife stoppt schon vor Ablauf der 1.000 Durchläufe, wenn die 
  Ausstiegsbedingung vorliegt.
- die Anweisung `continue;`, ausgelöst irgendwo in der Schleife, führt dazu, dass 
der Rest des Schleifenkörpers übersprungen wird, dann aber weiter gemacht wird 
mit der Schleife. Angenommen wir wollen jede durch 3 glatt teilbare Zahl überspringen:
  ```
  for (var x = 0; x < 1000; x++) {
    if (x % 3 == 0) {
      continue;
    }
    // Tue Sachen mit x, die NICHT durch 3 teilbar sind
  }
  ```

