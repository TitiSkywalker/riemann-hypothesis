module

public import Formalism.LocalRingCardinality.RhoDetPrimeEqMuTildeMulChiPow
public import Formalism.SharpRestriction.LevelLetterCocycles.QuotientHomNonvanishingBound

@[expose] public section

noncomputable section

namespace GlobalTheory.RowCopy

open Formalism.BasicNotions Formalism.MainNotions Formalism.MainNotions.N Formalism.ConjugateSelfDual ReciprocityTheory.Gal Polynomial NumberField IsDedekindDomain

def RowSize (D : D7) : Prop :=
  ∀ (i : D.nd.Loc) (σ : D.what₂.FT), D.what₂.isot (D.nd.j i) σ ≠ ⊥ →
    ∀ w : PlE D.host, IsSplitPl D.host w → D.naut.unr (D.naut.locW i σ w) →
    ∀ α ∈ D.naut.frobEig (D.naut.locW i σ w),
      ‖α‖ < ((Ideal.absNorm w.asIdeal : ℕ) : ℝ) ^ (((D.R.t : ℝ) - 1) / 2)

def HeckeSplitOne (D : D7) : Prop :=
  ∀ ν ν' : D.naut.CG 1,
    (∀ᶠ w in Filter.cofinite, IsSplitPl D.host w → D.naut.locG ν w = D.naut.locG ν' w) → ν = ν'

def ThetaOne (D : D7) : Prop :=
  ∀ (i : D.nd.Loc) (σ : D.what₂.FT), D.what₂.isot (D.nd.j i) σ ≠ ⊥ → ∃ P, thetaOf D.nd D.naut i σ P

def LamPos (D : D7) (μ : D.what₂.Tup) (j : ℕ) : Prop :=
  ∀ σ : D.what₂.FT,
    (∀ f ∈ D.what₂.isot j σ, D.what₂.thetaP μ j (D.what₂.thetaT μ j f) = ((D.what₂.lamP μ j σ : ℝ) : ℂ) • f) ∧
    (D.what₂.isot j σ ≠ ⊥ → 0 < D.what₂.lamP μ j σ)

def RbarTie (D : D7) : Prop :=
  (∀ (σ : D.what₂.FT) (lam : D.what₂.places.Pl), (∃ a : D.nd.Loc, D.nd.w a = lam) →
    Formalism.MainNotions.N.IsSSRep (D.ntypes.rbar σ lam)) ∧
  ∀ (i : D.nd.Loc) (σ : D.what₂.FT), D.what₂.isot (D.nd.j i) σ ≠ ⊥ → D.nd.goodRow σ →
    ∀ (Sig : List (Part D.naut.CG)) (ρ : Formalism.ConjugateSelfDual.G D.host.E D.nd.Om →* GL (Fin D.R.r) (D.nd.O i)),
      Formalism.MainNotions.N.HasParamW D.nd D.naut i σ Sig → Formalism.MainNotions.N.IsRepOfSig D.nd D.naut i Sig ρ →
      ∀ g, (((D.ntypes.rbar σ (D.nd.w i) g : GL _ _) : Matrix (Fin D.R.r) (Fin D.R.r) _).charpoly).map
          (Formalism.MainNotions.N.fbCast (D.nd.w_l i) (D.what₂.places.resChar_prime (D.nd.w i)) (D.nd.lPrime i).out).toRingHom =
        ((ρ g : GL _ _) : Matrix (Fin D.R.r) (Fin D.R.r) (D.nd.O i)).charpoly.map
          ((D.naut.kFbar i).comp (IsLocalRing.residue (D.nd.O i)))

def TempCSD (D : D7) : Prop :=
  ∀ (a : ℕ) (π : D.naut.CG a), 1 ≤ a → D.naut.csd π → D.naut.ralg π → ∀ w, D.naut.tempered (D.naut.locG π w)

variable {R : Ranks} {H : Host R} {what₂ : Rows.Data R} (N : NData R H what₂) (A : NAut N)

def ParUpRec (i : N.Loc) : Prop :=
  ∀ x ∈ ZgoodN N A i, ∀ Sig, HasParamX N A i x Sig →
    (MjSig N A i Sig).map (what₂.thetaT (N.mu i) (N.j i)) ≤ eigC N A i x

def DownMemRec (i : N.Loc) : Prop :=
  ∀ x ∈ ZgoodN N A i, ∀ Sig, HasParamX N A i x Sig →
    (eigC N A i x).map (what₂.thetaP (N.mu i) (N.j i)) ≤ MjSig N A i Sig

def TypeNZRec (i : N.Loc) : Prop :=
  ∀ x ∈ ZgoodN N A i, ∀ F ∈ eigC N A i x, what₂.thetaP (N.mu i) (N.j i) F = 0 → F = 0

def GoodPartRec (i : N.Loc) : Prop :=
  goodPartM N A i = ⨆ x ∈ ZgoodN N A i, ⨆ Sig ∈ {Sig | HasParamX N A i x Sig}, MjSig N A i Sig

def TieLab : Prop :=
  (∀ (k : Fin 2) (v : N.PlG k) (a : A.LP (A.plGw k v)) (s : ℝ),
    A.items₂ k (A.plGw k v) (A.lpTw a s) = A.items₂ k (A.plGw k v) a) ∧
  ∀ (k : Fin 2) (v : N.PlG k) (a : A.LP (A.plGw k v)), (A.items₂ k (A.plGw k v) a).natDegree ≤ A.lpDim a

def IsobaricCuspidalStrongMultiplicityOne : Prop :=
  ∀ Pa Pa' : List (Part A.CG), (∀ p ∈ Pa, 1 ≤ p.a ∧ p.d = 1) → (∀ p ∈ Pa', 1 ≤ p.a ∧ p.d = 1) →
    (∀ᶠ w in Filter.cofinite, isoLoc N A Pa w = isoLoc N A Pa' w) → Pa.Perm Pa'

def IsobaricDiscreteSelfDualStrongMultiplicityOne : Prop :=
  ∀ Pa Pa' : List (Part A.CG), (∀ p ∈ Pa, 1 ≤ p.a ∧ 1 ≤ p.d ∧ A.csd p.π) →
    (∀ p ∈ Pa', 1 ≤ p.a ∧ 1 ≤ p.d ∧ A.csd p.π) →
    (∀ᶠ w in Filter.cofinite, isoLoc N A Pa w = isoLoc N A Pa' w) → Pa.Perm Pa'

end GlobalTheory.RowCopy
