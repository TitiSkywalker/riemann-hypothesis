module

public import Formalism.SharpRestriction.Divisibility.SchurIrreducible

@[expose] public section

noncomputable section

open Formalism.BasicNotions Formalism.BasicNotions.TH Formalism.MainNotions.SchurIrreducible

namespace Formalism.L2.Theta

def NoncompactGapAtLeastRange (p q : ℕ) (lam : Ix p q → ℚ) : Prop := ∃ h : ℝ, GapGe lam h ∧ rangeOfSeventhSum p q ≤ h

end Formalism.L2.Theta

end
