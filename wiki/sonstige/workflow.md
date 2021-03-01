# Der Workflow

Im Folgenden stelle ich kurz dar, wie generell die Arbeit an unseren Projekten aussieht.

## Ein Repository clonen (das erste mal öffnen)
Zu Beginn habt Ihr noch kein Repository auf Eurem PC. Daher müsst Ihr den neusten Stand von Github ziehen. Das geschieht in VSCode.

Mit Strg+Shift+P die Befehlspalette öffnen und dort "Clone" eingeben. Ihr solltet den Befehl "Git: Clone" angezeigt bekommen. Wenn Ihr den klickt (bzw, mit Enter bestätigt), dann erhaltet Ihr als nächstes die Möglichkeit "Clone from Github". Auswählen. Und nun müsst Ihr das Repository, das Ihr klonen wollt, auswählen. Fangt an zu tippen und schreibt "AUSoft-Kassel/" ..... Dann sollten alle unsere Projekte erscheinen, mit denen wir zur Zeit arbeiten. Wählt eines aus. Danach müsst Ihr sagen, welches Euer Arbeitsverzeichnis ist: Wählt "C:\projects". Danach wird Euch automatisch das Projekt mit allen Files in ein neues Verzeichnis mit dem Namen des Projektes installiert.

## Vorhandenes Projekt öffnen
Einfach in VSCode "Open Folder" und das entsprechende Projektverzeichnis öffnen. Oder aus dem Explorer Rechtsclick auf Folder und "Open in VSCode" oder so.

## Warum ist alles rot?
Prinzipiell bedeutet "rot" Fehler. Anfangs rödelt der PC etwas, um den ganzen Code zu analysieren und es kann sein, dass die Fehler noch weg gehen. Sollte es sich um einen Fehler handeln, dann kann das durchaus ein Fehler sein, der in diesem Stand normal ist, wenn wir irgendwie halbfertig endeten. Sind es mehrere, sind andere Ursachen wahrscheinlicher.

Generell gibt es zwei Befehle, die aushelfen können (in dem Terminal in VSCode auszuführen):
`flutter upgrade`
Damit aktualisiert Ihr Eure Flutter-Installation, falls diese veraltet ist. Sollte das nicht schon geschehen sein (wenn es Fehlermeldungen gibt), kann es erforderlich sein, noch den Channel auszuählen, in dem man die neusten Änderungen von Flutter haben will.
`flutter channel beta`
Wir arbeiten immer mit dem Beta-Build von Flutter. Es gibt noch den etwas stabilieren stable-Channel, aber da fehlen dann die relativ neuen Features noch, bis sie allgemein als hinreichend getestet gelten.
Außerdem kann es sein, dass die Bibliotheken noch nicht installiert sind, die von anderen Leuten stammen und in das Projekt einbezogen sind.
`flutter pub get`
bezieht diese fehlenden Bibliotheken.

## Weiter gehts
Sollte es dann keine roten Markierungen mehr geben, dann kann man das Programm laufen lassen. Auf dem Handy schließt man dazu sein Handy an und wählt "Run & Debug" aus dem entsprechenden Menu.

## Was kann ich jetzt TUN?
Es ist ganz normal, dass Euer Beitrag anfangs klein ist und dann wächst, so als wenn Ihr Azubis in einer Softwarefirma wärt. Mit der App spielen und dann im Forum Features diskutieren oder, noch besser, Issues erstellen, also Bugs melden oder neue Features vorschlagen. Wir wollen Issues intensiv nutzen, es sind sozusagen Arbeitsaufträge, die man sich schnappen kann.

## Wie erledige ich ein Issue?
In der Leiste links in VSCode seht Ihr einen Button "Github". Dort seht Ihr auch alle offenen Issues für dieses Projekt. Klickt auf einen (markieren) und dann sehr ihr rechts davon zwei Icons. Der Pfeil bedeutet, dass Ihr Euch dieses Projektes annehmt. Damit kreiert Ihr automatisch einen neuen Branch lokal bei Euch, der so in etwa heißt wie das Issue. Ihr arbeitet dann daran. Um Eure Arbeit zu sichern, könnt Ihr diese hin und wieder comitten. Damit wird sie erstmal nur lokal bei Euch gesichert. Wenn Ihr soweit seid, dass Ihr fertig seid mit dem Auftrag, dann klickt Ihr ganz unten in der untersten Leiste von VSCode auf das Issue. Dann habt ihr die Möglichkeit, Eure Arbeit per PullRequest an mich weiter zu leiten. Wenn alles klappt, seid Ihr am Ende wieder im dev-Branch und die Arbeit liegt auf Github zum Einarbeiten vor.

(Ja, das mag alles kompliziert erscheinen, ist aber nach zwei, drei Versuchen beherrschbar. Ich hab mich dagegen entschieden, hier alle Git-Vokabeln zu erklären, weil ich das lieber zentral einmal machen will und nicht bei jedem Artikel)