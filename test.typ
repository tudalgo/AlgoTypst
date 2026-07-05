#import "lib.typ": template, points, javadoc
#import "boxes.typ": *
#import "fopbot.typ" as fopbot

#show: template.with(
  sheet: 0,
  authors: ("Per Göttlicher", "Daniel Mangold"),
  topic: [Erste Schritte mit Java & FopBot],
  draft: true,
  darkmode: true,
)

= Abc #points(auto)

== Def #points(3)

== Gef #points(auto)

- `Fopbot.move()` #points(1)
- `Fopbot.turnLeft()` #points(1)
- `Fopbot.putCoin()` #points(1)

#pagebreak()

= A <a>

#vanforderung[
- Abc
]

@a

#fopbot.diagram({
  fopbot.colorfield(0,0)
  fopbot.colorfield(0,1)
  fopbot.colorfield(0,2)
  fopbot.colorfield(0,3)
  fopbot.colorfield(0,4)
  fopbot.vwall(0,0)
  fopbot.vwall(0,1)
  fopbot.vwall(0,2)
  fopbot.vwall(0,3)
  fopbot.vwall(0,4)
  fopbot.hwall(0,0)
  fopbot.coins(0,0,5)
  fopbot.robot(4,2, dir: "left")
  fopbot.robot(3,2, fopbot.bots.square_blue, "left")
  fopbot.hwall(3,3)
  fopbot.coins(3,2, 2)
})

#javadoc("java.lang.String#<init>(byte[])")
#javadoc("java.util.", full: true)
#javadoc("java.util.Comparator#compare(T,T)", title: "Comparator<T>")
#javadoc("java.util.Map.Entry#copyOf(java.util.Map.Entry)", title: "Map.Entry<K,V>", element_title: "copyOf(Map.Entry<K,V>)")
#javadoc("java.lang.Integer#MAX_VALUE")