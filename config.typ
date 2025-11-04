#import "@preview/hydra:0.6.1": hydra
#import "@preview/pillar:0.3.3"
#import "@preview/drafting:0.2.2": *
#import "@preview/icu-datetime:0.1.2": fmt-date

#let parse-env(content) = {
  let env = (:)
  for line in content.split("\n") {
    let line = line.trim()
    if line.len() > 0 and not line.starts-with("#") {
      let parts = line.split("=")
      if parts.len() >= 2 {
        let key = parts.at(0).trim()
        let value = parts.slice(1).join("=").trim()
        if value.starts-with("\"") and value.ends-with("\"") {
          value = value.slice(1, -1)
        }
        env.insert(key, value)
      }
    }
  }
  env
}

#let env = parse-env(read(".env"))

#let makework(
  title: "Signale & Systeme",
  subtitle: "Analyse eines Systems",
  matriculation_number: env.at("MATRICULATION_NUMBER"),
  lecturer: "apl. Prof. Dr. Lutz Groell",
  course: "",
  system: "",
  date: fmt-date(datetime.today(), locale: "de"),
  spacing: (above: 30pt, below: 20pt),
) = {
  let meta = {
    set text(size: 1.1em)
    align(center)[
      #set par(justify: false)

      *Matrikelnr.* #matriculation_number\
      *Dozent* #lecturer\
      *Kurs* #course\
      *System* #system\
    ]
  }

  place(top + center, scope: "parent", float: true, align(center)[
    #v(spacing.above)
    #block(text(weight: 400, 18pt, [*#title*]))
    #v(1em, weak: true)
    #block(text(weight: 400, 18pt, [*#subtitle*]))
    #v(16em, weak: true)
    #meta
    #v(20em, weak: true)
    #block(text(weight: 400, 1.1em, date))
    #v(spacing.below)
  ])
  pagebreak()
}

#let fig-outline(
  title: "Liste der Abbildungen",
  target: figure.where(kind: image),
) = {
  outline(target: target, title: title)
  pagebreak(weak: true)
}

#let reset-eq-counter = it => {
  counter(math.equation).update(0)
  it
}

#let outlined = state("outlined", false)

#let space = v(1.5em, weak: true)

#let work(
  eq-chapterwise: true,
  eq-numbering: "(1a)",
  lang: "de",
  page-paper: "a4",
  cols: none,
  fig-caption-width: 75%,
  header-alternating: true,
  header-display: false,
  header-first-page: 1,
  header-line-stroke: .65pt,
  header-title: none,
  heading-numbering: "1.1.1",
  list-bullet-indent: 1.5em,
  list-numbered-indent: 1.5em,
  page-margins: (left: 1.25in, right: 1.25in, top: 1.25in, bottom: 1.25in),
  page-numbering-align: center,
  page-numbering: "1",
  par-first-line-indent: 0em,
  par-justify: true,
  par-spacing: 0.55em,
  text-font: "New Computer Modern",
  text-size: 10pt,
  content,
) = {
  set page(
    margin: page-margins,
    numbering: page-numbering,
    number-align: page-numbering-align,
    paper: page-paper,
  )
  set text(font: text-font, lang: lang, size: text-size)
  set par(
    leading: 0.55em,
    spacing: par-spacing,
    first-line-indent: par-first-line-indent,
    justify: par-justify,
  )
  show heading: set block(above: 1.4em, below: 1em)
  show math.equation: set block(above: 0.8em, below: 0.8em)
  show figure: set block(above: 2em, below: 2em)

  let chapterwise-numbering = (..num) => numbering(eq-numbering, counter(heading).get().first(), num.pos().first())
  show heading.where(level: 1): if eq-chapterwise { reset-eq-counter } else {
    it => it
  }

  set math.equation(numbering: eq-numbering) if not eq-chapterwise
  set math.equation(numbering: chapterwise-numbering) if eq-chapterwise

  set heading(numbering: heading-numbering, supplement: [Kapitel])
  set enum(
    indent: list-numbered-indent,
    spacing: 0.8em,
    tight: true,
  )
  set list(indent: list-bullet-indent)
  show outline.entry.where(level: 1): {
    it => link(it.element.location(), it.indented(
      strong(it.prefix()),
      strong((it.body()) + h(1fr) + it.page()),
      gap: 0.5em,
    ))
  }
  show outline: it => {
    outlined.update(true)
    it
    outlined.update(false)
    pagebreak()
  }

  show outline.where(target: figure.where(kind: image)): it => {
    show outline.entry.where(level: 1): {
      it => link(it.element.location(), it.indented(strong(it.prefix()), it.inner()))
    }
    it
  }

  show outline.where(target: figure.where(kind: table)): it => {
    show outline.entry.where(level: 1): {
      it => link(it.element.location(), it.indented(strong(it.prefix()), it.inner()))
    }
    it
  }

  // LATEX Code font
  show raw: set text(
    size: 10pt,
    font: ("CMU Typewriter Text", "DejaVu Sans Mono"),
  )

  show figure.where(kind: table): set figure(
    supplement: [Tabelle],
    numbering: "1",
  ) if lang == "de"
  show figure.where(kind: image): set figure(
    supplement: [Abbildung],
    numbering: "1",
  ) if lang == "de"
  show figure.where(kind: table): set figure.caption(position: top)

  set table(stroke: none, gutter: auto, fill: none)

  show figure.caption: it => {
    set par(justify: true)
    let prefix = {
      it.supplement + " " + context it.counter.display(it.numbering) + ": "
    }
    let cap = {
      prefix
      it.body
    }
    block(width: fig-caption-width, cap)
  }

  set page(header: header-content) if header-display

  if cols != none {
    show: rest => columns(cols, rest)
    content
  } else { content }
}

#let caution-rect = rect.with(inset: 1em, radius: 0.5em)

#let codefigure(body, caption: none, reference: none) = {
  show figure: it => [
    #set align(right)
    #set block(above: 0.8em, below: 1.4em)
    #block(width: 100% - 2em)[
      #set align(left)
      #it
    ]
  ]
  [
    #figure(
      body,
      caption: caption,
      outlined: true,
      supplement: [Matlab],
    )
    #if reference != none {
      label(reference)
    }
  ]
}

#let include-chapters-with-break(..paths) = {
  for path in paths.pos() {
    include path
    pagebreak(weak: true)
  }
}
