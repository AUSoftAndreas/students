## Referenzen zu Funktionen

Nachdem wir prinzipiell wissen, was Funktionen sind, können wir uns noch 
mit einigen fortgeschrittenen Konzepten beschäftigen. Diese Konzepte sind 
komplex und es ist ehrlich gesagt vollkommen egal, wenn sie einen im Moment 
noch etwas überfordern.

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
Bibliotheken, wo die Programmierer natürlich nicht wissen




Wenn ein Projekt etlichen Code umfasst, dann muss dem Computer klar sein, wo 
er mit dem Ausführen eines Programms anfangen soll. In vielen Programmiersprachen 
ist das die sogenannte main-Funktion.
- In einer Dart-Anwendung ist dem so.
  ```
  void eineFunktion() {
    // Etwas passiert
  }

  void main() {
    // Hier wird das Programm starten
  }

  void andereFunktion() {
    // Etwas passiert
  }
  ```
  - Eine main-Funktion (in unseren Apps wird diese sich auch in lib/main.dart befinden) 
  muss nicht zwingend viel tun. In einer typischen App sorgt sie für die Initialisierung 
  einiger Variablen und öffnet den ersten Screen.
- In Javascript ist das etwas anders: Der Code, der eingebunden wird in eine HTML-Seite, 
egal ob als externe Datei oder einfach in einem `<script>`-Tag, läuft automatisch ab, 
wenn er nicht in Funktionen verpackt ist. Daher wird auf diesem Level, also unverpackt 
in Funktionen in der Regel lediglich festgelegt, dass anderer Code zum Beispiel laufen 
soll, wenn die HTML-Seite vollständig geladen ist.

## Funktionen

In allen mir bekannten Programmiersprachen kann man Funktionen definieren. Funktionen 
sind einfach Code-Sequenzen, die ausgelagert sind aus dem Hauptprogramm und die 
entweder vom Hauptprogramm oder von anderen Funktionen aufgerufen werden.

#### Rückgabewerte

Funktionen können entweder einfach etwas tun - oder sie produzieren einen Rückgabewert, 
den die aufrufende Codestelle dann weiter verwenden kann. Beide Konzepte gehen Hand in 
Hand, also es könnte beispielsweise auch sein, dass eine Funktion in erster Linie etwas 
tut und dann zum Beispiel per Rückgabewert meldet, dass sie erfolgreich tat, was sie 
tat. Wenn man einen Rückgabewert von einer Funktion erwartet, dann verfährt man beim 
Aufruf so, als wäre die Funktion eine Variable. Man kann sie einer anderen Variable 
zuweisen oder direkt auswerten. Der Rückgabewert wird in der Regel per `return` zurück
an die aufrufende Codestelle gegeben. Die Anweisung `return` beendet sofort den Code 
der Funktion!

###### Rückgabewert-Typ: Definition vorab

In den meisten Sprachen muss ich den Rückgabewert der Funktion bei der Funktionsdefinition 
bereits festlegen. Der Rückgabewert muss in der Regel einem der Variablentypen, 
die in der Programmiersprache angeboten werden, entsprechen. Wenn kein Rückgabewert 
von der Funktion zurück gegeben wird, dann wird als Rückgabetyp in der Regel als 
void angegeben. Typische Funktionsdefinitonen sehen daher so aus:

```
int gibZahl() {
  return 13;
}

bool gibBool() {
  return true;
}

String gibString() {
  return "Hallo";
}

void tuWas() {
  return; // beendet dann einfach den Code der Funktion
}
```
Da Javascript bei Variablentypen so flexibel ist, ist das hier nicht nötig. Man 
ersetze einfach alle Variablentypen in dem obigen Codeabschnitt durch `function` 
und es funktioniert dann auch dort.

#### Funktionsargumente

