#import "lib.typ": template, points
#import "boxes.typ": *

#show: template.with(
  sheet: 0,
  authors: ("Per Göttlicher", "Daniel Mangold"),
  topic: [Erste Schritte mit Java & FopBot],
  draft: true,
)

= Abc #points(auto)

== Def #points(3)

== Gef #points(auto)

- `Fopbot.move()` #points(1)
- `Fopbot.turnLeft()` #points(1)
- `Fopbot.putCoin()` #points(1)

#pagebreak()

= A

#vanforderung[
- Abc
]