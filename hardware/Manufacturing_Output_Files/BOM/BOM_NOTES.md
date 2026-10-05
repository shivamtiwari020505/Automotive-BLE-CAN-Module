# Bill of Materials — Notes, Qualification Status and Unresolved Assumptions

**Project:** Automotive BLE-CAN Module
**Designer:** Shivam Tiwari
**Design period:** 2026-09-24 to 2026-09-30 | Rev A
**Source of truth:** `hardware/BLE-CAN-module.kicad_sch` (KiCad 10.0.6)
**Machine-readable BOM:** `BOM.csv` in this folder

This document carries the qualification notes, alternatives rationale and open
assumptions for this project. `BOM.csv` holds the same information
per line item; this file groups it so it can be reviewed as a whole.

## 1. Summary

| Metric | Count |
| --- | --- |
| BOM line items | 54 |
| Distinct components on the board | 96 |
| Fitted components | 91 |
| DNP components | 5 (C210, C211, C309, R302, R303) |
| Line items with a committed MPN | 46 of 54 |
| **Line items with NO manufacturer part selected** | **8** |
| Footprint-only items (no part fitted) | 14 |

`BOM.csv` has been cross-checked programmatically against the KiCad netlist
export: all 96 board references are covered exactly once, every `Qty` matches its
reference list, and the DNP set agrees with the schematic.

Footprint-only items, correctly excluded from the BOM but present on the board:
H1–H4 (M2 mounting holes, grounded), FM1–FM3 (fiducials), J202 (Tag-Connect
TC2030 programming footprint — no connector is fitted, the probe is a tool), and
TP101/102/103/401/402/403 (test pads).

## 2. Automotive qualification status

The power path and CAN devices are automotive-qualified. The wireless subsystem
and all electromechanical parts are not. This is a deliberate, documented
trade-off — see `documentation/architecture/ARCHITECTURE.md`, assumptions
section 2.

### Qualified

| Class | Parts | Standard |
| --- | --- | --- |
| Power / interface ICs | LMR38010-Q1, TPS7B81-Q1, TPS7E81-Q1, LM66100-Q1 (×3), TCAN4550-Q1 | AEC-Q100 Grade 1 |
| Discretes | SM8S40CA, PNE20010ER-Q, PMEG10010ELR-Q, PESD2CANFD27V | AEC-Q101 |
| Passives | TDK CGA series MLCC (all), Vishay CRCW-e3 resistors (all), Coilcraft XGL6060, Vishay MFU fuse | AEC-Q200 |

### Not qualified, or unverified

| Part | Status | Consequence and intent |
| --- | --- | --- |
| **CC2340R53E0RKPR** (U201) | **Not AEC-Q100** | No automotive-qualified CC2340 orderable exists. This part, not the Q1 devices around it, bounds the module's environmental rating. Assumed cabin-mount, non-safety telematics use. |
| **C101** Panasonic EEEFK2A220P | **AEC-Q200 claim unverified** | The schematic note claims AEC-Q200; this was not confirmed against the Panasonic datasheet. Regardless of qualification, FK is a 105 °C / 2000 h series — roughly one year of continuous operation at high ambient on an always-on rail. This is the board's dominant wear-out item. |
| **F101** Schurter UMT 250 | Not AEC-Q200 | Industrial fuse. Needs an automotive-qualified equivalent or a documented procurement agreement. |
| **C212, C213** Murata GRM | Not automotive (GRM is the commercial series) | Direct automotive equivalent exists: **GCM1555C1H150JA16**. Recommended swap for production — same size, same value. |
| **X201, X202** Abracon | Commercial, +85 °C max | Rated below the +125 °C of the surrounding automotive ICs. Automotive equivalents identified in `BOM.csv`. |
| **FLT201** TDK DLF162500LT | Commercial | No automotive grade identified for this filter. |
| **J101, J301** Phoenix MPT | Not automotive | Industrial screw terminals — no vibration, sealing or keying rating. Bench/prototype connectors. |
| **J401** JST PH | Not automotive | No locking retention for vibration. |
| **J201** Hirose U.FL | Commercial | ~30 mating cycles, no vibration lock. Acceptable for an internal pigtail, not a serviceable interface. |
| **L301** TDK ACT45B | AEC-Q200 believed, **unverified** | See open item OA-2 below. |

## 3. Unresolved assumptions — ranked

These are the honest gaps. None are hidden in the CSV; each appears against its
line item as well.

**OA-1 — X301 (40 MHz CAN crystal) has no manufacturer part selected.**
The single most significant BOM gap. Frequency tolerance directly drives CAN FD
bit timing, and the crystal's motional parameters determine the final C303/C304
and R311 values. This blocks closure of DFMEA item CAN-002. Candidate parts are
listed in `BOM.csv`; none has been committed.

**OA-2 — L301 footprint is a generic land pattern, not the manufacturer's.**
The choke is assigned `L_CommonModeChoke_Coilank_ACM4532`, a generic 4.5 × 3.2 mm
pattern, while the specified part is a TDK ACT45B. Both the pad geometry **and
the terminal numbering** must be checked against the TDK drawing before
fabrication. The schematic symbol variant (`_1423`) was chosen so windings pair
1–4 and 2–3 to match the assigned footprint; if the ACT45B numbers its windings
differently, the symbol variant must be swapped. This is recorded in the
component's `Purpose` field in the schematic.

