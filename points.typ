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
    
    query(metadata)
      .map(x => x.value)
      .filter(x => "task" in x and "points" in x)
      .filter(x => x.task.len() == depth.len() + 1 and x.task.slice(0, -1) == depth)
      .map(x => x.points)
      .sum(default: 0)
  } else {
    assert.eq(type(p), int, message: "Expected points to be of type int")
    p
  }
  __display-points(points)
  metadata((task: depth, points: points))
}
