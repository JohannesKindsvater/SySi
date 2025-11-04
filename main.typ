#import "config.typ": *

#show: work

#makework(
  course: "TINF24B2",
  system: $P T_2 overline(T)^'$,
)
// show table of contents
#outline()

// show list of figures
#fig-outline()

// chapters of your work
#include-chapters-with-break(
  "chapters/procedure_control_engineering.typ",
  "chapters/physical_model.typ",
  "chapters/analysis_of_a_model.typ",
)