**OA-3 — Eight line items have no manufacturer part number.**
All are in the MCU/RF section: L201, L202, C201–C204/C206/C207/C215, C205/C208,
C209, C214/C216, R201, plus X301 (OA-1) and the J201 MPN field. Two matter
electrically rather than commercially:
- **L202 (2.8 nH)** and **C214/C216 (1.5 pF)** are RF matching components. The
  values come from TI's LP-EM-CC2340R53 reference design, but a general-purpose
  part will degrade the match — high-Q RF-grade parts with tight tolerance are
  required.
- **L201 (10 µH)** feeds the CC2340R5 internal DC/DC and must meet TI's
  saturation-current and DCR requirement.

**OA-4 — The RF matching network has not been re-tuned for this board.**
L202/C214/C216 are the TI reference values, but on the LaunchPad those parts sit
immediately at the ANT pin. Here the first matching element is **6.3 mm** from
the pin — about 33° of electrical length at 2.44 GHz — and the network feeds a
TDK low-pass filter into a U.FL connector rather than the reference's tuning pi.
The values are a starting point, not a verified match. VNA verification on an
assembled board is required.

**OA-5 — MLCC derating is assumed from datasheet curves, not measured.**
Several capacitances have datasheet minimums that must survive DC bias,
temperature and aging: TCAN4550 VCCOUT (≥10 µF effective at 5 V, from
C305 + C310 = 44 µF nominal), FLTR (≥300 nF from 470 nF nominal), U402 output
(≥2.2 µF), and the buck output bank (≥20 µF effective at 6.49 V). All are
believed to have margin; none has been bench-verified.

**OA-6 — Crystal load capacitors are provisional.**
C212/C213 (15 pF) assume ~1.5 pF board stray for CL = 9 pF. C303/C304 (10 pF)
assume ~3 pF stray for CL = 8 pF. C210/C211 are DNP because the CC2340R5 internal
cap array is used — but the X48P/X48N traces are long and asymmetric (11.1 mm vs
7.6 mm), so the added stray may prevent the array reaching the 7 pF CL. R311 is
0 Ω for first assembly only. All of these are set on the prototype, per TI SLLA549.

**OA-7 — CAN bus termination topology is an assumption.**
R302/R303/C309 are DNP because the module is assumed to be a **stub node**. If it
is deployed as a bus end node, all three must be fitted together (120.8 Ω). No
network topology requirement was supplied.

**OA-8 — Transient protection is not validated against a pulse standard.**
D101's 40 V standoff leaves limited margin over the 36 V maximum input, and its
64.5 V clamp is within the LMR38010-Q1's 80 V operating / 85 V absolute-maximum
rating. No ISO 7637-2 or ISO 16750-2 pulse testing has been performed, and the
fuse/TVS energy coordination study has not been done.

**OA-9 — VBAT_SENSE is provisioned but not connected.**
R403/R404/C404 form a working divider, but `VBAT_SENSE` and `USING_BATTERY_N`
terminate at unconnected labels — no CC2340 ADC or GPIO is attached, despite 16
free pins. Firmware cannot read battery voltage or determine the active source.

**OA-10 — D102 ratings taken from the schematic note, not the datasheet.**
PNE20010ER-Q is recorded as 200 V / 1 A from the schematic's own annotation.
IF(AV) and the forward drop at the ~90 mA operating current were not
independently confirmed.

## 4. Deliberate design choices visible in the BOM

Worth reading as intent rather than as gaps:

- **U101 is the PFM, spread-spectrum variant** (`LMR38010SQ…`, not `…FSQ…`).
  Chosen for 40 µA non-switching quiescent current — the parked-current budget —
  and for conducted/radiated EMI. The FPWM variant would have been the wrong call.
- **U402 is 3.0 V, not 3.3 V.** The 0.3 V offset below `+3V3_VEH` is what gives
  the LM66100 ORing pair a decisive priority margin and avoids the datasheet's
  documented equal-rails lockout, where both devices switch off.
- **U102 is fed from +6V5_CAN, not VIN.** Dissipation drops to ~64 mW at the
  design load instead of ~0.65 W from a 36 V rail.
- **D101 is bidirectional (CA).** Reverse battery is blocked by the D102 series
  diode rather than clamped, so the fuse does not open on a reverse connection.
- **D301 is 27 V standoff.** Chosen so a CANH/CANL short to a 24 V vehicle rail
  does not put the clamp into conduction.
- **R102/R103 set turn-on near 6.0 V**, below the 9 V specification minimum, to
  ride through crank. The cost is ~25 µA continuous — the largest single fixed
  standby load on the vehicle battery.

## 5. Before fabrication release

1. Select X301 and close OA-1.
2. Verify the L301 land pattern and terminal numbering (OA-2).
3. Assign the eight missing MPNs, with RF-grade parts for L202/C214/C216 (OA-3).
4. Swap C212/C213 to the GCM automotive equivalent.
5. Decide the C101 endurance question — either confirm its qualification and
   accept the 2000 h rating, or move to an automotive hybrid-polymer part.
6. Confirm conformal coating is contracted — the input-section spacing depends
   on it (see `hardware/Manufacturing_Output_Files/FAB_NOTES.md`).
