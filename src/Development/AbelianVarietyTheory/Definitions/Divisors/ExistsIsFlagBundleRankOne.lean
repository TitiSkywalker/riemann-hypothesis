module

public import Development.AbelianVarietyTheory.Definitions.Divisors.IsIsoGenResMapSmulHom
public import Development.AbelianVarietyTheory.Definitions.Divisors.SlopeTestRemainingChoices
import Development.AbelianVarietyTheory.Definitions.AutomorphicMembership.AmpleOnAbelianBase
import Development.AbelianVarietyTheory.Definitions.Divisors.FirstChernLeviEqConstant
import Development.AbelianVarietyTheory.Definitions.Divisors.IsLimDeg
import Development.AbelianVarietyTheory.Definitions.Divisors.NefFibOfIsNef
import Formalism.SharpRestriction.Divisibility.WeightThresholdDefs

@[expose] public section


noncomputable section

open CategoryTheory AlgebraicGeometry NumberField MvPolynomial Filter Topology
open ReciprocityTheory.ChartRestriction.G ReciprocityTheory.ChartRestriction.G.Semi ReciprocityTheory.ChartRestriction.G.Geo.Tor
open GlobalTheory.ArInt GlobalTheory.VB

namespace GlobalTheory.CovTest

open Formalism.BasicNotions Formalism.MainNotions Formalism.BasicNotions.DV Formalism.DegreeFormula Formalism.MainNotions.WeightThresholdDefs GlobalTheory.FlagPoly GlobalTheory.FlagAr GlobalTheory.Mean4 GlobalTheory.Mean4O GlobalTheory.ShFam.Pad

def rkB (ι : Type) (N j : ℕ) (a : ι × Bool) : ℕ := cond a.2 j (N - j)

end GlobalTheory.CovTest

end
