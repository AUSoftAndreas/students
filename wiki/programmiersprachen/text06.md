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

## Fortgeschrittene Funktionalitäten

*Nachdem wir prinzipiell wissen, was Funktionen sind, können wir uns noch 
mit einigen fortgeschrittenen Konzepten beschäftigen. Diese Konzepte sind 
komplex und es ist ehrlich gesagt vollkommen egal, wenn sie einen im Moment 
noch etwas überfordern.*

Funktionen werden im Code irgendwo definiert und an anderen Stellen aufgerufen. 
Es ist aber auch möglich, den Verweis zu Funktionen herum zu reichen, zumindest 
in Sprachen, in denen sich Funktionen in Variablen speichern lassen.

```
function meineFunktion() {
  // tue ewas
}

var a = meineFunktion;

a();
```

Man beachte, dass keine Klammern hinter dem Namen der Funktion stehen. Würden 
Klammern da stehen, dann würde die Funktion ausgeführt und ihr eventueller 
Rückgabewert würde in a gespeichert. Das haben wir schon getan und das ist 
Standardverhalten. Da wir keine Klammern mitgegeben haben, wird die Funktion 
nicht ausgeführt, sondern ihr Inhalt wird einfach gespeichert, sozusagen der 
Code der Funktion. Am Ende des Beispiels wird die Variable (und damit die darin 
gespeicherte Funktion) ausgeführt.

#### Anonyme Funktionen, Closures

Wenn ich den Inhalt der Funktion sowieso in einer Variablen speichern will, dann 
brauch ich der Funktion erst gar nicht einen Namen geben. Stattdessen gibt es 
eine anonyme Notation.
```
var a = () {
  // Inhalt der anonymen Funktion
};
```

#### Wozu ist das gut?
Eine wesentliche Auswirkung dieses Konzepts ist, dass man Funktionen sehr 
allgemein schreiben kann. Nehmen wir an, dass Ihr eine aufwendige Operation 
durchführen müsst und dann soll etwas anderes geschehen. Dieses "andere" ist 
noch nicht festgelegt. Ihr könnt dieses "Danach" dann verschiedenen Stellen 
anders festlegen.

Ich gebe hier keine Beispiele mehr an. Das ist sicherlich im Moment zu fortgeschritten. 
Es ist aber okay, wenn man zumindest im Hinterkopf gibt, dass sowas geht. 
Übrigens ist es nicht soooo wahrscheinlich, dass man als "normaler" Anwendungsprogrammierer 
Funktionen dieser Art entwirft. Es ist aber recht wahrscheinlich, dass man es 
anwenden muss. Das hauptsächliche Einsatzgebiet sind nämlich allgemeine 
Bibliotheken, wo die Programmierer natürlich nicht wissen, wofür ihr Code später 
eingesetzt wird.

## Asynchrone Operationen

Normalerweise läuft Code sozusagen Zeile für Zeile ab. Wenn die Abarbeitung einer 
Zeile länger dauert, dann dauert es halt länger, bis mit der nächsten Zeile weiter 
gemacht wird. Es gibt aber auch Operationen, die verlaufen bewusst asynchron. 
Das heißt, dass der Code weiter läuft und das Ergebnis später nachgereicht wird.

Für den Zweck gibt es in Dart eine Reihe von Features. Die wichtigsten Stichworte 
lauten Future, async, await und unawait.

#### Future

Ein Future ist ein weiterer Variablentyp. Er ist ein Versprechen auf einen 
zukünftigen Variablenwert. Beispielsweise ist ein `Future<String>` eine 
Variable, die erstmal leer / fehlerhaft ist, aber aus der später ein 
String werden wird. Sehen wir uns ein Beispiel an:

```
// This example shows how *not* to write asynchronous Dart code.
Future<String> fetchUserOrder() =>
    Future.delayed(
      Duration(seconds: 2),
      () => 'Large Latte',
    );

void main() {
  var order = fetchUserOrder();
  print('Your order is: $order');
}
```

