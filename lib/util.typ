#import "@preview/percencode:0.1.0": url-encode
#import "@preview/t4t:0.4.3": def

#let javadoc(package: none, class: none, element: none, title: none, element_title: none, full: false, ..args) = {
  assert(args.pos().len() <= 1, message: "Expected at most one positional argument.")
  if args.pos().len() > 0 {
    let (full,) = args.pos()
    let match = full.match(regex(`((?:[a-z]+\.)+)([A-Z][^#]+)?(?:#(.+))?`.text))
    assert.ne(match, none, message: "Looks like the regex is too primitive, please create an issue.")
    assert.ne(match.captures, 0, message: "Either the regex is too primitive or you did not even pass a package string.")
    package = match.captures.at(0).slice(0, -1)
    class = match.captures.at(1, default: none)
    element = match.captures.at(2, default: none)
  }
  let url-class = def.if-none(class, def: "package-summary")
  let element = def.if-none(element, do: it => "#" + it)
  let element_title = def.if-none(element_title, do: it => "#" + it)
  let url = "https://docs.oracle.com/en/java/javase/21/docs/api/java.base/" + package.replace(".", "/") + "/" + url-class + ".html" + element
  let url = url-encode(url)
  let class = def.if-none(title, def: class)
  let element = if element == none {
    none
  } else if element_title != none {
    element_title
  } else {
    element.replace("<init>", "new")
  }
  link(url, raw(if class == none {
    package
  } else if full {
    package + "." + class + element
  } else {
    class + element
  }))
}