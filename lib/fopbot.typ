#import "@preview/cetz:0.5.2": canvas, draw

#let fopbot-grid-stroke-width = 0.5mm

#let __build-bot-dict(..args) = {
  let bots = args.pos()
  bots.map(x => {
    (x, (
      on: image("/assets/fopbot/" + x + "_on.svg"),
      off: image("/assets/fopbot/" + x + "_off.svg"),
    ))
  }).to-dict()
}

#let bots = __build-bot-dict(
  "square_aqua",
  "square_black",
  "square_blue",
  "square_green",
  "square_orange",
  "square_purple",
  "square_red",
  "square_white",
  "square_yellow",
  "triangle_blue"
)

#let flatten-sequence-to-array(positionals) = {
  positionals.map(x => if type(x) == content and repr(x.func()) == "sequence" {x.children} else {x}).flatten()
}

#let draw-robot(x,y,img,rot) = {
  draw.content((x,y), (x+1,y+1), align(center + horizon, rotate(rot,{
    set image(width: 1cm, height: 1cm)
    img
  })))
}

#let draw-coin(x,y,count,shifted) = {
  if shifted {
    draw.content((x+0.8,y+0.8), {
      set text(size: 7pt, font: "Roboto", weight: "bold", fill: black)
      circle(fill: orange, radius: 1.5mm, align(center + horizon, [#count]))
    })
  } else {
    draw.content((x,y), (x+1,y+1), align(center+horizon,{
      set text(size: 9pt, font: "Roboto", fill: black)
      circle(fill: orange, radius: 4.5mm, align(center+horizon, [#count]))
    }))
  }
}

#let draw-wall(x,y,horizontal) = {
  let x = x * 1cm
  let y = y * 1cm
  if horizontal {
    draw.line((x - fopbot-grid-stroke-width/2,y+1cm), (rel: (1cm + fopbot-grid-stroke-width,0)))
  } else {
    draw.line((x+1cm,y - fopbot-grid-stroke-width / 2), (rel: (0, 1cm + fopbot-grid-stroke-width)))
  }
}

#let draw-fcolor(x,y,color) = {
  draw.stroke(none)
  draw.rect((x,y), (x+1,y+1), fill: color)
}

#let draw-item(x) = {
  if x.type == "robot" {
    draw-robot(x.x,x.y,x.img,x.rot)
  } else if x.type == "coin" {
    draw-coin(x.x,x.y,x.count,x.shifted)
  } else if x.type == "wall" {
    draw-wall(x.x,x.y,x.horizontal)
  } else if x.type == "color" {
    draw-fcolor(x.x,x.y,x.color)
  } else if x.type == "raw" {
    x.fun
  }
}

#let diagram(
  width: 5,
  height: 5,
  ..args
) = context {
  let items = flatten-sequence-to-array(args.pos())
  let items = items.map(x => x.value)
  let robots = items.filter(x => x.type == "robot")
  let robot-coords = robots.map(x => (x.x, x.y))
  let items = items.map(x => if x.type == "coin" {
    x + (shifted: (x.x, x.y) in robot-coords)
  } else {
    x
  })
  let fields = items.filter(x => x.type == "color")
  let items = items.filter(x => x.type != "color")

  let darkmode = state("tud_design").get().darkmode
  canvas(length: 1cm, {
    draw.rect((0,0), (width, height), fill: if darkmode {black} else {gray.lighten(50%)})
    for x in fields {
      draw-fcolor(x.x,x.y,x.color)
    }
    draw.stroke(fopbot-grid-stroke-width + if darkmode {black.lighten(30%)} else {white.darken(30%)})
    draw.grid((0,0), (width, height))
    draw.stroke(if darkmode {white} else {black})
    draw.rect((0,0), (width, height))

    for x in items {
      draw-item(x)
    }
  })
}

#let robot(x: 0, y: 0, ty: bots.triangle_blue, dir: "up", ..args) = {
  let x = args.pos().at(0, default: x)
  let y = args.pos().at(1, default: y)
  let ty = args.pos().at(2, default: ty)
  let dir = args.pos().at(3, default: dir)
  let ty = if type(ty) == dictionary and "on" in ty {
    ty.on
  } else if type(ty) == content {
    ty
  } else if type(ty) == path {
    image(ty)
  }
  let dirs = (up: 0deg, right: 90deg, down: 180deg, left: 270deg)

  metadata((type: "robot", x: x, y: y, img: ty, rot: dirs.at(dir)))
}

#let coins(x: 0, y: 0, count: 1, ..args) = {
  let x = args.pos().at(0, default: x)
  let y = args.pos().at(1, default: y)
  let count = args.pos().at(2, default: count)
  metadata((type: "coin", x: x, y: y, count: count))
}

#let hwall(x: 0, y: 0, ..args) = {
  let x = args.pos().at(0, default: x)
  let y = args.pos().at(1, default: y)
  metadata((type: "wall", x: x, y: y, horizontal: true))
}

#let vwall(x: 0, y: 0, ..args) = {
  let x = args.pos().at(0, default: x)
  let y = args.pos().at(1, default: y)
  metadata((type: "wall", x: x, y: y, horizontal: false))
}

#let colorfield(x: 0, y: 0, color: red, ..args) = {
  let x = args.pos().at(0, default: x)
  let y = args.pos().at(1, default: y)
  let col = args.pos().at(2, default: color)
  metadata((type: "color", x: x, y: y, color: col))
}

#let raw(fun) = {
  metadata((type: "raw", fun: fun))
}