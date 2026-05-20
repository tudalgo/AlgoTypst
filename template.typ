#import "@preview/athena-tu-darmstadt-exercise:0.2.0": text-roboto, tuda-section, tuda_colors, tudaexercise
#import "@preview/codly:1.3.0": codly, codly-init
#import "@preview/fontawesome:0.6.0": fa-code
#import "@preview/cetz:0.5.2" as cetz

#import "points.typ": *

#let info-box(title: none, fill: true, body) = context {
  let design = state("tud_design").get()
  let background = color.mix((rgb(tuda_colors.at("3b")), 30%), (design.background_color, 70%))
  rect(
    fill: if fill { background },
    // inset: 1em,
    inset: (
      left: 8pt,
      y: 2mm,
    ),
    radius: 3pt,
    width: 100%,
    stroke: (left: 5pt + rgb(tuda_colors.at("3b"))),
    [
      #if title != none [#text-roboto(strong(title)) \ ]

      #body
    ],
  )
}

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

  set page(background: align(center + horizon, rotate(
    -60deg,
    text(size: 160pt, "ENTWURF", fill: red.transparentize(90%), font: "Roboto", weight: "bold", tracking: 4pt),
    reflow: true,
  )))

  let format-sheetnumber(x) = if x < 10 {
    "0" + str(x)
  } else {
    x
  }

  let term = if submission.month() > 4 {
    [#submission.year()/#{submission.year() - 1999}]
  } else {
    [#{submission.year()-1}/#{submission.year() - 2000}]
  }

  show: tudaexercise.with(
    language: "ger",
    info: (
      title: "Übungsblatt " + format-sheetnumber(sheet),
      author: "Prof. Karsten Weihe",
      sheet: sheet,
    ),
    logo: image("assets/tuda_logo.svg"),
    design: (
      accentcolor: "3b",
      darkmode: darkmode,
      colorback: false,
    ),
    task-prefix: "H",
    title-sub: table(
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
  )

  set raw(theme: "assets/Lazy.tmTheme")
  show raw: set text(spacing: 100%)
  set text(lang: "de")
  show link: it => emph(text(fill: blue, it))
  set list(indent: 1em, spacing: 1.2em)
  set enum(indent: 1em, spacing: 1.2em)

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
    #text-roboto[Hausübung #format-sheetnumber(sheet) #h(1fr) Gesamt: #sum-points()] \
    #text(font: "XCharter")[_Erste Schritte mit Java & FopBot_]
  ]

  body
}