Die Funktion fetchUserOrder() returnt einen Future<String>-Wert. Das tut sie, indem sie 
2 Sekunden verstreichen lässt und dann den String mit dem Inhalt 'Large Latte' 
ausgibt. Man beachte, dass dadurch, dass man das, was da nach einer Verzögerung 
passieren soll, mit einer anonymen Funktion angibt, was heißt, dass man auch 
jeden anderen Code dadurch verzögert ausführen kann, also zum Beispiel auch etwas 
tun, statt nur einen Wert zu produzieren.

*Das ist übrigens ein typisches Anwendungsbeispiel für anonyme Funktionen, sogenannte 
Callbacks nach asynchronen Operationen. Im Kern geht es darum, dass man dem Programm sagt 
"mach mal das, solange es halt dauert, ich mach derweil weiter in meinem 
Hauptprogramm ... Ach, und wenn Du fertig bist, dann mach bitte das.". Aber das nur 
als Anmerkung.*

Wenn wir das Programm ausführen, ist das die Ausgabe:
`Your order is: Instance of '_Future<String>'`

Was passiert? Unser Programm erreicht die Zeile fetchUserOrder und nimmt daraus 
den Rückgabewert, was eben ein *Versprechen auf einen zukünftigen String* ist. 
Es ist kein String. Und daher erhalten wir auch keine vernüftige Ausgabe, weil 
zu dem Zeitpunkt, an dem wir 'Your order is:' ausgeben, es noch gar keinen String 
gibt, der dahinter geschrieben werden kann. Dieser String wird ja erst in zwei 
Sekunden existieren!

Also, wie kommt man zu dem gewünschten Ergebnis? Es gibt mehrere Methoden:

- Wir können auch die Bildschirmausgabe direkt aus dem Callback, also dann eben 
mit zweisekündiger Verpätung heraus initiieren:
    ```
    Future<void> fetchUserOrder() {
        Future.delayed(
            Duration(seconds: 2),
            () {
                print('Your oder is: Large Latte');
            }
        );
    }

    void main() {
        fetchUserOrder();
        print('Your order was received');
    }
    ```
    Was passiert? Wir rufen die Funktion fetchUserOrder auf und geben sofort 
    "Your order was received" aus. Erst zwei Sekunden später wird zusätzlich 
    "Your order was: Large Latte" ausgegeben. Der Return-Typ der Funktion hat sich 
    geändert auf Future<void>, weil wir keinen String mehr ausgeben, sondern nur 
    etwas tun.
- Alternativ könnte man diese Art der verzögerten Ausgabe auch direkt in unserer 
    void main() ablaufen lassen.
    ```
    Future<String> fetchUserOrder() =>
        Future.delayed(
        Duration(seconds: 2),
        () => 'Large Latte',
        );

    void main() {
    var order = fetchUserOrder().then((o) {
        print('Your order is: $o');
    });
    print('Your order was received');
    }
    ```
    Auch hier ist der Ablauf interessant: Wir erhalten folgende Ausgabe:
    ```
    Your order was received (Instance of '_Future<Null>')
    Your order is: Large Latte   
    ```
    In der main() beziehen wir de Wert von fetchUserOrder(). Dieser ist ein 
    Future, also nur ein zukünftiger Wert. Wir registrieren einen Callback auf 
    der Variablen. Das heißt, dass, sobald hier ein echter Wert vorliegt, diese 
    Funktion abläuft. Im Code geht es dann aber weiter und wir geben zuerst aus, 
    dass "Your order was received". Erst dann, wenn 2 Sekunden später, order 
    tatsächlich einen Wert hat, werden die Details ausgegeben.
- Und der üblichste Weg zum Schluss. Man markiert die gesamte Funktion als 
asynchron und wartet mit der Programmausführung, bis der wirkliche Wert vorliegt. 
Diese Variante ist für Anfänger am leichtesten nachzuvollziehen.
    ```
    Future<String> fetchUserOrder() =>
        Future.delayed(
        Duration(seconds: 2),
        () => 'Large Latte',
        );

    void main() async {
      var order = await fetchUserOrder();
      print('Your order was received ($order)');
    }
    ```
    Wir sind gezwungen, die main als "async" zu kennzeichnen, um den Befehl 
    await nutzen zu können. Durch await wartet unsere Funktion, bis ein echter 
    Wert vorliegt und dann setzt sie ihre Operationen fort.