Manche (die meisten) Funktionen werden durch Argumente so flexibel gehalten, dass 
sie in verschiedenen Zusammenhängen genutzt werden können. Nehmen wir uns eine 
sehr simple Funktion vor, die 1 und 2 addiert und das Ergebnis 3 zurück gibt an 
die aufrufende Stelle.

```
void main() {
  var x = addiere1Und2(); // Funktionsaufruf
  var y = addiere3Und4(); 
  log(x); // gibt 3 aus
  log(y); // gibt 7 aus
}

int addiere1Und2() {
  return 1 + 2; // ergibt 3 als Rückgabewert
}

int addiere3Und4() {
  return 3 + 4;
}
```

Durch Argumente werden wir flexibel:

```
void main() {
  var x = addiere(1,2); // Funktionsaufruf
  var y = addiere(3,4); 
  log(x); // gibt 3 aus
  log(y); // gibt 7 aus
}

int addiere(int zahlX, int zahlY) {
  return zahlX + zahlY; // ergibt einfach die Summe als Rückgabewert
}
```

In den meisten Sprachen müssen wir die Typen der Argumente, wie bei jeder 
Variablen festlegen. Ausgenommen ist wieder Javascript mit seinen flexiblen 
Variablentypen. Dort lässt man dann die Variablentypen weg. Das hat dann 
den Nachteil, dass niemand meckert, wenn man aus Versehen einen String in die 
Funktion gibt. Im Gegenteil:

```
  // Irgendwo im Code
  var x = addiere(1,2); // Funktionsaufruf
  var y = addiere('Hallo','Welt'); 
  console.log(x); // gibt 3 aus
  comsole.log(y); // gibt 'HalloWelt' aus
}

function addiere(zahlX, zahlY) {
  return zahlX + zahlY; // ergibt einfach die Summe als Rückgabewert
}
```

Der typische Aufruf einer void-Funktion, die also keinen Rückgabewert produziert, 
ist auch mehr oder weniger selbsterlklärend:

```
void main() {
  eineVoidFunktion(); // Lässt die Funktion durchlaufen
  // und weiter geht's
}

void eineVoidFunktion() {
  // Tu etwas
}
```

Natürlich kann auch eine void-Funktion Argumente haben.

```
void main() {
  eineVoidFunktion('Text'); // Lässt die Funktion durchlaufen, gibt 'Text' aus
  // und weiter geht's
}

void eineVoidFunktion(String text) {
  log(text);
}
```

###### Optionale Argumente

