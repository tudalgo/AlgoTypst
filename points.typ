#let __display-points(p) = {
  let te = if p == 1 {
    [#p Punkt]
  } else {
    [#p Punkte]
  }
  if state("algotypst").get().draft {
    text(fill: red, te)
  } else {
    te
  }
}


#let sum-points() = context {
  let p = query(metadata)
    .map(x => x.value)
    .filter(x => "task" in x and "points" in x)
    .filter(x => x.task.len() == 1)
    .map(x => x.points)
    .sum(default: 0)
  __display-points(p)
}

#let points(p) = context {
  h(1fr)
  let depth = counter(heading).get()
  let points = if p == auto {
    let last-heading = query(metadata)
      .filter(x => "task" in x.value and "points" in x.value)
      .filter(x => x.value.task == depth)
      .map(x => x.location())
      .first(default: none)

    let sel = if last-heading != none {
      selector(metadata).after(last-heading, inclusive: false)
    } else {
      metadata
    }

    query(sel)
      .map(x => x.value)
      .filter(x => ("task", "points", "is-auto").all(y => y in x))
      .filter(x => x.task.len() >= depth.len() and x.task.slice(0, depth.len()) == depth and not x.is-auto)
      .map(x => x.points)
      .sum(default: 0)
  } else {
    assert.eq(type(p), int, message: "Expected points to be of type int or auto")
    p
  }
  __display-points(points)
  metadata((task: depth, points: points, is-auto: p == auto))
}
