#import "style.typ": ziti, zihao
#import "@preview/numbly:0.1.0": numbly

#let no-numbering-first-heading(body) = {
  show heading.where(level: 1): set align(center)
  show heading: set par(justify: false)
  set heading(numbering: none, supplement: auto)
  show heading.where(level: 1): it => {
    set text(
      // 数字用 Times Roman，中文用黑体，均为四号字，加粗
      font: ziti.heiti,
      weight: "bold",
      size: zihao.sanhao,
    )
    set par(
      // 无缩进，行距18磅
      first-line-indent: 0em,
      leading: 18pt,
    )
    //前后间距分别为24磅和6磅
    pagebreak()
    v(24pt)
    it.body
    v(18pt)
  }
  body
}

#let main-text-first-heading(
  doctype: "master",
  twoside: false,
  body,
) = {
  show heading.where(level: 1): set align(center)
  set heading(
    numbering: numbly(
      if doctype == "bachelor" {
        "第{1:一}章 "
      } else { "第{1}章 " },
      "{1}.{2} ",
      "{1}.{2}.{3} ",
      "{1}.{2}.{3}.{4} ",
    ),
  )
  show heading.where(level: 1): it => {
    set text(
      // 数字用 Times Roman，中文用黑体，均为四号字，加粗
      font: ziti.heiti,
      weight: "bold",
      size: zihao.sanhao,
    )
    set par(
      // 无缩进，行距18磅
      first-line-indent: 0em,
      leading: 18pt,
    )
    //前后间距分别为24磅和6磅
    pagebreak(
      weak: true,
      to: if twoside {
        "odd"
      },
    )

    v(24pt)
    counter(heading).display() + h(1em) + it.body
    v(18pt)
  }
  body
}

#let appendix-first-heading(
  doctype: "master",
  twoside: false,
  body,
) = {
  show heading.where(level: 1): set align(center)
  set heading(
    numbering: if doctype == "bachelor" {
      numbly(
        "附录{1} ",
        "{1}.{2} ",
        "{1}.{2}.{3} ",
        "{1}.{2}.{3}.{4} ",
      )
    } else {
      numbly(
        "附录{1:A} ",
        "{1:A}.{2} ",
        "{1:A}.{2}.{3} ",
        "{1:A}.{2}.{3}.{4} ",
      )
    },
    supplement: [附录],
  )
  counter(heading).update(0)
  show heading.where(level: 1): it => {
    set text(
      // 数字用 Times Roman，中文用黑体，均为四号字，加粗
      font: ziti.heiti,
      weight: "bold",
      size: zihao.sanhao,
    )
    set par(
      // 无缩进，行距18磅
      first-line-indent: 0em,
      leading: 18pt,
    )
    //前后间距分别为24磅和6磅
    pagebreak(
      weak: true,
      to: if twoside {
        "odd"
      },
    )

    v(24pt)
    if doctype == "bachelor" {
      it.body + "（" + counter(heading).display() + h(-0.2em) + "）"
    } else {
      counter(heading).display() + h(1em) + it.body
    }
    v(18pt)
  }
  body
}

#let other-heading(
  enable-auto-section-pagebreak: false,
  auto-section-pagebreak-space: 15%,
  body,
) = {
  show heading.where(level: 2): it => {
    set text(
      // 数字用 Times Roman，中文用黑体，均为四号字，加粗
      font: ziti.heiti,
      weight: "bold",
      size: zihao.sihao,
    )
    set par(
      // 无缩进，行距18磅
      first-line-indent: 0em,
      leading: 18pt,
    )

    if enable-auto-section-pagebreak {
      let threshold = auto-section-pagebreak-space
      block(breakable: false, height: threshold)
      v(-threshold, weak: true)
    }

    //前后间距分别为24磅和6磅
    v(12pt)
    counter(heading).display() + h(1em) + it.body
    v(6pt)
  }


  // 设置三级标题
  show heading.where(level: 3): it => {
    set text(
      // 数字用 Times Roman，中文用黑体，均为小四号字，加粗
      font: ziti.heiti,
      weight: "bold",
      size: zihao.xiaosi,
    )
    set par(
      // 无缩进，行距16磅
      first-line-indent: 0em,
      leading: 16pt,
    )

    if enable-auto-section-pagebreak {
      let threshold = auto-section-pagebreak-space
      block(breakable: false, height: threshold)
      v(-threshold, weak: true)
    }

    //前后间距分别为12磅和6磅
    v(9pt)
    counter(heading).display() + h(1em) + it.body
    v(6pt)
  }

  // 设置四级标题
  show heading.where(level: 4): it => {
    set text(
      // 小四号字，不加粗，字体与正文一致
      weight: "regular",
      size: zihao.xiaosi,
    )
    set par(
      // 无缩进，行距16磅
      first-line-indent: 0em,
      leading: 16pt,
    )

    if enable-auto-section-pagebreak {
      let threshold = auto-section-pagebreak-space
      block(breakable: false, height: threshold)
      v(-threshold, weak: true)
    }

    //前后间距分别为6磅和6磅
    v(6pt)
    counter(heading).display() + h(1em) + it.body
    v(6pt)
  }
  body
}
