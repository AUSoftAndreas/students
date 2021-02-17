*Vorweg sei gesagt, dass ich lange mit der Form gerungen habe, in der ich mich 
mit objektorientierter Programmierung (OOP) auseinandersetzen will. Am Liebsten 
wäre mir eine Präsentation gewesen, aber im Endeffekt fand ich bei einer 
Präsentation, die ich persönlich halte, das Ganze noch irgendwie erträglich, aber 
wenn ich mit der Wahrscheinlichkeit rechnen muss, dass ich es nicht selbst halte, 
sondern dass es von Teilnehmern nur gelesen wird, dann ist ein Präsentation 
einfach zu wenig Text. Hinzu kommt, dass dieses Wiki-Format mich sehr schön 
Links einbauen lässt, und wer klickt in einer Powerpoint auf einen Link?*

## Prozedural, funktional, imperativ, etc.

Grundsätzlich sei gesagt, dass die meisten Unterscheidungen (siehe diese Überschrift) 
eigentlich in der Praxis nicht so relevant sind bzw. die Unterschiede relativ fließend 
sind. Objektorientierung ist aber tatsächlich ein eigener Ansatz der Prgrammierung, 
der sich aus der zunehmenden Komplexität ergab, die Softwareprogramme haben. 
Beispielsweise landete 1969 Apollo 11 auf dem Mond und der Code auf dem 
Bordcomputer umfasste 145.000 Codezeilen. Windows hat heutzutage etwa 50 
Millionen Codezeilen.

Bleiben wir bei diesen Beispielen: Wenn ein Codeprojekt 10 Millionen Zeilen hat 
und wir davon ausgehen, dass maximal 50 Zeilen eine Funktion ergeben, dann sind 
das 200.000 Funktionen. Potenziell könnte jede dieser Funktionen jede andere 
aufrufen und diese Komplexität ist dann absolut nicht mehr zu durchschauen. 
Schon die Auswahl, welche Funktion wir an einer Stelle aufrufen, wird 
schwer, und deswegen war eigentlich schnell klar, dass man Code aufgliedern muss 
in einzelne Bereiche / Module / etc. Folglich war dieses Aufgliedern auch schon 
relativ früh möglich. Bibliotheken, Module, etc. dienten dazu, den Code 
handhabbarer zu gestalten.

Hinzu kommt, dass Variablen herkömmlicher Bauart, also im Wesentlichen Zahlen 
und Strings, auch oft gruppiert vorkommen. Beispielsweise hat eine Person 
einen Vornamen und einen Nachnamen und eine Adresse. Will man dafür jetzt 
drei Variablen anlegen, dann kann es gut sein, dass man an irgendwelchen
Stellen Variablen vergisst zu setzen. Wenn man die Daten abspeichern will, dann 
sind das drei Elemente einer SQL-Anweisung (SQL ist die Sprache, mit der die 
meisten Datenbanken abgefragt werden oder in Datenbanken geschrieben wird).

Und wenn wir an Funktionalität denken, dann ist die auch oft mit Variablen 
verbunden. Beispielsweise gehen wir mal davon aus, dass in einem Verwaltungsprogramm 
jedes mal, wenn sich die Emailadresse einer Person ändert, diese Person eine 
Bestätigungsemail geschickt bekommt, um die neue Adresse zu verifizieren. Jetzt 
gibt es aber viele Stellen, wo sich die Emailadresse ändern kann:
- Die Person gibt auf dem Registrierungsseite der Homepage erstmals ihre 
Emailadresse an,
- die Person gibt auf der Homepage in ihrem Benutzerprofil eine neue Emailadresse ein,
- ein Sachbearbeiter ändert die Adresse in den Stammdaten der Person
- und wir gehen davon aus, dass die Stammdaten der Person sich an mehreren 
Stellen in der Verwaltungssoftware geändert werden können -
- und an jeder dieser Stellen müsste nun implementiert werden, dass die 
Emailbestätigungs-Routine angestoßen wird.

Da ist es doch viel schöner, wenn wir einmal an einer Stelle hinterlegen, dass 
jede Änderung der Daten hinsichtlich Emailadressen eine solche Bestätigungs-Email 
auslöst, und am besten wäre es, wenn diese Routine für immer direkt mit dem 
Ändern des Emailfeldes verbunden wäre, oder?

**Und diese und andere Probleme löst Objektorientierung.**

### Wo verwenden wir Objektorientierung?

Grundsätzlich ist OOP mehr eine Haltung als an bestimmte Sprachen gebunden, aber 
nach und nach haben viele Programmiersprachen es ermöglicht, zumindest Elemente 
der OOP in ihnen zu verwenden, sodass man zumindest sagen kann, dass es in den 
meisten gängigen Hochsprachen für den allgemeinen Gebrauch möglich ist, 
objektorientiert zu programmieren. Umgekehrt gibt es Sprachen, in denen man 
aufgrund ihrer Struktur gezwungen ist, zumindest bestimmte Grundsätze der OOP 
anzuwenden, auch wenn man dann bei der Ausführung alles "falsch" machen kann und 
dann wiederum nicht wirklich OOP betreibt. Daher wollen wir hier wirklich 
mehr über Grundsätze und Philosophie sprechen - und weniger über einzelne Sprachen. 
Meine Codebeispiele sind, wie so oft, in Dart gehalten, aber ich achte hin und 
wieder darauf, auch zu erwähnen, wenn etwas in anderen (mir bekannten) Sprachen 
komplett anders ist.

