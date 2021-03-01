<table>
  <tr>
    <td colspan="2">
      <h2>Wichtiger Hinweis</h2>
        Es ist unbedingt empfohlen, immer nebenher mit den Programmiersprachen zu spielen. Und da es oft ein wenig umständlich ist, 
        für alles ein VSCode-Projekt aufzusetzen, empfehle ich wärmstens die folgenden Tools:<br/><br/>
    </td>
  </tr>
  <tr>
    <td>
      <strong>Sprache</strong>
    </td>
    <td>
      <strong>Tool</strong>
    </td>
  </tr>
  <tr>
    <td>
      Dart
    </td>
    <td>
      <a href="https://dartpad.dev/">Dartpad</a>
    </td>
  </tr>
  <tr>
    <td>
      Javascript & HTML & CSS
    </td>
    <td>
      <a href="https://jsfiddle.net/">Fiddle</a>
    </td>
  </tr>
</table>

### Sequenz
Programmiert wird von oben nach unten. Das heißt: Im Prinzip wird eine Zeile 
vom Computer abgearbeitet und danach ist die nächste Zeile dran.

### Berechnungen
Computer lieben Berechnungen. Es gibt die normalen Rechenoperationen wie 
mal, geteilt, plus, minus und hoch. Hinzu kommen Operationen wie ganzzahlige 
Division, das Ausrechnen des Rests einer ganzzahligen Division. Zudem gibt es 
zu jeder Sprache Mathematik-Libraries, die man einbinden kann, um dann damit 
auch Logarithmen oder statistische Berechnungen anstellen zu können.

Eine Sonderstellungen haben boolsche Rechenoperationen, also Berechnungen, bei 
denen entweder true oder false das Ergebnis ist. Dafür dienen Operatoren wie:
  - Vergleiche mit `<`, `>`, `==`, `<=`, `!=`
  - Kombination mehrerer boolescher Bedingungen durch 
    - Oder: In der Regel als `||` ausgedrückt.
    - Und: In der Regel als `&&` ausgedrückt;


### Variablen
In allen Programmiersprachen ist es möglich und üblich, Werte in Variablen zu 
speichern. Diese Variablen unterscheiden sich in Name, Typ , Gültigkeitsbereich (Scope)
und Inhalt.

#### Variablen: Namen
In manchen Sprachen ist man gezwungen, bestimmte Regeln bei der Benennung einzuhalten, 
aber selbst wenn nicht, dann sind folgende Regeln ein guter Startpunkt:
- Variablennamen in Kleinbuchstaben, ggf. Wortzusammensetzungen mit Großbuchstaben 
strukturieren, also zum Beispiel `meinNeuesSpielzeug`.
- Variablennamen sollten aussagekräftig sein. Es ist blöd, wenn man nicht auf 
Anhieb sieht, was eine Variable enthält und dann im Code zurück muss bis zu 
der Stelle, wo die Variable gefüllt wurde, um sich herzuleiten, was später im 
Code von ihr zu erwarten ist.
- Desto länger eine Variable eine Rolle spielt, desto länger und aussagekräftiger 
sollte der Name sein. Desto kurzlebiger und generischer eine Variable ist, desto 
kürzer und generischer darf der Name sein. Wenn also beispielsweise in einer 
Schleife lediglich eine Zählvariable (wir sind in Durchgang 1298329) notwendig ist, 
dann kann das ruhig ein Name wie x oder i sein.
- Verändert den Zweck einer Variablen nicht. Also nicht eine Variable definieren 
und dann in jeder nächsten Zeile den Wert der Variablen verändern. Lieber eine 
zweite Variable definieren und eine dritte und so weiter. Siehe oben: Es ist 
mühsam, sich dann wieder herzuleiten, was gegenwärtig in der Variable gepeichert ist.

