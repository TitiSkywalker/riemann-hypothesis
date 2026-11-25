module

public import Development.AutomorphicArithmetic.AutomorphicVarieties.IdeleGenerators.ConstSmall
public import Development.AutomorphicArithmetic.AutomorphicVarieties.IdeleGenerators.HolomorphicIrreducibility.UnitFam
import Mathlib.Tactic.Linter.HaveILetI

@[expose] public section

open Formalism.ConjugateSelfDual CongruenceSubgroup UpperHalfPlane UpperTheory.V.Af
open scoped MatrixGroups ModularForm

namespace UpperTheory.V.Sd

private theorem coef_smul {N : ℕ} {k : ℤ} (c : ℂ) (f : ModularForm (Gamma1 N) k) (n : ℕ) :
    coef (c • (f : ℍ → ℂ)) n = c * coef f n := by
  unfold coef
  rw [ModularForm.qExpansion_smul one_pos
    (by rw [CongruenceSubgroup.strictPeriods_Gamma1]; exact AddSubgroup.mem_zmultiples 1) c f]
  simp

private theorem coef_comb {N : ℕ} {k : ℤ} {I : Type} (s : Finset I) (c : I → ℂ) (f : I → ModularForm (Gamma1 N) k) (n : ℕ) :
    coef (∑ a ∈ s, c a • f a : ModularForm (Gamma1 N) k) n = ∑ a ∈ s, c a * coef (f a) n := by
  classical
  induction s using Finset.induction_on with
  | empty => simp [coef, qExpansion_zero]
  | insert a s ha ih =>
    rw [Finset.sum_insert ha, Finset.sum_insert ha, ← ih, ← coef_smul]
    unfold coef
    have hper : (1 : ℝ) ∈
        (Subgroup.map (Matrix.SpecialLinearGroup.mapGL ℝ) (Gamma1 N)).strictPeriods := by
      rw [CongruenceSubgroup.strictPeriods_Gamma1]
      exact AddSubgroup.mem_zmultiples 1
    rw [FunLike.coe_add, ModularForm.qExpansion_add one_pos hper, map_add (f := _),
      FunLike.coe_smul]

private theorem slash_neg_one (k : ℕ) (f : ℍ → ℂ) : f ∣[(k : ℤ)] (-1 : SL(2, ℤ)) = ((-1 : ℂ) ^ k) • f := by
  ext τ
  rw [ModularForm.SL_slash_apply]
  have h : Matrix.SpecialLinearGroup.toGL (-1 : SL(2, ℝ)) = -1 := by
    ext i j
    simp
  simp
  rw [h, denom_neg, denom_one, ← inv_pow, inv_neg, inv_one, mul_comm]

private theorem norm_two (l : ℕ) [Fact l.Prime] (hl : l ≠ 2) : ‖(2 : Qbar l)‖ = 1 := by
  have h2 : (2 : Qbar l) = algebraMap ℚ_[l] (PadicAlgCl l) ((2 : ℕ) : ℚ_[l]) := by
    rw [Nat.cast_ofNat, map_ofNat]
  rw [h2, PadicAlgCl.norm_extends, Padic.norm_natCast_eq_one_iff]
  exact (Nat.coprime_primes (Fact.out) Nat.prime_two).mpr hl

private theorem norm_chi {l : ℕ} [Fact l.Prime] (ι : Qbar l ≃+* ℂ) {N : ℕ} [NeZero N] (χ : DirichletCharacter ℂ N)
    (a : (ZMod N)ˣ) : ‖ι.symm (χ (a : ZMod N))‖ = 1 := by
  have hpow : (ι.symm (χ (a : ZMod N))) ^ orderOf a = 1 := by
    rw [← map_pow, ← map_pow, ← Units.val_pow_eq_pow_val, pow_orderOf_eq_one, Units.val_one, map_one, map_one]
  have hn : orderOf a ≠ 0 := (orderOf_pos a).ne'
  have hnorm : ‖ι.symm (χ (a : ZMod N))‖ ^ orderOf a = 1 := by rw [← norm_pow, hpow, norm_one]
  exact (pow_eq_one_iff_of_nonneg (norm_nonneg _) hn).mp hnorm

end UpperTheory.V.Sd