Nicht in jedem Fall muss die aufrufende Codestelle jedes Argument wir gewünscht an 
die Funktion übergeben.
- In Javascript gibt es im Prinzip keinerlei Prüfung. Man kann die Funktion aufrufen, 
wie man lustig ist und alle Argumente, welche die Funktion eigentlich fordert, 
ignorieren. Bei der Funktion kommen dann halt einige `undefined` Variablen an, 
was zum Crash führen kann. Wie immer ist Javscript da relativ lax.
- In den meisten Programmiersprachen, inklusive Dart, gibt es fein abgestimmte Regeln 
dafür, welche Funktionsargumente man weglassen kann und welche nicht. Die IDE 
warnt einen dann, wenn der eigene Funktionsaufruf nicht zur Funktionsdefinition 
passt. Beispiele für solche Feinbestimmungen:
  ```
  void meineFunktion(int a, int b) {}
  // Zugehöriger Funktionsaufruf
  meineFunktion(3, 4);
  // Der Funktionsaufruf muss ZWINGEND zwei Ganzzahlen übergeben.
  ```
  ```
  void meineFunktion(int a, [int b, int c]) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1);
  meineFunktion(1,2);
  meineFunktion(1,2,3);
  // Der Funktionsaufruf muss ZWINGEND eine Ganzzahl beinhalten und bis zu drei
  ```
  ```
  void meineFunktion(int a, [int b = 2, int c = 3]) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1);
  meineFunktion(1,2);
  meineFunktion(1,2,3);
  // Der Funktionsaufruf muss ZWINGEND eine Ganzzahl beinhalten und bis zu drei.
  // b und c werden, wenn nichts anderes übergeben wird, automatisch auf 2 und 
  // 3 gesetzt. Also: Alle drei Funktionsaufrufe haben die gleiche Wirkung.
  ```
  ```
  void meineFunktion(int a, {int b, int c}) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1);
  meineFunktion(1, b: 2);
  meineFunktion(1, c: 3);
  meineFunktion(1, b: 2, c: 3);
  // Der Funktionsaufruf muss ZWINGEND eine Ganzzahl beinhalten und bis zu zwei
  // **benannte** Parameter. Neu ist, dass die Reihenfolge egal ist. Es ist also 
  // jetzt möglich, c zu übergeben und b nicht.
  ```
  ```
  void meineFunktion(int a, {int b = 2, int c = 3}) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1);
  meineFunktion(1, b: 2);
  meineFunktion(1, c: 3);
  meineFunktion(1, b: 2, c: 3);
  // Wie zuvor, nur dass ebenfalls Standardwerte angegeben sind, mit denen die 
  // Funktion arbeitet, wenn kein anderer Wert übergeben wurde. Insofern haben 
  // alle Funktionsaufrufe die gleiche Wirkung.
  ```
  ```
  void meineFunktion(int a, {required int b, int c = 3}) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1, b: 2);
  meineFunktion(1, b: 2, c: 3);
  // Diesmal ist das benannte Argument b als required (benötigt) gekennzeichnet. 
  // Ein Funktionsaufruf, bei dem b nicht explizit erähnt wurde, ist also unzulässig.
  ```

Mit dieser Vielzahl an Regeln kann man eigentlich für jede Konstellation vorsorgen.

###### Overloading

Manche Sprachen setzen zudem eine Technik ein, die sich function overloading nennt. 
Im Endeffekt läuft es daraufhin hinaus, dass man mehrere Funktionen des gleichen 
Namens definieren kann. Anhand der Anzahl und Variablentypen müssen sich die 
verschiedenen Funktionen aber unterscheiden. Wenn man nun die Funktion aufruft, 
dann hat man die Wahl zwischen den verschiedenen Varianten, bzw. es wird automatisch 
die Funktions-Implementierung gewählt, die zu der Anzahl und Art der übergebenen 
Argumente passt.

Im Bereich der Funktionen ist dieses Prinzip nicht sonderlich verbreitet, hat 
aber eine relativ große Popularität im Bereich der Klassen-Konstruktoren, zu denen 
wir noch kommen werden.

Sowohl Javascript als auch Dart unterstützen Overloading bei Funktionen nicht. 
Allerdings ist durch die benamten Argumente insbesondere in Dart, und im Prinzip 
auch durch die sehr freien optionalen Parameter mit Standardwerten in Javascript 
es sehr wohl möglich, Funktionen zu schreiben, die mit sehr unterschiedlichen 
Argumenten zurecht kommen.

Eine Dart-Funtkion beispielsweise, die entweder mit einem Text oder einer Zahl 
zurechtkommen soll, könnte beispielsweise folgendermaßen aussehen:

```
void meineFunktion({String? textArgument, int? zahlArgument}){
  if (textArgument != null) {
    // Das tun, was bei TextArgumenten passiert
  } else if (zahlArgument != null) {
    // Das tun, was bei ZahlArgumenten passiert
  }
}

// In dem Fall hat das TextArgument Vorrang+
```

Alternativ könnte man den Variablentyp dynamic verwenden, also den Datentyp 
eigentlich nicht festlegen und dann darauf reagieren:

```
void meineFunktion(dynamic meinArgument) {
  if (meinArgument is String) {
    // Das tun, was bei TextArgumenten passiert
  } else if (meinArgument is int) {
    // Das tun, was bei ZahlArgumenten passiert
  }
}
```
