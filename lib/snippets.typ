#import "boxes.typ": vanforderungahu, info-box, algo-green-box, hinweis, erinnerung, algo-info-box

#let requirement-global-requirements = vanforderungahu(force: true)[
  Das Dokumentieren und Kommentieren Ihres Quelltextes ist nicht verbindlich,
  wird zum besseren Verständnis Ihrer Lösung jedoch empfohlen.
  Alle zur Bewertung dieser Hausübung relevanten Deklarationen von Klassen, Methoden (hierzu zählen auch Konstruktoren) und Attributen sind bereits in der Quelltext-Vorlage enthalten
  und dürfen nicht modifiziert oder entfernt werden.
  Ihnen steht aber frei,
  Hilfskonstrukte in Form von weiteren Klassen, Methoden und Attributen zu erstellen,
  sofern dies nicht explizit auf dem Übungsblatt verboten wurde
  und Ihre Hilfskonstrukte nicht gegen verbindliche Anforderungen verstoßen.
  Datenstrukturen und Hilfsmethoden aus der Java-Standardbibliothek sowie Arrays sind nicht erlaubt,
  sofern dies nicht explizit auf dem Übungsblatt gefordert oder erlaubt wurde.
  Ihre Methoden müssen auch dann funktionieren,
  wenn Aufrufe von in der Vorlage deklarierten Methoden
  (auch von solchen, welche von Ihnen implementiert werden)
  durch andere, korrekte Implementationen ersetzt werden.

  Der Verstoß gegen verbindliche Anforderungen führt zu Punktabzügen und kann die korrekte Bewertung Ihrer Abgabe unter Umständen beeinflussen.
  Die Implementation einer in der Quelltext-Vorlage deklarierten Methode wird nur bewertet,
  wenn der mit `TODO` markierte Exception-Wurf entfernt wird.
]

#let hint-global-hints(url) = info-box(title: [Hinweise für alle Hausübungen:])[
  Die zu verwendenen Zugriffsmodifizierer sind in der Vorlage bereits gegeben und werden auf dem Übungsblatt nicht immer angegeben.
  Beachten Sie die Informationen im Moodle-Abschnitt #link(url)[Technisches und Probe-Übungsblatt].

  Bei Fragen stehen wir Ihnen vorzugsweise im Moodle-Kurs und in den Sprechstunden zur Verfügung.
]

#let requirement-exercise-intro-old(url, sheetnumber) = [
  #requirement-global-requirements
  #hint-global-hints(url)
  Die für diese Hausübung relevanten Verzeichnisse sind #raw("src/main/h" + sheetnumber) sowie ggf. #raw("src/test/h" + sheetnumber).
]

#let requirement-exercise-intro(url, sheetnumber) = [
  #algo-green-box(title: [Beachten Sie die Seite #link(url)[Verbindliche Anforderungen für alle Abgaben] im Moodle-Kurs.])[
    Verstöße gegen verbindliche Anforderungen führen zu Punktabzügen und können die korrekte Bewertung Ihrer Abgabe beeinflussen.
    Sofern vorhanden,
    müssen die in der Vorlage mit `TODO` markierten `crash`-Aufrufe entfernt werden.
    Andernfalls wird die jeweilige Aufgabe nicht bewertet.
  ]
  Die für diese Hausübung relevanten Verzeichnisse sind #raw("src/main/h" + sheetnumber) sowie ggf. #raw("src/test/h" + sheetnumber).
]

#let hint-tests-introduction = hinweis[
  Auch wenn Sie für das Erstellen von Tests keine Punkte erhalten:
  Das Teilen jeglicher Tests zur Hausübung
  (auch solcher,
  welche nicht auf Basis dieser Aufgabe erstellt wurden)
  ist nicht erlaubt.
  Unser Ziel ist,
  die Verbreitung fehlerhafter Tests in Ihrem Sinne zu verhindern.

  Die von uns bereitgestellten Public Tests überprüfen nur einen kleinen Teil Ihrer Implementation.
  Erfüllt Ihre Lösung nicht alle Public Tests,
  erhalten Sie auf keinen Fall die volle Punktzahl.
  Im Umkehrschluss bedeutet dies aber nicht,
  dass Sie die volle Punktzahl erhalten,
  wenn Ihre Lösung alle Public Tests besteht.

  Der folgende Leitfaden dient als Unterstützung zum Aufbau Ihrer eigenen Tests.
  Sie können vom Leitfaden abweichen und dabei mindestens genauso aussagekräftige Testergebnisse erzeugen.
]

