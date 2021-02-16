# Objektorientierte Programmierung

*Vorweg sei gesagt, dass ich lange mit der Form gerungen habe, in der ich mich 
mit objektorientierter Programmierung (OOP) auseinandersetzen will. Am Liebsten 
wäre mir eine Präsentation gewesen, aber im Endeffekt fand ich bei einer 
Präsentation, die ich persönlich halte, das Ganze noch irgendwie erträglich, aber 
wenn ich mit der Wahrscheinlichkeit rechnen muss, dass ich es nicht selbst halte, 
sondern dass es von Teilnehmern nur gelesen wird, dann ist ein Präsentation 
einfach zu wenig Text. Hinzu kommt, dass dieses Wiki-Format mich sehr schön 
Links einbauen lässt, und wer klickt in einer Powerpoint auf einen Link?*

## Prozedural, funktional, imperativ, etc.

Grundsätzlich sei gesagt, dass die meisten Unterscheidungen eigentlich in der 
Praxis nicht so relevant sind bzw. die Unterschiede relativ fließend sind. 
Objektorientierung ist aber tatsächlich ein eigener Ansatz der Prgrammierung, 
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
in einzelne Bereiche / Module / etc.

Hinzu kommt, dass Variablen herkömmlicher Bauart, also im Wesentlichen Zahlen 
und Strings, auch oft gruppiert vorkommen. Beispielsweise hat eine Person 
einen Vornamen und einen Nachnamen und eine Adresse. Will man dafür jetzt 
drei Variablen anlegen, dann kann es gut sein, dass man an irgendwelchen
Stellen Variablen vergisst zu setzen.

Und wenn wir an Funktionalität denken, dann ist die auch oft mit Variablen 
verbunden. Beispielsweise gehen wir mal davon aus, dass in einem Verwaltungsprogramm 
jedes mal, wenn sich die Emailadresse einer Person ändert, diese Person eine 
Bestätigungsemail geschickt bekommt, um die neue Adresse zu verifizieren. Jetzt 
gibt es aber viele Stellen, wo sich die Emailadresse ändern kann:
- Die Person gibt auf der Homepage eine neue Emailadresse ein,
- ein Sachbearbeiter ändert die Adresse in den Stammdaten der Person
- und wir gehen davon aus, dass die Stammdaten der Person sich an mehreren 
Stellen in der Verwaltungssoftware geändert werden können -
- und an jeder dieser Stellen müsste nun implementiert werden, dass die 
Emailbestätigungs-Routine angestoßen wird.

Da ist es doch viel schöner, wenn wir einmal an einer Stelle hinterlegen, dass 
jede Änderung der Daten hinsichtlich Emailadressen eine solche Bestätigungs-Email 
auslöst, oder?

