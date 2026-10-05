# Automotive BLE-CAN Module — Design FMEA

**Document status:** Draft for design review
**Revision:** 1.0 (supersedes Rev 0.1, which covered the CAN interface only)
**Date:** 2026-09-30
**Designer:** Shivam Tiwari
**Scope:** Whole module — vehicle power input, battery backup, CAN interface, BLE
subsystem, RF, manufacturing, mechanical and firmware bring-up
**Register:** `DFMEA_REGISTER.csv` (38 items, sorted by descending RPN)
**Design under analysis:** `hardware/BLE-CAN-module.kicad_sch` /
`.kicad_pcb`, KiCad 10.0.6

## 1. Rating method

- **Severity (S):** 1 = negligible; 10 = hazardous or regulatory impact.
- **Occurrence (O):** 1 = remote; 10 = frequent.
- **Detection (D):** 1 = almost certain detection before release; 10 = unlikely
  to be detected before the field.
- **RPN = S × O × D.** RPN drives prioritisation but does **not** override a high
  severity: any item with S ≥ 8 is treated as release-relevant regardless of RPN.
- Target (residual) ratings are goals, valid only once the listed closure
  evidence is approved. Severity is never reduced by an action — only occurrence
  and detection are.

Ratings are preliminary and must be re-baselined against project's approved
DFMEA scoring matrix when one is adopted.

A note on occurrence scoring: items whose cause is *an unmeasured assumption*
(PWR-004, RF-001, RF-003) carry a deliberately high occurrence, because the
design has no evidence either way. Items where a datasheet-specified mitigation
is already implemented (BAT-004, CAN-004) carry a low occurrence.

## 2. Coverage of project failure modes

| Failure mode | Items |
| --- | --- |
| Input overvoltage | PWR-001 |
| Reverse battery | PWR-002 (vehicle), BAT-001 / MEC-001 (pack) |
| Regulator thermal stress | THM-001 (TCAN4550), THM-002 (U101/U102) |
| Battery leakage or improper charging | BAT-002, BAT-003, BAT-005 |
| CAN bus short / open | CAN-004 (short), CAN-005 (termination/open) |
| ESD damage | ESD-001 (bus), ESD-002 (handling/debug) |
| BLE range loss | RF-001, RF-002, RF-005 |
| Oscillator failure | CAN-002 (40 MHz), RF-003 (48 MHz), RF-004 (32.768 kHz) |
| Poor solderability | MFG-003, CAN-003, CAN-007 |
| Wrong connector insertion | MEC-001, MEC-002 |
| Firmware / debug bring-up | CAN-001, FW-001, FW-002, FW-003 |

Additional design-specific items not on that list: PWR-003 (crank boundary),
PWR-004 (electrolytic wear-out), PWR-005 (coating dependency), PWR-006 (parked
current), BAT-004 (ORing lockout corner), CAN-006 (VIO out of spec in backup),
CAN-008 (common-mode emissions), MEC-003 (vibration), MFG-001/002 (unreleased
BOM items), MFG-004 (DNP variant control).

**Distribution:** 38 items — PWR 6, CAN 8, BAT 5, RF 5, MFG 4, MEC 3, FW 3,
ESD 2, THM 2. Two are design-action-complete; 36 remain open.

## 3. Release gates

The design is **not** ready for production release until these close. Each is a
hard gate, not a recommendation.

### Blocks fabrication

- **CAN-007 (RPN 192)** — L301's land pattern is a generic ACM4532, not derived
  from the TDK ACT45B drawing. Pad geometry *and* terminal numbering must be
  confirmed. If ACT45B pairs its windings differently from the assumed 1–4 / 2–3,
  the schematic symbol variant must be swapped and the netlist re-verified.
- **MFG-001 (RPN 63, O = 9)** — X301 has no manufacturer part number. Low RPN,
  but the occurrence is 9 because the board simply cannot be built. Its frequency
  tolerance also gates CAN-002.
- **MFG-002 (RPN 96)** — eight further line items without MPNs, of which
  L202/C214/C216 are RF-critical.

### Blocks production schematic release

- **CAN-001 (RPN 224)** — nWKRQ drives an internal 3.6 V push-pull rail before
  firmware can reconfigure it. Firmware alone cannot protect the interval between
  power-up and configuration; a hardware isolating buffer is required.

### Blocks production build