#let hint-remove-crash = erinnerung[
  Beachten Sie bei _jedem_ Übungsblatt,
  dass nach Bearbeitung einer Aufgabe die jeweiligen mit #raw("// TODO", lang: "java") markierten Aufrufe von `crash` entfernt werden müssen.
  Andernfalls funktioniert Ihre Implementation nicht korrekt und die jeweiligen Teile Ihres Quelltextes werden _nicht_ bewertet!
]

#let requirement-documentation = algo-green-box(title: [Verbindliche Anforderung: Dokumentieren Ihres Quelltexts])[
  Alle von Ihnen deklarierten Klassen, Interfaces, Enumerationen und Methoden (inklusive Konstruktoren), die nicht `private` sind, _müssen_ für diese Hausübung mittels JavaDoc in Englisch oder alternativ Deutsch dokumentiert werden.
  Für jede korrekte Deklaration ohne Dokumentation verlieren Sie jeweils einen Punkt.

  Beachten Sie die Seite #link("https://wiki.tudalgo.org/exercises/documentation/")[Hausübungen $arrow.r$ Dokumentieren von Quelltext] im Studierenden-Guide.
]

#let warning-plagiarism = algo-green-box(title: [Wir verfolgen "Abschreiben" und andere Arten von Täuschungsversuchen!])[
  Disziplinarische Maßnahmen treffen nicht nur die, die abschreiben, sondern auch die, die abschreiben lassen! Beachten Sie die Seite #link("https://www.informatik.tu-darmstadt.de/studium_fb20/im_studium/studienbuero/plagiarismus/index.de.jsp")[Grundregeln der Wissenschaftsethik] des Fachbereichs Informatik.
]

#let hint-fopbot-screenshots = hinweis[
  Screenshots aus der Welt der Roboter dürfen Sie unbedenklich mit anderen Studierenden teilen -- nur eben nicht den Quelltext oder eine übersetzte Variante des Quelltexts!
]

#let requirement-correct-identifiers = algo-info-box[
  Verwenden Sie in Ihrem Quelltext 1:1 die auf diesem Übungsblatt gewählten Identifier!
  Andernfalls wird die jeweilige Aufgabe nicht automatisiert bewertet.
]

#let requirement-files-for-types(sheetnumber) = algo-info-box[
  Wenn die Rede davon ist,
  dass Klassen, Interfaces oder Enumerationen _erstellt_ werden sollen,
  müssen zuerst die dazugehörigen Dateien in #raw("src/main/java/h" + sheetnumber) (sofern nicht anders angegeben) erstellt werden.
]

#let hint-cartesian-naming-notation = algo-info-box[
  Auf diesem Übungsblatt werden Aufzählungen überschneidender Namen verkürzt,
  indem nur disjunkte Teile von Namen innerhalb geschweifter Klammern aufgezählt werden und
  bei vorangegangener Aufzählungen einsetzbare Elemente durch `*` ersetzt werden.
  Beispiel: `set{X,Y}For{A,B}` ist die Abkürzung für `setXForA`, `setXForB`, `setYForA` und `setYForB`. `set*For*` ist die Abkürzung für `set{X,Y}For{A,B}`.
]

#let hint-racket-to-java = algo-info-box[
  Wenn die Rede davon ist,
  dass eine Racket-Funktion 1:1 in Java umgesetzt werden soll,
  können Sie sich bei der Umsetzung an den Beispielen aus den oben genannten Kapiteln orientieren.
]

#let hint-javadoc = algo-info-box(title: [Hinweise Vorlage:])[
  In dieser Übung werden die vorgegebenen Klassen, Attribute, Konstruktoren und Methoden nicht mehr im Detail beschrieben.
  Bitte entnehmen Sie alle weiteren Informationen den Javadocs der Vorlage.
  Eigenständig zu implementierende Konstrukte sind weiterhin im Übungsblatt erläutert.
]