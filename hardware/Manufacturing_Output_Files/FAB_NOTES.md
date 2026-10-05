# Fabrication and Assembly Notes — Automotive BLE-CAN Module

These notes accompany the Gerber/drill package in `gerbers_drill_files/` and are part
of the manufacturing data. Requirements here are mandatory unless marked informative.

## 1. Board and stackup

| Parameter | Value |
| --- | --- |
| Finished thickness | 1.58 mm ± 10% |
| Layer count | 4 (F.Cu / In1.Cu / In2.Cu / B.Cu), 35 µm (1 oz) each |
| Dielectric 1 (F.Cu–In1.Cu) | 0.11 mm 2116 prepreg, Er ≈ 4.29 |
| Core (In1.Cu–In2.Cu) | 1.2 mm FR4, Er ≈ 4.6 |
| Dielectric 3 (In2.Cu–B.Cu) | 0.11 mm 2116 prepreg, Er ≈ 4.29 |
| Surface finish | HAL lead-free |
| Soldermask | Both sides, green or fab standard |
| Silkscreen | Both sides, white |

Layer roles: F.Cu signal/components, In1.Cu continuous GND reference (do not modify),
In2.Cu power distribution, B.Cu ground pour and stitching.

## 2. Controlled impedance — REQUIRED

**2.4 GHz RF path (F.Cu, referenced to In1.Cu GND):** the antenna feed from the MCU
(U201 pin 39) through the matching network (C214, L202, C216), band-pass filter
(FLT201), to the U.FL connector (J201) is designed as a **50 ohm single-ended
microstrip**. As drawn, the trace width is 0.18 mm over the 0.11 mm 2116 prepreg.

- Target: **50 ohm ± 10 %** single-ended.
- The fab shall confirm the stackup achieves this at the drawn 0.18 mm width, or
  advise the adjusted width/prepreg required. Any width change must be agreed
  before tooling; do not resize the trace unilaterally.
- Provide an impedance test coupon on the production panel and an impedance
  report with the shipment.
- Dielectric constraints in the Gerber job file are binding for this requirement
  (`dielectric_constraints: yes`).

**CAN differential pair (informative, no coupon required):** `CAN_P/CAN_N` and
`CAN_BUS_P/CAN_BUS_N` form a differential pair with a 120 ohm nominal bus
impedance. The on-board run is a short stub (< 20 mm) on a terminated bus, so
formal differential impedance control is **not** required; standard tolerances
apply. Do not reroute or thin these traces.

## 3. Conformal coating — REQUIRED

The assembled board **must receive a permanent polymer conformal coating** (acrylic
or equivalent, applied per IPC-CC-830). Electrical spacing in the 9–36 V input
section is designed to IPC-2221 Table 6-1 row **B4** (external conductors *with*
permanent polymer coating); the bare, uncoated board does **not** meet the B2
spacing row for 31–50 V and must not be put into service uncoated.

Mask (keep free of coating):

- J101 (power terminal block), J301 (CAN terminal block), J401 (battery connector)
- J201 U.FL RF connector
- J202 Tag-Connect programming footprint
- Test points TP101, TP102, TP103, TP401, TP402, TP403
- Mounting holes H1–H4 (grounding contact surfaces)

## 4. Assembly

- All components on the top side (F.Cu); single-sided reflow.
- Three fiducials (FM1–FM3); placement data in `CPL-files/`.
- Exposed-pad devices U101, U102, U201, U301: thermal-via-in-pad present; standard
  paste windowing per the supplied paste layer. X-ray or AOI inspection of the
  U301 (VQFN-20) exposed pad is requested on first articles (see project DFMEA
  item CAN-003).
- DNP parts (do not fit): C210, C211, C309, R302, R303 — see BOM.