Ihr solltet aber wissen, wo sich so ungefähr wesentliche, wichtige Programmiersprachen 
hinsichtlich ihrer Objektorientierung verorten lassen und daher die folgende 
Liste ohne große Gewähr:

- C++
- C\#
- Delphi (Object Pascal)
- Dart
- Go (auch wenn hier wirklich vieles anders ist, als wir es hier besprechen)
- Java
- Kotlin
- Objective-C
- Python
- Ruby

## Was bedeutet nun Objektorientierung?

In erster Linie heißt es, dass sich die Programmierung um Objekte dreht, und 
diese Objekte beinhalten Code und Funktionalität. Es gibt (eher) keinen Code, 
der nicht in irgendeiner Weise einem Objekt zugeordnet ist.

Viele dieser Objekte haben realweltliche Entsprechungen. Beispielsweise würde 
eine Schulverwaltung wahrscheinlich Objekte enthalten wie:
- Schüler
- Klassen
- Lehrer
- Mitarbeiter
- Beamer und andere allgemeine Ressourcen
- Räume
- Bücher

Wenn man selbst sich Gedanken machen muss, wie man ein Programm konzeptioniert, 
dann ist ein guter Startpunkt, sich der tatsächlichen realweltlichen Objekte, 
die das eigene Programm beinhaltet, Gedanken zu machen.

Die Objekte können auch virtuell, aber im Kontext des Programms real sein. 
Beispielsweise würde ein klassisches Rollenspiel auf dem Computer wahrscheinlich 
Objekte enthalten wie
- Mitglieder der gesteuerten Gruppe
- Ggf. den Hauptcharakter (falls die Gruppe nicht gleichrangig ist)
- Items, die man finden kann (zum Beispiel ein Schwert)
- Monster
- Maps / Areas, die man betreten kann
- Nichtspieler-Charaktere, mit denen man reden kann.

Darüber hinaus mag man in der Umsetzung aus konzeptionellen Gründen weitere 
Objekte kreieren, die eher einen ergänzenden Charakter haben und nicht wirklich 
einem Gegenstand, einer Person oder dergleichen entsprechen. Mögliche Objekte 
dieser Bauart wären:
- Ein Dienst, mit dem wir Inhalte in eine Datenbank schreiben
- Ein Dienst, mit dem wir Google Maps nach Geodaten abfragen
- Ein Dienst, der eine Email versendet
- Generell eine Emailadresse
- Ein Termin bei einem Arzt

Manche dieser Dinge sind relativ real (Email, Termin), manche sind eher 
Konstrukte, um Code zu bündeln und zusammenzufassen, den man ansonsten an 
mehreren Stellen schreiben und pflegen müsste.

### Okay, es gibt diese Objekte - und nun?

Das Besondere ist, dass wir in diesen Objekten sämtliche Funktionalität und 
sämtliche Daten zusammenführen, die zu ihnen gehören und dass diese dann genau 
definieren, wie andere Objekte mit ihnen zusammenarbeiten können. Wir nennen 
das Kapselung. Das heißt, dass eine Klasse von außen nur über wohl überlegte 
Schnittstellen ansprechbar sein sollte. Kommen wir auf das Beispiel mit der 
Nutzer-Emailadresse zurück. Wo auch immer man die Emailadresse ändern möchte: 
Wenn das geschehen soll, dann muss von irgendwoher an unser Person-Objekt eine 
Nachricht gesendet werden, die quasi aussagt: *"Hey, ändere bitte die Emailadresse 
auf xxx@yy.zz"* und dann können wir festlegen, dass jede Änderung der Emailadresse 
einen erneuten Versand einer Bestätigungsemail auslöst. Da es keinen anderen 
Weg gibt, die Emailadresse zu ändern, können wir diesen Schritt an keiner Stelle 
im Code vergessen. Das Objekt sorgt dafür, dass die eigenen Daten okay sind und 
die notwendigen Prozesse ablaufen.

Objektorientierung heißt also, dass alle diese Objekte untereinander interagieren, 
indem sie Nachrichten austauschen.

Das Programm besteht aus unzähligen Objekten. Beispielsweise hat unsere 
Schulverwaltung nicht ein Objekt für Schüler, sondern potenziell ein Schüler-Objekt 
pro Schüler. Zwar ist die Funktionalität pro Schüler gleich, aber natürlich 
unterscheiden sich die Daten. Beispielsweise hat jeder Schüler einen anderen 
Namen.

Bei der Programmierung heißt das, dass wir nicht einzelne Objekte definieren 
(sonst dürfte nie ein Schüler dazukommen), sondern sogenannte **Klassen**. Klassen 
sind sozusagen Baupläne für Objekte. "Hans Meier", "Uschi Brennemann" und "Ali 
Hamoud" sind also allesamt Objekte, basierend auf der Klasse Schüler.

### Wie sieht eine Klasse aus?

Eine Klasse beinhaltet, wie ich bereits geschrieben habe, einerseits die Daten 
und andererseits die Funktionalität, die mit der entsprechenden Klasse zu tun 
haben.

#### Daten in einer Klasse bzw. einem Objekt

Genauer gesagt enthält die Klasse nicht die Daten, sondern vielmehr die 
Datendefinitonen, also welche Daten ein konkretes Objekt enthalten kann.

