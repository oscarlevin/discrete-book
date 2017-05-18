(TeX-add-style-hook "discretemath"
 (lambda ()
    (TeX-add-symbols
     "ansfilename")
    (TeX-run-style-hooks
     "discretebook"
     ""
     "latex2e"
     "bk12"
     "book"
     "oneside"
     "12pt"
     "front_matter"
     "chapters/Logic"
     "chapters/Quantifiers_Sets"
     "exercises/Logic"
     "chapters/GraphTheory"
     "exercises/GraphTheory"
     "chapters/Counting"
     "chapters/CombinatorialProofs"
     "chapters/AdvancedCounting"
     "exercises/Counting"
     "chapters/Sequences"
     "chapters/GeneratingFunctions"
     "exercises/Sequences"
     "chapters/Induction"
     "exercises/Induction"
     "chapters/NumberTheory"
     "exercises/NumberTheory")))

