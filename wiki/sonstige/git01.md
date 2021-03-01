# Sprechen Sie Git?

Ich maße mir nicht an, hier einen vollständigen Git-Guide zu schreiben. Da hilft dann YouTube und Co. Aber ein gewisses Basis-Verständnis ist notwendig, damit Ihr produktiv mitarbeiten könnt. Ich beschränke mich hier auch auf das Notwendigste, was Ihr wissen müsst.

Prinzipiell arbeitet Ihr immer in einem Branch. Alle unsere Projekte haben einen dev-Branch. Das ist sozusagen der Standard. Hier ist immer der neuste Stand unseres Projektes. Was EUCH aber nicht möglich ist, ist diesen dev-Branch zu verändern (weil dann jeder Fehler unseren neusten Stand beeinträchtigen würde). Stattdessen solltet Ihr immer einen Branch erstellen bei Euch lokal (das geschieht automatisch, wenn Ihr über ein Issue vorgeht). Manuell passiert das durch die unterste, linkeste Schaltfläche in der Fußleiste. Dort steht "dev". Klickt darauf und Ihr erhaltet die Möglichkeit, stattdessen einen neuen Branch zu erstellen. Wenn Ihr verstehen wollt, wie Branches funktionieren, guckt Euch hin und wieder per Git Graph (auch unten in der Liste) an, wie sich im Laufe der Zeit unser Projekt entwickelte. Die Hauptlinie ist der dev-Branch. Alles andere sind kurze Abzweigungen, weil jemand den Code an sich nahm, dann erstmal lokal fortentwickelte - und irgendwann mündeten die Ergebnisse wieder in den dev-Branch ein.

Wenn Ihr einen Break beim Arbeiten macht, dann solltet Ihr das Ergebnis bis dahin per "commit" einreichen. Das heißt, dass die Änderungen bei Euch lokal gespeichert werden. Commits sind daher immer gut. Mindestens(!) einer am Tag.

Wenn Ihr fertig seid, dann könnt Ihr die Ergebnisse Eurer Arbeit per "push" auf Github in unserem Team veröffentlichen. Dazu verfasst man dann auf Github noch einen "Pull Request". Das heißt, dass Ihr mich auffordert, die Inhalte Eurer Arbeit in dev zu "pullen".

Push heißt also die Arbeit lokal wird zum Server übertragen. Pull Request heißt, dass ich die Arbeit übernehmen soll in dev.

Pull heißt Ihr zieht den neusten Stand eines Zweiges.

Ein typisches Problem, das passieren kann, sieht folgendermaßen aus:

- Ihr zieht an Tag X den neusten Stand von dev - per Push
- Dann erstellt Ihr lokal einen Branch.
- An dem arbeitet ihr bis Tag Z.
- Jetzt wollt Ihr Eure Arbeit per push veröffentlichen bzw. einen Pull Request machen.
- VSCode meckert aber, weil dev inzwischen einen anderen Stand hat als der, wo Ihr abgezweigt sein.

Ganz bildlich .... In dem Moment, wo Ihr den Branch wechselt, erhaltet Ihr nicht mehr die Updates von dev. Jetzt kann es theoretisch sein, dass ich in der Zwischenzeit die App komplett umgeschrieben habe, sodass Eure Änderungen nicht mehr hinein passen.

Wenn sowas vorkommt, dann kann man in der Regel zuerst einen "Pull from" durchführen (und zwar von dev), wo man sagt, dass man zuerst seinen Code anpasst (was in der Regel automatisch passiert) auf den neusten Stand von dev UND dann tatsächlich seine Änderungen absendet.