Wir definieren also in der Klasse Schüler, dass jeder Schüler einen Vornamen 
und einen Nachnamen hat. Das konkrete Objekt (oder man sagt auch die Instanz) 
im Programmverlauf ist dann beispielsweise "Susanne Strolch" und die hat eben 
den Vornamen "Susanne" und den Nachnamen "Strolch". Bei der Programmierung 
interessiert uns aber erstmal nur, dass sie einen Vornamen vom Typ String und 
einen Nachnamen, ebenfalls vom Typ String, hat.

Manche dieser Daten dienen uns (innerhalb der Klasse) zum Speichern von 
Informationen. Manche dieser Daten sollen von außen abgreifbar sein. Beispielsweise 
kann ein Formular in der Schulverwaltung eben definieren, dass es von einem 
Schüler den Nachnamen darstellen will. Und dazu muss unsere Klasse, deren 
konkreten Instanzen ja später alle Daten zu einem Schüler darstellen, diesen 
Nachnamen auch abgreifbar machen.

Andere Daten können vom Zugriff von außen verborgen sein. Beispielsweise könnte 
unsere Klasse (bzw. jedes Objekt) eine Liste bereits bestätigter Emailadressen 
verwalten, sodass wir keine erneute Bestätigungsemail versenden, wenn der User 
seine Emailadresse verändert hin zu einer Emailadresse, die wir schon bestätigt 
haben. Wir könnten beschließen, dass diese Emailadressen kein anderes Objekt 
etwas angehen.

Manche Daten wollen wir von außen lesbar, aber nicht veränderbar gestalten. 
So könnte die Anzahl gescheiterter Versuche, eine Bestätigungsemail zu erhalten, 
zwar auslesbar sein, damit das Sekretariat sagen kann "lieber Ahmad, wir haben 
jetzt schon dreimal eine Bestätigungsemail an Dich versendet, check mal Deinen 
Spamfilter", aber wieso sollte dieses Sekretariat die Anzahl der Versuche in 
irgendeiner Form verändern? Andere Daten mögen auch von außen beschreibbar sein, 
aber nicht auslesbar. Mir fällt hierfür gerade kein passendes Beispiel ein, aber 
Ihr versteht den Punkt auch so, nehme ich an.

**Wir können in einer Klasse festlegen, welche Daten wir zu jeder Instanz der 
Klasse, also jedem Objekt, speichern wollen und ob diese lesbar bzw. beschreibbar 
von anderen Klassen sind** (und mitunter gibt es da in der Sprache auch Abstufungen 
ala "lesbar von anderen Klassen des gleichen Moduls, aber nicht von Klassen 
außerhalb des Moduls).

#### Funktionalität in einer Klasse

Ebenso definieren wir in einer Klasse, welche Funktionalität sie bereitstellt. 
Das ist im Prinzip genauso wie mit den Funktionen, die wir schon in anderen 
Formen der Programmierung gesehen haben. Also können wir verkürzt sagen: Eine 
Klasse enthält Funktionen.

Manche dieser Funktionen dienen nur anderen Funktionen in der Klasse als Helfer. 
Manche dieser Funktionen sind aber dazu da, damit andere Objekte diese auslösen. 
Beispielsweise könnte unser Emailversand im Endeffekt aus mehreren Routinen 
bestehen, eine davon ist die Funktion, die letztlich ausgelöst wird, wenn sich 
die Emailadresse ändert. Es könnte aber sein, dass diese Funktion auch von außen 
ausführbar sein soll, wenn zum Beispiel ein Schüler, der keine Email bekommen hat, 
im Sekretariat sagt "Bitte schickt mir eine neue Email". Anstatt dann die Emailadresse 
zu ändern (was ja einen Versand auslösen würde), könnnte dann das Sekretariat 
einfach auf einen Button drücken und die Email geht erneut raus. Dazu musss unsere 
Klasse ihre Funktion "sendeEmail" nach außen zur Verfügung stellen. Die Methode aber, 
die bei einer Emailadresse prüft, ob sie schonmal registriert wurde, die kann 
vor der Außenwelt verborgen sein.

#### So weit so gut, was ist mit Code?