- **PWR-005 (RPN 168)** — conformal coating is load-bearing, not cosmetic. The
  input section is designed to IPC-2221 row **B4** (coated). Uncoated, it fails
  row B2 in 118 places with a minimum spacing of 0.2005 mm against the 0.6 mm
  requirement. Coating must appear on the assembly drawing and purchase order.

### Close after EVT, before production freeze

- **CAN-002, RF-003, RF-004** — all three oscillators are running on assumed
  stray capacitance. None can be closed by review; each needs measurement on
  assembled hardware.

## 4. The items that most deserve scrutiny

### 4.1 CAN-001 — nWKRQ power-domain conflict (RPN 224, carried from Rev 0.1)

Not merely a firmware setting. At reset, before software can write to the
TCAN4550, nWKRQ drives from an internal 3.6 V source. The CC2340R53 input limit
follows its own VDDS rail. When the CAN device is powered while the MCU rail is
absent or low — precisely what happens in battery backup — the direct connection
can inject current into an MCU pin. R307's 100 kΩ pull-up does not isolate a
push-pull driver.

A buffer with a 5.5 V-tolerant input and `Ioff` / partial-power-down protection
breaks the path while preserving an MCU-domain output level. Firmware
configuration (register `0x0800` bit 19) remains necessary, but is then no longer
the *only* protection. This is the one item where the schematic, as drawn, has a
defect rather than an unverified assumption.

### 4.2 PWR-004 — the electrolytic is the service-life limit (RPN 210)

C101 is the only wet electrolytic on the board, and it sits on a rail that is
energised whenever the vehicle battery is connected. The Panasonic FK series is
rated 105 °C / 2000 h — roughly one year of continuous operation at high ambient.
Every other component on the board will outlive it by an order of magnitude.

The schematic note claims AEC-Q200; that claim was **not** confirmed against the
Panasonic datasheet during this review and is recorded as unverified in the BOM.
Note also that C101 is not decorative: it is the damping partner to R101, so
removing it in favour of ceramics requires the input filter damping to be
re-checked.

### 4.3 RF-001 — the match is not where the reference design puts it (RPN 168)

Measured from the layout: the U201 ANT pad is at x = 132.0 mm and the first
matching element at x = 138.29 mm. That is **6.29 mm** of line ahead of the
network. On this stackup at 2.44 GHz (ε_eff ≈ 3.2, λ_g ≈ 69 mm) it is about
**33° of electrical length**, enough to rotate the source impedance materially.

The values themselves (L202 2.8 nH, C214/C216 1.5 pF) are correct — they come
from TI's LP-EM-CC2340R53 reference. But on that reference the parts sit
immediately at the pin. Copying the values without copying the geometry does not
reproduce the match. Compounding it, RF-002 notes the feed is routed at 0.18 mm
(≈55.6 Ω) rather than the ~0.215 mm needed for 50 Ω.

This is the most likely single cause of disappointing BLE range on first
articles, and it is not detectable without a VNA.

### 4.4 BAT-004 — a corner that was designed out (RPN 64)

Included deliberately as an example of a risk that was closed at design time
rather than deferred. The LM66100-Q1 datasheet §9.2.2 documents that two
cross-coupled ORing devices will *both* switch off if their inputs sit at the
same voltage for an extended period — which would collapse `+3V3_SYS` entirely.

The rails are offset by 300 mV (3.3 V vehicle, 3.0 V battery) against an 80 mV
comparator window. Worst-case tolerance still leaves 174 mV. **This is the reason
U402 is a 3.0 V part and not a 3.3 V part** — a choice that looks arbitrary in
the BOM and is in fact the mitigation for this failure mode.

### 4.5 CAN-006 — an accepted out-of-specification condition (RPN 96)

In battery backup, TCAN4550 VIO sits at ~3.0 V against a recommended minimum of
3.135 V. It is above the 2.45–2.6 V UVIO threshold, so the device does not fault
— it simply operates outside its recommended window.

This is accepted rather than fixed, because the alternative is worse: powering
VIO from the vehicle rail alone would create a powered-MCU / unpowered-VIO
partial-power-down condition on the SPI pins, which is the same mechanism as
CAN-001. The mitigation is behavioural — firmware must not drive SPI in backup —
and it depends on BAT-005 being closed first so firmware can *tell* it is in
backup.