###### Variablen: Typ
Grundsätzlich unterscheiden die meisten Programmiersprachen zwischen den 
eingebauten "primitiven" Variablentypen (primitives) und Objekten. Und die 
Programmiersprachen selbst unterscheiden sich dahingehend, ob sie verlangen, dass 
man den Typ der Variablen einmal festlegt (und dann nie wieder ändert), oder 
ob der Typ dynamisch vom Programm zur Laufzeit festgelegt wird (und sich auch 
ändern kann).
- Javscript hat keine festen Typfestlegungen. Jede Variable ist prinzipiell vom 
Typ `any`. Durch die Zuweisung von Werten legt sich der Typ dann fest, kann sich 
aber in der nächsten Zeile wieder ändern, je nach Operation, die man ausführt. 
Wenn eine Variable nur definiert wird (mit den Schlüsselworten let oder var, siehe 
später), dann hat sie den Wert `undefined`, bis ihr ein Wert zugewiesen wird.
- Dart hat feste Typfestlegungen, auch wenn uns die IDE manchmal erwähnt, dass wir 
die Typbezeichnungen durch das generische `var` ersetzen sollen. Das geschieht 
aber nur dann, wenn zusammen mit der Definiton auch ein Wert übergeben wird. Aus 
`String variable = 'Hallo';` wird dann `var variable = 'Hallo';`, weil Dart aus 
dem 'Hallo' schon erkennt, dass es sich um eine String-Variable handelt und daher 
die Information 'String' nicht benötigt. Das ändert aber nichts daran, dass diese 
Variable nun den Typ String hat und diesen auch nicht ändern kann.
Für Dart gilt zusätzlich, dass unterschieden wird zwischen einer Variablen, die 
theoretisch den Wert `null` enthalten darf und solchen, die das nicht dürfen. 
Dieses Feature "null safety" werde ich an anderer Stelle ausführlich darstellen.

###### Variablen: Typ: Primitives
Die meisten Programmiersprachen haben bestimmte eingebaute, primitive 
Variablentypen wie:
- `bool (manchmal boolean)`: Ein Wahrheitswert (true oder false), der letztlich nur 
zwei Zustände kennt.
- `int (manchmal integer)`: Eine Ganzzahl in einem bestimmten Zahlenbereich. Manche Programmiersprachen 
haben noch weitere Ganzzahl-Kürzel, bei denen jeweils mehr Bits für die Speicherung 
der Ganzzahl zur Verfügung stehen, also höhere Zahlen gespeichert werden können 
(typischer Name `long`). Dart unterscheidet da nicht. Ganzzahlen sind immer `int`. 
- `double` (manchmal auch `float`): Eine Fließkommazahl. Auch hier mag es mehr 
Unterscheidungen in anderen Sprachen geben. In Dart ist jede Fließkommazahl `double`.
- `String`: Eine Zeichenkette.

###### Variablen: Typ: Objekte und Collections / Arrays
Darüber hinaus gibt es meistens weitere Variablentypen:
- Arrays: Das heißt, dass in einer Variable nicht ein Wert, sondern eine ganze 
Reihe von Werten gespeichert werden. Die einzelnen Elemente der Variable lassen 
sich dann zumeist ansprechen mit `variablenname[i]`, wobei i für die Position 
des Elements in der Liste steht. Die meisten Sprachen nummerieren dafür von 0 
ausgehend. In Dart heißt der Variablentyp `List`. Das kann man weiter eingrenzen, 
also beispielsweise ist `List<int>` eine Liste von `int`-Werten.
  - Beispiele aus JS:
    ```
    var fruits = ['Apple', 'Banana', 'Organge'];
    console.log(fruits[1]); // Ausgabe: Banana
    ```
  - Beispiel aus Dart:
    ```
    var fruits = ['Apple', 'Banana', 'Orange'];
    log(fruits[1]); // Ausgabe Banana
    ```
- Assoziative Arrays: Das sind Arrays wie oben, nur dass die einzelnen Elemente 
auch jeweils einen Key (String) haben, über den man sie ansprechen kann. In Dart 
heißt der entsprechende Variablentyp Map.
  - Beispiel aus JS:
    ```
    var cars = {
        'Mercedes': 'S-Klasse',
        'BMW': '7er';
        'VW': 'Golf'
    }
    console.log(cars['VW']); // Ausgabe: Golf
    ```
  - Beispiel aus Dart:
    ```
    var cars = {
        'Mercedes': 'S-Klasse',
        'BMW': '7er';
        'VW': 'Golf'
    }
    log(cars['VW']); // Ausgabe: Golf
    ```
- Enums: Die meisten Sprachen haben ein Konstrukt namens Enum. Diese haben zur 
Folge, dass eine Variable nur bestimmte Werte enthalten darf, die zuvor 
festgelegt wurden und wenn man diese Werte im Klartext im Code sehen will. 
  - Beispiel aus Dart (in JS auch möglich, aber umständlicher und ein bisserl 
  witzlos, da die Variable mit jeder Zuweisung den Typ wieder ändern kann):
    ```
    Enum UserStatus {
        unregistriert,
        registriert,
        anonym,
    }

    /// und irgendwo im Code dann ....
    if (status == UserStatus.registriert) {
        // Sachen, die nur bei registrierten Usern passieren
    }
    ```
