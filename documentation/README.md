# Documentation

| Project file | Location | Contents |
| --- | --- | --- |
| Architecture description | `architecture/ARCHITECTURE.md` | System design and assumptions (Rev C) |
| Architecture diagram | `architecture/Architecture.png`, `.svg` | Power, CAN, and BLE block diagram |
| Schematic PDF | `schematic/BLE-CAN-module-schematic.pdf` | Five schematic sheets |
| PCB plots and 3D renders | `pcb/` | Board layer plots and 3D views |
| BOM | `../hardware/Manufacturing_Output_Files/BOM/BOM.csv` | 54 line items, cross-checked against the netlist |
| BOM notes | `../hardware/Manufacturing_Output_Files/BOM/BOM_NOTES.md` | Part qualification and open assumptions |
| DFMEA | `dfmea/DFMEA_REPORT.md`, `dfmea/DFMEA_REGISTER.csv` | 38-item module risk review (Rev 1.0) |
| Fabrication notes | `../hardware/Manufacturing_Output_Files/FAB_NOTES.md` | Stackup and assembly requirements |
| Manufacturing outputs | `../hardware/Manufacturing_Output_Files/` | Gerbers, drills, and placement data |

`datasheets/` holds the device datasheets used during design. `references/` holds
the TI reference material the design draws on — the LP-EM-CC2340R53 LaunchPad
schematic (RF matching values) and the TCAN4550 EVM (common-mode choke and bus
protection). Notes on the CC2340R5 library import are in
`../hardware/libraries/README.md`.

## Known gaps

These are design gaps, not documentation gaps — each is tracked in the DFMEA
register with a closure action.

- **Blocks fabrication:** L301's land pattern is unverified against the TDK
  ACT45B drawing (CAN-007); X301 has no manufacturer part number (MFG-001);
  eight further BOM line items have no MPN (MFG-002 / `../hardware/Manufacturing_Output_Files/BOM/BOM_NOTES.md` OA-3).
- **Blocks production schematic release:** the TCAN4550 nWKRQ power-domain
  conflict needs a hardware isolating buffer (CAN-001).
- **Blocks production build:** conformal coating must be contractually
  confirmed — the 9–36 V input spacing is only compliant under IPC-2221 row B4
  (PWR-005, `../hardware/Manufacturing_Output_Files/FAB_NOTES.md`).
- **Needs hardware before it can close:** all three oscillators run on assumed
  stray capacitance (CAN-002, RF-003, RF-004), and the RF match sits 6.3 mm from
  the ANT pin without re-tuning (RF-001).

36 of 38 DFMEA items are open. See `dfmea/DFMEA_REPORT.md` section 5 for the
twelve stated assumptions where a requirement, datasheet detail or layout rule
could not be closed.

## Tooling

The project is in **KiCad 10** file format (schematic `20260306`, PCB `20260206`)
and requires **KiCad 10.0.6 or later**. It will not open in KiCad 9 — KiCad file
formats are forward-compatible only.