Ich schreibe jetzt den Code, wie er in Dart aussehen würde. Dart geht an einigen 
Stellen aber bewusst (und wie ich finde gute) Abkürzungen, die in anderen 
Sprachen anders geregelt sind. Ich schreibe deswegen im Nachgang auch, wenn eine Codezeile 
in typischeren OOP-Sprachen (insbesondere C# und Java) erheblich anders aussehen 
würde. Kleinere Abweichungen hingegen, weil mal ein Datentyp oder so anders heißt, 
lasse ich aber bewusst weg, denn solche Fehler zeigt dann jede IDE sofort an und das 
lässt sich mit einer Google-Suche auf jede Sprache anpassen. Außerdem lenken die 
Feinheiten hier nur ab.

~~~
class Student {
  // Ab hier: Datendefinitionen
  String nachname;
  String vorname;
  String _emailAdresse;
  List<String> _registrierteEmailAdressen;
  int _anzahlVersendeterRegistrierungsEmails = 0;
  bool _emailAdresseIstVerifiziert;

  // Getter und Setter
  String get emailAdresse => _emailAdresse;

  void set emailAdresse(String neueAdresse) {
    if (_istEmailAdresseValide(neueAdresse)) {
      String alteAdresse = _emailAdresse;
      if (_emailAdresseIstVerifiziert) {
        _registrierteEmailAdressen.add(alteAdresse);
      }
    _emailAdresse = neueAdresse;
    sendeVerifizierungsEmail();
    }
  }

  bool get emailAdresseIstVerifiziert => _emailAdresseIstVerifiziert;

  int anzahlVersendeterRegistrierungsEmails() => _anzahlVersendeterRegistrierungsEmails;

  bool _istEmailAdresseValide(String email) {
    // Prüflogik
    if (email.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  void sendeVerifizierungsEmail() {
    // Logik, mit der die Email versendet wird
    _anzahlVersendeterRegistrierungsEmails++;
  }
}
~~~

Und jetzt gehen wir den Code Schritt für Schritt durch:

`class Student {`<br/>
Der Name der Klasse wird definiert. Klassennamen sind in den meisten Sprachen 
groß geschrieben wird (Wortzusammensetzungen bedeuten, dass jede neue Wort, aber 
ohne Leerzeichen dazwischen, wieder groß geschrieben wird = Upper camel case).

`    String nachname;`<br/>
Eine String-Variable namens Nachname, die von außen gelesen und geändert werden 
kann. Man beachte hier, dass Variablen in der Regel mit Kleinbuchstaben beginnen 
und dann ggf. bei Wortzusammensetzungen neue Worte mit Großbuchstaben beginnen  
(lower camel case). In anderen Sprachen oft: *public String nachname;*

`    String vorname;`<br/>
Siehe Nachname.

`    String _emailAdresse;`<br/>
Die Emailadresse wird hier auf privat gestellt, ist also erstmal nicht von 
außen ablesbar oder beschreibbar. Wohlgemerkt: Sie soll im Endeffekt durchaus 
sowohl lesbar als auch beschreibbar sein. Ich erkläre später, wieso ich sie 
dennoch auf privat stelle. In anderen Sprachen oft: *private String emailAdresse;*

`    List<String> _registrierteEmailAdressen;`<br/>
Ebenfalls privat: Die Liste der bereits registrierten Emailadressen.

`    int _anzahlVersendeterRegistrierungsEmails = 0;`<br/>
Ebenso die Anzahl der versendeten Emails. Diese ist ebenfalls erstmal grundsätzlich 
private. Das angehängte `= 0` bedeutet, dass ein neu geschaffenes Objekt dieser 
Klasse nicht mit dem Wert "null" im Attribut "anzahlVersendeterEmails" startet, 
sondern dass wir stattdessen mit 0 starten.

`    String get emailAdresse => _emailAdresse;`<br/>
Hiermit stellen wir eine Methode zur Verfügung, um den Wert von _emailAdresse 
auszulesen, unter dem Namen emailAdresse. Das heißt: Dieses Attribut war 
grundsätzlich erstmal private, nicht von außen sichtbar. Aber durch diese 
Definiton machen wir die Variable von außen lesbar! Diese Konstruktion ist 
ein sogenannter Getter.

`    void set emailAdresse(String neueAdresse) {`<br/>
Das ist das Gegenstück. Ein Setter. Die Emailadresse lässt sich nun auch von 
außen verändern. Wenn wir sie sowohl auslesbar machen als auch beschreibbar, 
wieso stellen wir sie nicht einfach public? Wäre sie public, dann würde man 
sie wild verändern können. So haben wir Kontrolle über jede Änderung, wie man 
gleich in den nächsten Zeilen sieht.

```
        if (_istEmailAdresseValide(neueAdresse)) {
            String alteAdresse = _emailAdresse;
            if (emailAdresseIstVerifiziert) {
                _registrierteEmailAdressen.add(alteAdresse);
            }
            _emailAdresse = neueAdresse;
            sendeVerifizierungsEmail();
        }
``` 
Funktionalität: Wir lassen zuerst prüfen (mittels unserer selbst geschriebenen 
Funktion), ob die neue Emailadresse prinzipiell gültig ist. Wemm dem so ist, dann 
speichern wir die alte Adresse zwischen in einer Variable. Dann prüfen wir, ob 
diese neue Emailadresse bereits verifiziert ist. Wenn so ist, dann ist die 
alte Emailadresse der Liste von Emailadressen zuzuordnen, die bereits registriert 
sind. Und  generell (also lediglich davon abhängig, ob die Emailadresse valide 
ist) wird die neue Emailadresse im System gespeichert und dann die 
Verfizierungsemail versendet.

`       bool get emailAdresseIstVerifiziert => _emailAdresseIstVerifiziert;`<br/>
Auch hier ein Getter. Wir lassen das Lesen von außen zu, aber es gibt keinen 
Setter, also ist dieses Attribut nur lesbar, nicht beschreibbar. Man beachte die 
Kurzschreibweise von Dart bei Funktionen, die nur einfach einen Rückgabewert 
produzieren. In anderen Sprachen üblich wäre eher eine Konstruktion wie:

*bool get emailAdresseIstVerifiziert {<br/>
    return this.emailadresseIstVerifiziert;<br/>
}*

Das Schlüsselwort this macht klar, dass wir das Attribut emailAdresseIstVerifiziert 
meinen, weil unser Getter genauso heißt. Man kann den Getter aber auch anders nennen 
als die zugrundeliegende Variable.

`       int anzahlVersendeterRegistrierungsEmails() => _anzahlVersendeterRegistrierungsEmails;`<br/>
Wieder ein Getter. Wir lassen das Lesen zu. Es gibt keinen Setter, also ist auch 
dieser Wert read-only.

```
  bool _istEmailAdresseValide(String email) {
    // Prüflogik
    if (email.length > 0) {
      return true;
    } else {
      return false;
    }
  }
```
Die Funktion, die eine Emailadresse auf Validität prüft. Im Vorliegenden Fall 
prüft sie nur, ob die neue Emailadresse länger als 0 Zeichen ist. Das ist 
natürlich noch keine *echte* Prüfung. Man beachte, dass auch dieser 
Funktionsname mit einem Unterstrich beginnt. Diese Funktion ist also privat, 
sie kann von außen nicht ausgeführt werden. In anderen Sprachen würde man 
wieder das private-Schlüsselwort davor setzen.

```
  void sendeVerifizierungsEmail() {
    // Logik, mit der die Email versendet wird
    _anzahlVersendeterRegistrierungsEmails++;
  }
```
Die Sende-Methode ist hingegen öffentlich, denn wir wollen ja, dass das 
Sekretariat von außen den Emailversand erneut anstoßen kann. In anderen 
Sprachen könnte man das mit dem Kennwort public erreichen.

`}`<br/>
Abschließende Klammer. Die Klassendefiniton ist vorüber.

## Wie wird ein Objekt gehandhabt?

Wir haben gelernt, dass eine Klasse einen Bauplan für ein Objekt enthält. Jedes 
unserer Schüler-Objekte enthält diverse Attribute / Variablen. Nun wird 
eine konkrete Instanz dieser Klasse erstellt, zum Beispiel weil wir in der 
Schülerverwaltung die Daten eines Schülers in einem Formular eingeben wollen.
Der neue Schüler hat ja noch keine Daten und daher sähe das im Code so aus.

`var student = Student()`<br/>
Damit wird einer Variablen student eine Instanz der Klasse student zugewiesen. 
Alle Attribute sind dabei auf ihrem Default-Value von null. Wir haben ja einen 
neuen Schüler angelegt und nicht einen existierenden, auch weil das im Beispiel 
jetzt schwer zu zeigen wäre, weil wir ja dann uns damit beschäftigen müssten, 
wie die Daten zum Beispiel aus der Datenbank eingelesen werden.

In anderen Sprachen würde man etwas umständlicher schreiben:
`Student student = new Student();`
Dart verzichtet auf die Typzuweisung, weil der Typ ja klar dadurch definiert wird, 
dass wir ein Student-Objekt instanziieren. Das kann ja nur ein Student sein, 
was da rauskommt.

Übrigens: Man beachte die Gemeinsamkeiten zwischen:
`String hallo = 'Welt';`
und
`String student = Student();`
(auch wenn wir in Dart die Typbezeichnungen weglassen könnten).

Was fällt auf? **Es gibt einen neuen Datentyp, der da Student heißt, so ähnlich 
wie int, String, double, etc. Das heißt: Jede Klasse definiert einen neuen 
Variablentyp!**

Wenn wir jetzt Daten in das Objekt einfügen wollen, dann können wir mittels 
Punkt auf alle **öffentlichen** Eigenschaften zugreifen. Gehen wir mal davon aus, 
dass das Sekretariat seine Eingaben gemacht hat und jetzt die Daten übertragen 
werden in unser Objekt. In etwa so:

```
student.nachname = 'Meier';
student.vormname = 'Alexandra";
student.emailAdresse = 'alexandra@ausoft.de';
```

Der Clou ist, dass die dritte Zeile, weil sie nicht direkt in eine öffentliche 
Variable (Attribut) schreibt, sondern (ohne dass der Programmierer dieser 
Zeilen sich dessen bewusst sein muss) implizit über den Setter "emailAdresse" 
zugreift, automatisch der Versand der Bestätigungsemail ausgelöst wird, ohne 
dass der, der das Formular schreibt, das auch nur im geringsten bedacht haben 
muss.

Auch Methoden lassen sich über diese Punkt-Notation auslösen. Wenn der Sekretär 
nun in seinem Verwaltungsprogramm auf den Button "Bestätigungsemail erneut aussenden" 
klickt, dann steht im Code dazu:

```
student.sendeVerifizierungsEmail();
```

Die Details der Implementierung übernimmt die Klasse Student. Der Programmierer 
des Formulars muss sich darum nicht kümmern.

### Konstruktoren

Ein wichtiges Element von Klassen sind noch Konstruktoren. Diese handhaben, wie 
wir direkt bei der Erstellung eines Objektes bereits Daten mitgeben können oder 
wie bestimmte Felder starten, wenn wir keine Daten mitgeben. Es ist einfach 
eine Art Funktion mit Argumenten, die die Ersterstellung des Objektes handhaben.

Ich will an dieser Stelle nicht zu tief in die Dart-Sprache einsteigen, denn 
Dart hat hier seine Besonderheiten, die allesamt Arbeit ersparen sollen. Lasst 
uns erstmal nur festhalten, dass diese Konstruktoren in manchen Programmiersprachen 
einen festen, reservierten Namen haben oder - zum Beispiel in Dart - einfach 
dadurch erkennbar sind, dass sie genauso heißen (auch mit der Großschreibung) wie 
die Klasse selbst. Hier mal ein Konstruktor, wie wir ihn für unsere Klasse 
Student schreiben könnten:

```
  // Konstruktor
  Student({
    String this.nachname,
    String this.vorname,
    String emailAdresse,
    List<String> registrierteEmailadressen,
    int anzahlVersendeterRegistrierungsEmails,
    bool emailAdresseIstVerzifiziert,
  })  : _emailAdresse = emailAdresse,
        _registrierteEmailAdressen = registrierteEmailadressen ?? [],
        _anzahlVersendeterRegistrierungsEmails = anzahlVersendeterRegistrierungsEmails ?? 0,
        _emailAdresseIstVerifiziert = emailAdresseIstVerzifiziert ?? false;
```

Student mit Klammern dahinter zeigt erstmal nur "das hier ist der Konstruktor der 
Klasse Student". In den Klammern kommen die Argumente, die der Konstruktor entgegen 
nimmt. Und jetzt machen wir einen kurzen Ausflug dahin, wie in Dart ganz generell 
Funktionsargumente ausgezeichnet werden.

Ich zeige es einfach an Beispielen:

```
void funktion(int a, String b) {
    // Irgendwas passiert hier
}
```

Das heißt: Unsere Funktion namens funktion erwartet zwei Argumente (in der 
Reihenfolge a, b). Ein gültiger Funktionsaufruf (irgendwoanders im Code) sähe also 
so aus: `funktion( 8, 'Hallo');`

Nicht zulässig hingegen wären:
```
funktion();
funktion(3);
funktion('a');
funktion('Hallo', 8);
funktion(3,'Hallo',11);
```

Diese Aufrufe sind deswegen nicht zulässig, weil sie gegen die Funktionsdefiniton 
verstoßen, die eben nacheinander in dieser Reihenfolge eine int- und eine String-Variable 
explizit verlangt.

Ich kann meine Funktion aber auch so definieren:

```
void funktion(int a, [String b]) {
    /// Irgendwas passiert hier
}
```

Die eckigen Klammern sagen: Dieses Argument ist optional. Ein Funktionsaufruf wie 
`funktion(8);` ist jetzt also gültig, denn man muss keinen String im Funktionsaufruf
verwenden.

Und dann kann ich die Funktion auch folgendermaßen definieren: 
```
void funktion(int a, {String b}) {
    /// Irgendwas passiert hier
}
```
Die geschweiften Klammern zeigen "dieses Argument ist optional, und wenn ich es 
angebe, dann muss ich explizit dazusagen, dass ich ein Argument b liefere.

Der konkrete Funktionsaufruf wäre jetzt `funktion(8, b: 'Hallo');`, wobei eben, 
weil es ja ein optionales Argument ist, `funktion(8);` weiterhin auch zulässig ist.

Das klingt erstmal nur nach sinnloser Schreibarbeit, aber gehen wir mal von 
folgender Funktion aus:

```
void funktion(String titel, {String links, String rechts, String unten, int anzahl, int menge, double preis}) {
    // Irgendwas passiert hier
}
```

Hier muss ich als erstes Argument einen String (titel) mitgeben, alle anderen 
Argumente sind optional, aber wenn ich beispielsweise nur die Anzahl mitgeben will, dann 
ist der Funktionsaufruf `funktion('Titel', anzahl: 3);` eben recht selbst erklärend 
und schön zu lesen.

Es gibt noch weitere Spielereien, die ihr nach und nach an Beispielen lernen werdet. 
Zum Beispiel kann man auch bei diesen benannten Argumenten bestimmten Argumenten 
sagen, dass sie geliefert werden müssen, indem man ein required vor den 
Argumenttyp setzt.

Außerdem kann man in der Argumentenauflistung auch Standardwerte hinterlegen, die 
dann zum Tragen kommen, wenn bei einem Aufruf der Funktion kein entsprechendes 
Argument angegeben wurde.

```
void funktion(String titel, {String links, String rechts, String unten, int anzahl = 0, int menge = 0, double preis}) {
    // Irgendwas passiert hier
}
```

Das bedeutet dann beispielsweise, dass, wenn ich beim Funktionsaufruf keine 
Argumente für anzahl und menge übergebe, automatisch stattdessen so getan wird 
als hätte ich 0 beim Funktionsaufruf übergeben.

### Destruktoren
In manchen Sprachen gibt es zusätzlich Destruktoren, also Routinen, die man dann 
ablaufen lässt, wenn ein Objekt zerstört wird. Das war vor allem in alten 
Sprachen (wie C++) notwendig, weil man den Speicher, den das Objekt belegt hatte, 
wieder freigeben musste.

In Dart gibt es keine Destruktoren, weil ein Objekt sowieso automatisch zerstört 
wird, wenn es nirgendwo referenziert (verwendet) wird.

## Ein paar Exkurse in unseren Code

Ich schnappe mir jetzt bewusst ein paar Beispiele aus unseren Projekten heraus. 
Der PLZ-Calculator ist da mein Beispiel für. Das könnt ihr im Code nachvollziehen.

Unter lib/models sind drei verschiedene Klassen definiert. (Jede Klasse bekommt 
bei uns in der Regel eine eigene Datei). Diese Klassen dürften weitgehend schon 
verstehbar sein mit dem Wissen, dass Ihr bis hierhin erworben habt.

Nehmen wir die Klasse Eingabe in lib/models/eingabe.dart

```
/// Diese Klasse fasst alle Daten zu einer konkreten Suchanfrage zusammen
class Eingabe {
  final String _zielPlz;
  final String _startPlz = Settings().ausgangsort;

  /// Konstruktor der Klasse Eingabe
  /// Die Ziel-PLZ kann/muss bestimmt werden bei Konstruktion des Objektes
  Eingabe(String zielPlz) : _zielPlz = zielPlz;

  /// PLZ des Zielortes
  String get zielPlz => _zielPlz;

  /// PLZ des Ausgangsortes
  String get startPlz => _startPlz;
}
```

Die Klasse umfasst zwei Attribute, einmal die PLZ, an der unsere Reise startet, 
und einmal die PLZ, zu der wir gelangen wollen. Beide sind privat, also von 
außen weder lesbar, noch beschreibbar. Allerdings wird für beide ein Getter 
definiert, mit dem man die Werte eben doch auslesen kann. Es gibt aber keine 
Setter, also kann man die Werte nicht ändern. Die einzige Möglichkeit, dem 
Objekt dieser Klasse einen Wert zuzuweisen, ist direkt die Entstehung des 
Objektes.

Hier läuft der Konstruktor ab. Dieser nimmt nur ein Argument an, das aber zwingend, 
die Ziel-Postleitzahl. Für die Start-Postleitzahl gilt hingegen, dass sie 
nicht durch den Konstruktor initialisiert wird. Sie würde also prinzipiell 
mit "null" starten. Im Attribute-Teil der Klassendefiniton sieht man aber, dass 
der Initialisierungswert dieses Attributes nicht "null" ist sondern der Ausgangsort, 
der in einem Setting-Objekt gespeichert ist. Wir werden im Bereich Entwurfsmuster 
sicherlich mal darüber reden, wieso der Aufruf "Settings()" kein leeres, 
neues Settingobjekt erzeugt, sondern uns Zugriff auf die User-Settings 
gewährt. Alternativ könnt Ihr auch nach dem Stichwort "Singleton" googeln.

Gut, im Endeffekt wird also ein Objekt erzeugt der Klasse Eingabe und dieses 
Objekt hat als unveränderbare Werte den Wert ZielPlz, den wir direkt bei der 
Erzeugung mitgeben - und einen Wert StartPlz, den es sich zum Zeitpunkt 
seiner Erzeugung aus den zu diesem Zeitpunkt gültigen User-Settings bezieht.

Die nächste Datei aus dem PLZ-Calculator ist lib/resultat.dart

```
import 'package:plzcalculator/models/settings.dart';

/// Das Ergebniss einer Routenabfrage
class Resultat {
  /// Die Distanz zwischen der startPlz und der zielPlz
  final int? fahrtstrecke;

  /// Die Zeit, die benötigt wird, um die Distanz zu überwinden
  final int? fahrtzeit;

  /// Ist true, wenn ein Fehler bei der Abfrage geschah, zum Beispiel 
  /// durch Verbindungsabbruch
  final bool error;

  /// Schriftliche Bezeichnung eines eventuellen Fehlers
  final String? errorMessage;

  /// Die Höhe der Fahrtkosten (gemäß Km-Pauschale) für die Strecke
  int fahrtkostenStrecke = 0;

  /// Die Höhe der Fahrtkosten (gemäß Stunden-Pauschale) für die Strecke
  int fahrtkostenZeit = 0;

  /// Die Höhe der Hotelkosten, so Hotelkosten anfallen
  int hotelkosten = 0;

  /// Die Summer aller Kosten
  int summe = 0;

  /// Die Höhe der Mehrwertsteuer
  int mwst = 0;

  /// Die Summe inklusive der Mehrwertsteuer
  int bruttosumme = 0;

  /// Konstruktor für das Ergebnis der Abfrage
  Resultat({
    this.fahrtstrecke,
    this.fahrtzeit,
    this.error = false,
    this.errorMessage,
  }) {
    final settings = Settings();
    if (fahrtstrecke == null || fahrtzeit == null) {
      return;
    }
    if (fahrtstrecke != null &&
        fahrtzeit != null &&
        errorMessage == null &&
        !error) {
      fahrtkostenStrecke =
          2 * fahrtstrecke!.round() * settings.fahrtkostenKm ~/ 1000;
      fahrtkostenZeit = (2 * fahrtzeit! * settings.fahrtkostenH) ~/ 3600;
      if (settings.hotel &&
          (fahrtstrecke! >= settings.hotelAbKm * 1000 ||
              fahrtzeit! >= settings.hotelAbH * 3600)) {
        hotelkosten = settings.hotelKosten;
      }
      summe = fahrtkostenStrecke + fahrtkostenZeit + hotelkosten;
      mwst = (summe * settings.mwstSatz / 100).round();
      bruttosumme = summe + mwst;
    }
  }
}
```

Eine Klasse namens Resultat wird erstellt. Diese Klasse eine ganze Reihe von 
Attributen / Variablen, die sich letztlich alle zusammen das Resultat einer 
PLZ-Entfernungsanfrage darstellen.

Kurz dazu, wieso manche der Variablentypen ein nachgestelltes Fragezeichen haben: 
*In Dart gibt es seit 2021 das Feature der sogenannten null-safety. Das heißt, 
dass generell unterschieden werden muss, ob eine Variable den Wert "null" 
beinhalten darf oder nicht. Variablen, die auch "null" enthalten können, müssen 
mit ? gekennzeichnet werden. Bei einer fehlerhaften Anfrage (keine Internetverbindung 
oder PLZ nicht existent) haben wir das so gehandhabt, dass in den mit ? 
gekennzeichneten Attributen tatsächlich "null" steht, nicht etwa die Zahl 0.

Umgekehrt gibt es ein Attribut errorMessage. Bei dem handhaben wir es so, 
dass hier bei einer erfolgreichen Abfrage einfach null übergeben wird, wenn 
kein Fehler vorliegt. Aus diesem Grund muss auch dieser Typ mit ? gekennzeichnet 
werden.

Ansonsten enthält die Klasse nur einen Konstruktor. Dieser schreibt vor, dass 
man bis zu 4 Argumente übergeben kann. Beim Funktionsaufruf muss man die 
Argumente benennen, also zum Beispiel kann eine gültige Instruktion für die 
Instanziierung eines Resultat-Objektes so aussehen:

```
var resultat = Resultat(fahrtstrecke: 15000, fahrtzeit: 1202);
```

Ansonsten werden im Konstruktor die anderen Werte (wie Fahrt- und Hotelkosten) 
allesamt berechnet. Wenn man sich die Berechnungsroutine anguckt, dann sieht man, 
dass auch hier die Settings des Users einfließen, denn in diesen steht ja, 
was wir zum Beispiel für eine Stunde Fahrtzeit berechnen müssen.

## Zwischenfazit

Ihr müsst nicht auf Anhieb jedes Wort verstanden haben. Weiter geht es bald 
mit weiteren Themen zur OOP.

Ihr solltet aber nach dem sorgfältigen Durcharbeiten dieser 
Lektion wissen, was eine Klasse ist und einfache Klassen sogar schon selbst 
erstellen können.

## Übung

Zieht Euch das Repository https://github.com/AUSoftAndreas/oop1.git (bzw. über 
VSCode geht das ja auch ohne die komplette URL). Enthalten sind zwei interessante 
Dateien:

- lib/person.dart
- test/person_test.dart

Die Datei person.dart ist recht leer, bis auf ein paar Formatierungen. Die Datei 
person_test.dart ist recht voll, aber voller Fehler. Eure Aufgabe ist es nun, 
in person.dart eine Klasse Person derart zu konstruieren, dass person_test.dart 
keinerlei rote Stellen mehr aufweist, denn person_test.dart ist eigentlich 
voll funktionsfähig. Nur person.dart ist halt unvollständig.

### Ausgangssituation
*Der leicht verrückte Programmierer P will seinen Alltag erleichtern, indem er 
bei seinen Bekannten vermerkt, wie häufig sie ihn schon enttäuschten. Sein 
neuestes Programm soll ihm die Arbeit dabei erleichtern.*

Die Klasse Person ist nach den folgenden Regeln zu erstellen:
- Jede Person hat folgende Eigenschaften:
  - vorname: Der Vorname der Person. Dieser soll von außen lesbar sein, aber 
  nicht veränderbar (=final), also wird ausschließlich über den Konstruktor 
  erstellt. Jede Person hat einen Vornamen und daher kann 
  hier nie der Wert null entstehen.
  - nachname: ebenso
  - spitzname: Dieser kann sich im Laufe der Zeit ändern und sollte daher 
  immer veränderbar sein. Wenn P gerade kein Spitzname auf der Zunge liegt für 
  eine Person, dann ist der Spitzname null.
  - geburtstag: Dieser ist immer von Anfang an bekannt, weswegen er analog zu 
  vorname und nachname abgehandelt wird.
  - enttaeuschungen: Die Anzahl der Enttäuschungen, die P schon seitens der 
  Person erhalten hat.
  - letzteEnttaeuschung: Der Zeitpunkt der letzten Enttäuschung.

  Folgende Programmlogik schwebt P vor:
  - Die Werte "vorname", "nachname", "spitzname" (optional), "geburtstag" (optional) 
  können per Konstruktor gesetzt werden.
  - Eine Methode namens neueEnttaeuschung() wird aufgerufen, wann immer P von der 
  Person enttäuscht wird. Diese setzt die Nummer der Enttäuschungen um eines hoch
  - Per neueEnttaeuschungZuruecknehmen() kann P die letzte Enttäuschung 
  zurücknehmen, wenn es noch der Tag dieser zurückzunehmenden Enttäuschung, wobei 
  er das auch nur einmal pro Tag machen kann, er kann also keine zwei 
  Ettäuschungen zurück geben.
  - Die Funktion neueEnttaeuschungZuruecknehmen() gibt den Wert true an das 
  aufrufende Objekt zurück, wenn die Rücknahme geklappt hat.

  Das, was Ihr in person_test.dart seht, ist ein sogenannter Unit Test. Wir 
  definieren die Tests, die *eine Klasse* betreffen.

  Am Ende sollte weder in person.dart als auch in person_test.dart kein Inhalt 
  mehr rot oder blau markiert werden von VSCode. Nach und nach sollten aber 
  alle Tests des Unit Test erfolgreich durchlaufen werden können.

  Testing ist ein wichtiger Bestandteil jeder Entwicklung und zudem recht einfach 
  in VSCode. Ihr geht in den nachfolgend dargestellten Bereich und findet dort 
  die Schaltfläche "Run all tests".... Wenn alles klappt, gibt es in der 
  Debug-Konsole keinerlei Fehlermeldungen, sondern nur Erfolgsmeldungen.

![](https://github.com/AUSoftAndreas/students/blob/dev/wiki/objektorientierung/testing_01.PNG?raw=true)


  Eines noch: Mir ist klar, dass diese Aufgabe am oberen Limit ist für die 
  meisten bzw. eigentlich darüber hinaus. Daher nutzt die Chance, Euch mit mir 
  und mit Euren Klassenkameraden zu besprechen.

  **Und macht bitte erst dann mit Teil 2 weiter, wenn Ihr das absolviert habt.**