## 5. Unresolved risks and stated assumptions

Where something could not be closed,
what was assumed is stated.

| # | Open question | What was assumed |
| --- | --- | --- |
| 1 | No vehicle transient specification was supplied | ISO 7637-2 / ISO 16750-2 applicability assumed but **not tested**. D101's 40 V standoff has only 4 V margin over 36 V; its 64.5 V clamp is within the buck's 80 V rating, which is the whole basis for believing the chain survives (PWR-001). |
| 2 | No network topology was supplied | The module is assumed a **stub node**, so R302/R303/C309 are DNP (CAN-005). |
| 3 | No ambient temperature requirement was supplied | 85 °C assumed for thermal work. TCAN4550 Tj ≈ 101 °C at that ambient, by calculation only (THM-001). |
| 4 | No parked-current budget was supplied | ~100–150 µA estimated from datasheet figures, never measured (PWR-006). |
| 5 | Conformal coating is not contractually confirmed | Assumed present; the input-section spacing is only compliant under IPC-2221 B4 (PWR-005). |
| 6 | TDK ACT45B land pattern not obtained | Generic ACM4532 pattern used; winding pairing assumed 1–4 / 2–3 (CAN-007). |
| 7 | PCB stray capacitance never measured | ~1.5 pF assumed at the LSE, ~3 pF at the CAN crystal; the 48 MHz HFXT relies entirely on the MCU internal array with 11.07/7.63 mm asymmetric traces (CAN-002, RF-003, RF-004). |
| 8 | C101 AEC-Q200 status unconfirmed | Schematic claim recorded as unverified; the 2000 h endurance concern stands regardless (PWR-004). |
| 9 | No antenna or enclosure defined | U.FL port only; radiated performance cannot be predicted (RF-005). |
| 10 | Battery pack PCM parameters unspecified | A protected 1S pack is assumed to be always fitted; the board provides no charging and no monitoring (BAT-002). |
| 11 | D102 ratings taken from a schematic note | 200 V / 1 A assumed; IF(AV) and VF at ~90 mA not independently confirmed. |
| 12 | Via-in-pad treatment unspecified | Tenting requested, plugging/filling not specified — a solder-wicking risk on four exposed-pad devices (MFG-003). |

## 6. What changed since Rev 0.1

Rev 0.1 contained three items, all CAN. They are carried forward unchanged in
substance:

- **CAN-003** — TCAN4550 land pattern correction. Design action complete against
  TI drawing 4225320/A; first-article verification still open.
- **CAN-001** — nWKRQ power sequencing. Still open, still blocking.
- **CAN-002** — 40 MHz oscillator characterisation. Still open; now additionally
  notes the asymmetric crystal routing (8.78 mm vs 3.23 mm) as a contributing
  cause, and is explicitly coupled to MFG-001 since the crystal is unselected.

Thirty-five items were added covering power, battery, RF, thermal, ESD,
mechanical, manufacturing and firmware. Two mitigations were **implemented during
this review** and are reflected in the register: D301 was relocated adjacent to
J301 (ESD-001), and L301 was added and placed between the transceiver and the
TVS (CAN-008).

## 7. References

- [TI TCAN4550-Q1 datasheet](https://www.ti.com/lit/ds/symlink/tcan4550-q1.pdf)
- [TI TCAN455x Clock Optimization and Design Guidelines, SLLA549](https://www.ti.com/lit/an/slla549/slla549.pdf)
- [TI SN74LVC1G17-Q1](https://www.ti.com/product/SN74LVC1G17-Q1)
- [TI CC2340R5 datasheet](https://www.ti.com/lit/ds/symlink/cc2340r5.pdf)
- [TI LMR38010-Q1 datasheet](https://www.ti.com/lit/ds/symlink/lmr38010-q1.pdf)
- [TI LM66100-Q1 datasheet](https://www.ti.com/lit/ds/symlink/lm66100-q1.pdf)
- [TI RGY0020A land-pattern drawing 4225320/A](https://www.ti.com/lit/pdf/qfnd041)
- IPC-2221B Table 6-1 (conductor spacing); IPC-A-610 class 2 (void criteria)
- Project: `documentation/architecture/ARCHITECTURE.md`,
  `hardware/Manufacturing_Output_Files/BOM/BOM_NOTES.md`, `hardware/Manufacturing_Output_Files/FAB_NOTES.md`
