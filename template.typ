#import "@preview/athena-tu-darmstadt-exercise:0.3.0": text-roboto, tuda-section, tuda_colors, tudaexercise
#import "@preview/codly:1.3.0": codly, codly-init
#import "@preview/fontawesome:0.6.0": fa-code
#import "@preview/cetz:0.5.2" as cetz

#import "points.typ": *
#import "boxes.typ": algo-green-box

#let template(
  draft: "draft" in sys.inputs,
  darkmode: "darkmode" in sys.inputs,
  sheet: 0,
  authors: (),
  version: [v1.0],
  topic: [],
  slidesets: [],
  submission: datetime.today(),
  body,
) = {
  state("algotypst").update(c => (
    draft: draft,
    darkmode: darkmode,
  ))

  set page(background: if draft {align(center + horizon, rotate(
    -60deg,
    text(size: 160pt, "ENTWURF", fill: red.transparentize(90%), font: "Roboto", weight: "bold", tracking: 4pt),
    reflow: true,
  ))})

  let sheet-str = if sheet < 10 {
    "0" + str(sheet)
  } else {
    str(sheet)
  }

  let term = if submission.month() > 4 {
    [#submission.year()/#{submission.year() - 1999}]
  } else {
    [#{submission.year()-1}/#{submission.year() - 2000}]
  }

  show: tudaexercise.with(
    language: "de",
    info: (
      title: "Übungsblatt " + sheet-str,
      subtitle: "Prof. Karsten Weihe",
      author: authors.join(",", last: " und "),
      sheet: sheet,
    ),
    logo: image("assets/tuda_logo.svg"),
    design: (
      accentcolor: "3b",
      darkmode: darkmode,
      colorback: false,
    ),
    task-prefix: "H" + str(sheet) + ".",
    task-prefix-subtasks: true,
    task-separator: ":",
    info-layout: table(
      inset: (y: 2pt, x: 0pt),
      columns: (1fr, 1fr),
      align: (left, right),
      stroke: none,
      [Übungsblattbetreuer:], authors.join(",", last: " und "),
      [Wintersemester #term], version,
      [Themen:], topic,
      [Relevante Foliensätze:], slidesets,
      [Abgabe der Hausübung:], [bis #submission.display("[day].[month padding:zero].[year]"), 23:50 Uhr],
    ),
    headline: text(font: "Roboto", size: 10pt)[*FOP* im *Wintersemester #term* bei *Prof. Karsten Weihe* #h(1fr) *Übungsblatt #sheet-str* -- #topic],
  )

  show link: it => emph(text(fill: blue, it))
  set list(indent: 1em, spacing: 1.2em)
  set enum(indent: 1em, spacing: 1.2em)
  set heading(numbering: "1.1", supplement: [Aufgabe])
  show ref: set text(fill: blue)
  show ref: it => {
    if it.element.func() == heading {
      let counter = counter(heading).at(it.element.location())
      [Aufgabe H#sheet.#numbering(it.element.numbering, ..counter)]
    } else {
      it
    }
  }

  codly(
    // fill: luma(240),
    fill: if darkmode { rgb("162b3a") } else { gray.lighten(50%) },
    // stroke: 1pt + black,
    stroke: none,
    header: none,
    header-cell-args: (align: center, fill: rgb(tuda_colors.at("3b"))),
    header-transform: x => {
      set text(size: 10pt, fill: white)
      grid(
        columns: (auto, 1fr, auto),
        align: horizon,
        fa-code(solid: true, baseline: -1pt), text-roboto(x), fa-code(solid: true, baseline: -1pt),
      )
    },
    // inset: (x: 3pt),
    zebra-fill: none,
    number-align: center,
    // lang-fill: white,
    // lang-outset: (x: 0pt, y: 30pt),
    // lang-outset: (x: -30pt, y: 0pt),
    lang-format: none,
    number-format: i => grid.cell(
      text(white, str(i)),
      fill: rgb("#4C4C4C"), /*inset: (x: 4pt)*/
    ),
  )

  show: codly-init.with()

  tuda-section[
    #text-roboto[Hausübung #sheet-str #h(1fr) Gesamt: #sum-points()] \
    #text(font: "XCharter")[_Erste Schritte mit Java & FopBot_]
  ]

  algo-green-box(title: [Beachten Sie die Seite #link("https://moodle.informatik.tu-darmstadt.de/mod/page/view.php?id=68765")[Verbindliche Anforderungen für alle Abgaben] im Moodle-Kurs.])[
    Verstöße gegen verbindliche Anforderungen führen zu Punktabzügen und können die korrekte Bewertung Ihrer Abgabe beeinflussen. Sofern vorhanden, müssen die in der Vorlage mit `TODO` markierten `crash`-Aufrufe entfernt werden. Andernfalls wird die jeweilige Aufgabe nicht bewertet.
  ]
  
  [Die für diese Hausübung relevanten Verzeichnisse sind #raw("src/main/java/h" + sheet-str) und ggf. #raw("src/test/java/h" + sheet-str)]

  set raw(theme: "assets/Lazy.tmTheme", lang: "java")

  body
}
