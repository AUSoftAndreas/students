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

## Fallunterscheidungen
Fallunterscheidungen sind ein wichtiger Teil jeden Codes. Wenn eine bestimmte 
Bedingung gegeben ist, dann geschieht A, sonst unter Umständen B, ansonsten C. 
Solche Fallunterscheidungen gibt es immer wieder.

#### Fallunterscheidungen: If / Else
Jede mir bekannte Sprache hat dieses Konstrukt. Es schreibt sich auch ähnlich 
in jeder Sprache. Der folgende Code ist in Dart und kann in 90% aller Sprachen 
ohne Änderung kopiert werden:
```
var x == 5;
if (x < 5) {
    log('Kleiner als 5');
} else if (x < 10) {
    log('Zwischen 5 und 9, inklusive');
} else {
    log('alle anderen Werte');
}
```
Wichtig: Die Bedingung ist ein boolscher Wert, also etwas, das entweder true 
oder false ist.

#### Fallunterscheidungen: Switch Case
Das ist eine andere, recht übersichtliche Methode, um Fallunterscheidungen zu 
erzeugen. Im einleitenden Switch wird festgelegt, welche Variable den Wert 
enthält, auf dessen Status wir reagieren sollen. Die Case-Einträge zeigen 
potenzielle Fälle für den Inhalt dieser Bedingung.
```
var command = 'OPEN';
switch (command) {
  case 'OPEN':
    executeOpen();
    // ERROR: Missing break causes an exception to be thrown!!

  case 'CLOSED': // Empty case falls through
  case 'LOCKED':
    executeClosed();
    break;
}
```
#### Ternary Operator
In manchen Fällen bietet sich die Nutzung eines Operators ein, der 
lange if-Blöcke einspart.
-  Grundsätzlicher Aufbau:
    ```
    bedingung ? wasPassiertWennTrue : was PassiertWennFalse;
    ```
-  Ein Beispiel:
    ```
    var alter = 23;
    log(alter < 19 ? 'Hallo, Du', 'Ich freue mich, Sie willkommen zu heißen)
    ```

