#import "@preview/athena-tu-darmstadt-exercise:0.2.0": tuda_colors, text-roboto
#import "@preview/codly:1.3.0": codly

#let c-green = rgb(tuda_colors.at("3b"))
#let c-gray = rgb("808080")

#let info-box(title: none, color: c-green, fill: true, body) = {
  let background = color.transparentize(70%)
  rect(
    fill: if fill { background },
    // inset: 1em,
    inset: (
      left: 8pt,
      y: 2mm,
    ),
    radius: 3pt,
    width: 100%,
    stroke: (left: 5pt + color),
    [
      #if title != none [#text-roboto(strong(title)) \ ]

      #body
    ],
  )
}

#let algo-info-box = info-box.with(fill: false)
#let algo-gray-box = info-box.with(color: c-gray)
#let algo-green-box = info-box.with(color: c-green)

#let __is-list-content(it) = {
  let it = if repr(it.func()) == "sequence" {
    it.children
  } else {
    (it,)
  }
  it.any(i => i.func() in (enum, list, enum.item, list.item))
}

#let plural-box(singular, plural, basis) = {
  (it, force: false) => {
    let title = if type(it) == content and __is-list-content(it) or force {
      plural
    } else {
      singular
    }

    basis(title: title, it)
  }
}

#let ausblick = algo-info-box.with(title: [Ausblick:])
#let tipp = plural-box([Tipp:],[Tipps:], algo-info-box)
#let hinweis = plural-box([Hinweis:],[Hinweise:], algo-info-box)
#let erinnerung = algo-info-box.with(title: [Erinnerung:])
#let anmerkung = plural-box([Anmerkung:],[Anmerkungen:], algo-info-box)
#let bemerkung = plural-box([Bemerkung:],[Bemerkungen:], algo-info-box)
#let beispiel = plural-box([Beispiel:],[Beispiele:], algo-info-box)
#let exkurs = algo-gray-box.with(title: [Exkurs:])
#let vfrage = plural-box([Unbewertete Verständnisfrage:],[Unbewertete Verständnisfragen:], algo-gray-box)
#let vanforderung = plural-box([Verbindliche Anforderung:],[Verbindliche Anforderungen:], algo-green-box)
#let vanforderunghu = plural-box(
  [Verbindliche Anforderung für die gesamte Hausübung:],
  [Verbindliche Anforderungen für die gesamte Hausübung:], 
  algo-green-box
)
#let vanforderungahu = plural-box(
  [Verbindliche Anforderung für alle Hausübungen:],
  [Verbindliche Anforderungen für alle Hausübungen:], 
  algo-green-box
)


#let code-block(title: none, it) = {
  codly(header: title)
  it
}