- Andere Objekte: Wir werden uns damit noch im Detail befassen, aber alles mögliche 
kann ein Objekt sein. Ein Schüler in der Schulverwaltung, ein Auto in der Fabrik, 
ein Tetris-Block im entsprechenden Spiel. Und jedes Objekt kann in einer Variablen 
gespeichert werden.
Wichtig ist, dass in den meisten Fällen eine Variable nicht wirklich den Inhalt 
des Objektes in einer Variablen speichert, sondern vielmehr eine Referenz auf 
dieses Objekt. Lasst folgendes Beispiel auf Euch wirken:
```
var x = Person('hoefer', 'andreas'); // wir gehen davon aus, dass es ein entsprechendes Objekt gibt.
var y = x;
x.nachname = 'meier';
log(y.nachname); // Resultat 'meier'
```
Was dieses Beispiel zeigen soll: In x und y werden jeweils nur Verweise auf das 
Objekt gespeichert. Wenn wir dann eine Eigenschaft von x ändern, dann ändern wir 
das zugeordnete Objekt.

###### Variablen: Typ: Unfestgelegte Variablen und Type-Checks
In den meisten Programmiersprachen gibt es darüber hinaus einen Variablentyp, 
der alle anderen Variablentypen speichern kann. In Javscript ist quasi jede 
Variable von diesem Typ. Das ergibt sich daraus, dass Javascript keine Typen 
festlegt.

In Dart gibt es hierfür den Variablentyp `dyanmic`. Er kann verwendet werden, 
um einen Inhalt zu speichern, von dem wir nicht genau wissen, was der Inhalt 
sein wird. Wir verlieren allerdings alle Vorteile, die ein strenges Typsystem 
eigentlich mit sich bringt: Unsere IDE weiß nicht, welchen Variablentyp wir 
vorliegen haben und kann uns nicht dabei helfen. Wenn wir beispielsweise 
Datumsfunktionen auf den dynamischen Inhalt anwenden, dann weiß sie nicht, ob 
das erlaubt ist oder nicht. Wir werden folglich mehr Fehler zur Laufzeit des 
Programms bekommen, statt schon vorher im Editor.

Da es den dynamischen Datentyp gibt, muss es auch Möglichkeiten geben, den Typ 
dynamisch auszulesen. In Dart geschieht das über das Keyword `is`, wie in 
folgendem Beispiel:

```
void meineFunktion(dynamic meinArgument) {
  if (meinArgument is String) {
    // Reagieren auf String
  } else if (meinArgument is int) {
    // Reagieren auf int
  }
}
```

In Javascript kann man Type-Checks über `typeof` realisieren. Dieser Befehl 
gibt einen String zurück mit dem Namen des Variablentyps, den die Variable 
zur Laufzeit des Programms gerade hat.

```
var a = 42;
console.log(typeof a); // expected output: "number"
a = 'blubber';
console.log(typeof a); // expected output: "string"
a = true;
console.log(typeof a); // expected output: "boolean"
console.log(typeof undeclaredVariable); // expected output: "undefined"
```

#### Variablen: Scope
Eine Variable hat einen festgelegten Gültigkeitsbereich. Das heißt, dass die 
Zuordnung von Variablenname zu Variableninhalt, einmal im Programm irgendwo 
definiert, irgendwann auch wieder endet.
```
var x = 5;
if (x < 10) {
    var y = 3;
}
log(y); // Produziert Fehlermeldung, da y nicht definiert ist
```
Mit anderen Worten: Die Definition von y ist nur innerhalb des lokalen Kontext 
gültig. Der lokale Kontext wird sozusagen durch die nächstgelegenen geschweiften 
Klammern definiert. Dieses Verhalten in Dart entspricht dem Verhalten von `let` in 
Javascript. Definiert man hingegen seine Variable mit `var` in Javascript, dann 
gibt obiger Code keinen Fehler aus, da die Gültigkeit dann immer zumindest 
für die ganze Funktion gegeben ist.

#### Variablen: Inhalt
In der Variablen drin ist, was Ihr hinein speichert. Wenn ihr nichts hinein speichert, 
dann haben die Variablen erstmal einen Fehlerinhalt (`null` bzw `undefined`), bis 
Ihr sie mit Werten füllt.

Die Zuweisung eines Wertes zu einer Variablen erfolgt in der Regel per `=`. Die 
Variable steht auf der linken Seite und auf der rechten Seite des `=` steht der 
Inhalt, der in die Variable gestellt wird.

