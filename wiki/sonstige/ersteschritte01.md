# Vorbemerkungen
Ich empfehle, sich sowohl für die installierten Tools (in Sachen Programmierung) als auch für die eigentlichen Projekte jeweils ein Verzeichnis anzulesen. Und aus Bequemlichkeit sollten diese einfach erreichbar sein. Außerdem geschieht von Seiten des Betriebssystems für meinen Geschmack zu viel Ungeplantes in den Standard-Verzeichnissen wie C:\Programme bzw. C:\User\Documents. Daher nutze ist in der Regel:
- **C:\src** für alle installierten Programme / Sprachen / Tools
- **C:\projects** für alle meine Projekte
Jedes Projekt hat dann ein Verzeichnis unter C:\projects

(Die Kleinschreibung ist bewusst, da manche Betriebssyste zwischen Groß- und Kleinschreibung unterscheiden - und dann ist es gut, wenn man von vornherein Missverständnisse ausschließt)

# Voraussetzungen für die Mitarbeit
**Git**
[Git](https://git-scm.com/) ist das Standard-Versionierungssystem für Programmierer. Damit wird auf Eurem PC (bzw. im jeweiligen Arbeitsverzeichnis) stets gespeichert, welche Änderungen Ihr am Code vorgenommen habt. So kann man Änderungen, auch über Monate, nachvollziehen. Und mit einem Remote Repository (sozusagen Code-Speicherplatz) kann dann auch nix passieren, wenn Euer PC explodiert.

**Visual Studio Code**
Zuerst brauchen wir eine funktionsfähige Installation einer gängigen IDE (Integrated Development Environment). Ich empfehle [Visual Studio Code](https://code.visualstudio.com/), weil sich damit die meisten Sprachen abdecken lassen und zurzeit ist es auch der beliebteste Editor.

**Plugins in Visual Studio Code**
Generell empfehle ich die folgenden Plugins für VSCode, die Ihr einfach in dem geöffneten VSCode durch einen Klick auf den Button "Extensions" in der ganz linken Leiste und dann die Eingabe von Suchworten findet:
- Community Material Theme: Das ist nur eine Grafikveränderung, kann man auch weglassen.
- Material Icon Theme: Weitere Icons, mit denen die Oberfläche etwas hübscher ist, Auch das ist optinal.
- Draw.io Integration: Damit kann man Grafiken aus Draw.io anschauen. Das erspart, dass man sie jeweils extern öffnen muss. Draw.io kann man gut nutzen für UML-Diagramme und dergleichen. Das ist generell ein Browserprogramm, das man einfach öffnen kann, indem man auf die Adresse draw.io surft.
- Git Graph: Schöne Ergänzung, die den Verlauf von Bearbeitungen an einem Projekt veranschaulicht.
- GitHub Pull Request and Issues: Tolles Plugin, mit dem man direkt aus VSCode mit Github interagieren kann.

**Microsoft Teams**
Auch wenn ich hoffe, dass sich mehr unserer Zusammenarbeit in Github abspielen wird als in [Microsoft Teams](https://www.microsoft.com/de-de/microsoft-teams/group-chat-software), so ist Teams doch, allein schon wegen Telefonaten / Videos / Bildschirm-Sharing ein tolles Tool. Ihr könnt es für den direkten Chat mit mir und untereinander nutzen ... Für programmierbezogene Diskussionen würde ich aber das Github-Forum vorziehen.

**Flutter**
Installiert [Flutter](https://flutter.dev/). Das installiert Dart automatisch mit. Dafür folgt ihr der sehr langen Installationsanleitung Schritt für Schritt.

# Die richtige Konfiguration
Hier kommen wir dann zu dem Punkt, bei dem es unweigerlich zu Problemen kommen wird. Das ist alles komplexer als die Installation von Standardsoftware, weil das alles Tools von Profis für zukünftige Profis sind. Betrachtet es einfach als die erste Hürde. Seid insofern beruhigt, als dass auch ich immer mal wieder wild klicke und versuche, wenn irgendwas bei GIT hakt. :-)

Teil der Installation von Flutter ist ja, immer wieder "flutter doctor" in die Powershell einzugeben. Im Endeffekt sollten bei Euch nur grüne Häkchen stehen. Ich **glaube** Ihr könnt Euch die Android Toolchain, die unter anderem die Installation von Android Studio erfordert, schenken, aber ich bin nicht sicher, weil ich sie installiert habe .... Im Endeffekt ist sie aber wohl nur nötig, wenn man ein Handy auf dem PC emulieren will, statt sein eigenes zu nutzen. Ebenfalls Teil der "flutter doctor"-Tyrannei ist auch, sein eigenes Handy per USB an den PC anzuschließen und den Dev-Modus für dieses freizuschalten. Das geht am einfachsten, wenn man einfach googelt "Redmi 9 Pro Entwickleroptionen" ... nur halt Euren Handytypen stattdessen einsetzen.

Schließlich wäre noch git zu initialisieren, einfach in der Befehlszeile:
`git config user.email "meine@email.com"`
`git conig user.name "Max Mustermann"`
(Eigene Infos eintragen)

Außerdem ist es zweckmäßig, ein paar Umgebungsvariablen zu setzen, zumindest in Windows. Das geht folgendermaßen:
- Auf Startmenu-Button drücken
- Anfagen zu tippen "Env" (für environment variables oder so, ich machs jedenfalls immer Englisch)
- Danach "Umgebungsvariablen für dieses System" oder "diesen Benutzer" auswählen. Da es unwahrscheinlich ist, dass es irgendwen anders behindert, ziehe ich das System vor, aber manchmal lassen das die Sicherheitseinstellungen nicht zu.
- Wenn die Variablen nicht vorhanden sind, würde ich zumindest die folgenden setzen:
- "FLUTTER_ROOT" = "C:\src\flutter"
- und in Path kann man mehrere Eintragen, auf jeden Fall sollten zu den Pfaden dort hinzu:
- C:\src\flutter
- C:\src\flutter\bin
(Natürlich alles anpassen, wenn Ihr andere Pfade habt)

