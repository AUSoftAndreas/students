# Die Antwort auf alle Fragen ...

... lautet 42, aber darüber hinaus haben wir uns auch mit der Frage 
beschäftigt, welche zwei Informationen wir brauchen, um einen 
beliebigen Monatskalender zu zeichnen, und ich hoffe echt Ihr wart diszipliniert 
genug, um Euch die Antwort gründlich zu überlegen, bevor Ihr hierhin weiter 
gegangen seid.

Unabhängig davon, ich muss es an dieser Stelle enthüllen. Ihr braucht exakt 
zwei Informationen:

- Welcher Wochentag ist der 1. des Monats? Alle anderen Wochentag-Zuordnungen 
des Monats folgen daraus absolut vorherbestimmbar.
- Wieviele Tage hat dieser Monat?

Man kann für diese beiden Informationen auch eine andere Verpackung finden, also 
genauso zulässig wären die beiden Fragen:

- Mit welchem Tag muss ich anfangen, meinen Kalender zu zeichnen? 
- Und mit welchem Tag muss ich enden?

Das sind im Endeffekt die gleichen Fragen. Und jetzt ist es eben wichtig, dass 
wir langsam anfangen wie ein Programmierer zu denken. Und das heißt wir haben 
eine Idee, was wir erreichen wollen und wir finden einen kleinen Schritt zum Ziel. 
Und dann googeln wir. :-)

## Wie konstruieren wir ein Datum in Javascript?

Wir haben es schonmal getan. In unserem bisherigen Code steht eine Zeile wie 
```
    let datToday = new Date();
```
Was tut diese Zeile? Sie erstellt ein Datum-Objekt. Ihr werdet Euch irgendwann 
eingehender mit objektorientierter Programmierung befassen und dann genauer 
wissen, was ein Objekt ist, aber fürs Erste belassen wir es dabei, dass wir 
wissen, dass das Ergebnis dieser Operation quasi ein Datum ist, das wir dann 
im Detail auslesen und auch verändern können. Das haben wir auch getan, denn 
wir haben später aus diesem Objekt den Tag extrahiert, den Monat extrahier, das 
Jahr extrahiert und den Wochentag extrahiert. Das war alles dort drin aufgrund 
der oben angegebenen, unscheinbaren Zeile `let datTody = new Date();`

Wir googeln mal nach "Javascript construct date", weil wir ein Datum in 
Javscript konstruieren wollen, nämlich den Ersten des Monats. Ich bin 
zuversichtlich, dass das Suchergebnis ähnlich aussähe, wenn wir den Begriff 
"construct" nicht gekannt hätten.

- [Google-Suche](https://www.google.com/search?safe=off&sxsrf=ALeKk00LbikUXOhQUwHMl5glJvp5bjUdtw%3A1613685759077&ei=_-MuYMiWBOyWjLsPmrOUkAg&q=javascript+construct+date&oq=javascript+construct+date&gs_lcp=Cgdnd3Mtd2l6EAMyBggjECcQEzIFCAAQywEyBQgAEMsBMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeMgYIABAWEB46BwgAEEcQsAM6BAgjECc6CggAEIcCELEDEBQ6DQgAEIcCELEDEIMBEBQ6AggAOggIABCxAxCDAToFCAAQsQM6BwgAEIcCEBQ6BggAEA0QHlCd-VVYgZBWYI2RVmgCcAJ4AIABcIgB2QqSAQQxNS4ymAEAoAEBqgEHZ3dzLXdpesgBCMABAQ&sclient=gws-wiz&ved=0ahUKEwiIksvzt_TuAhVsC2MBHZoZBYIQ4dUDCA0&uact=5)

Wenn wir einen konkreten Kniff suchen, wie man etwas tut, dann sind Privatseiten 
vielleicht ganz hilfreich, aber prinzipiell sind offizielle Dokumentationen 
immer recht gute erste Anlaufstellen. Der erste Link, zumindest bei mir, ist 
von mozilla.org, den Entwicklern von Javscript. Sieht gut aus, lasst uns die 
Seite ansehen.

- [Mozilla-Seite](https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Global_Objects/Date)

Nach und nach entwickelt man ein Gespürt für solche Seiten, aber interessante 
Informationen, die ich entnehme, sind:

- Es gibt vier Arten, ein Date-Objekt zu konstruieren:
  - Ohne Argumente: Weiter unten im Text steht dann, dass dann das heutige Datum 
  und die jetzige Systemzeit genommen wird. Das ist genau das, was in der o.a. 
  Zeile `let datToday = new Date();` geschah.
  - Mit einem "value" als Argument: Weiter unten steht, dass value hierbei die 
  Anzahl der Millisekunden seit dem 1.1.1970 bedeutet.
  - Mit einem String als Argument: Dieser String muss nach irgendwelchen ISO-Regeln 
  konstruiert werden. Klingt zu kompliziert.
  - Mit yeat, monthIndex, day, hour, minutes ..... etc. als Argument, wobei ab 
  day jedes Argument mit eckigen Klammern bezeichnet wird. Das bedeutet, dass man 
  das Argument auch weglassen kann.

  Angenommen wir haben in datToday das heutige Datum stehen, wie kommen wir dann 
  zum Monatsersten? Wie interpretiert Ihr folgende Codezeile?

  ```
  let monthFirst = new Date(datToday.getFullYear(), datToday.getMonth(), 1);
  ```

  Wir nehmen das Jahr von heute und den Monat von heute und setzen den Tag auf 1. 
  Das **ist** dann der Monatserste. Wir wollten wissen, welchen Wochentag der 
  Erste des Monats hat. Nunja, wir haben den Wochentag schon an anderer Stelle 
  im Code berechnet, nur eben auf heute bezogen. Das sollten wir jetzt für den 
  Monatsersten tun.

```
  let monthFirstWeekday = monthFirst.getDay();
```

