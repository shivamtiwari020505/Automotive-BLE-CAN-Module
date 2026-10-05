# Automotive BLE-CAN Module

A four-layer hardware design that connects a vehicle CAN bus to a Bluetooth Low Energy (BLE) interface. The module accepts a 9–36 V vehicle supply and has a separate input for a protected, externally charged 1-cell backup battery. During backup operation, the BLE section remains powered while CAN is unavailable.

This repository is a design snapshot for review and prototyping. It has not been fabricated or electrically tested, and the open items below must be resolved before a fabrication release.

## Design at a glance

| Item | Design |
| --- | --- |
| Vehicle input | 9–36 V |
| CAN interface | CAN FD controller and transceiver, connected to the MCU over SPI |
| Wireless interface | Bluetooth Low Energy, with a U.FL antenna connection |
| Backup input | Protected 1-cell Li-ion pack, charged externally |
| PCB | 49.5 × 56.9 mm, four layers, single-sided component assembly |
| Design tool | KiCad 10.0.6 or later |

## Open the project

1. Open [`hardware/BLE-CAN-module.kicad_pro`](hardware/BLE-CAN-module.kicad_pro) in KiCad 10.0.6 or later.
2. Keep the entire `hardware/` directory together. Its symbol tables, footprint tables, local libraries, and 3D models use project-relative paths.
3. For a quick review without KiCad, see the [schematic PDF](documentation/schematic/BLE-CAN-module-schematic.pdf), [PCB views](documentation/pcb/), and [architecture diagram](documentation/architecture/Architecture.svg).

## Repository layout

| Path | Contents |
| --- | --- |
| [`hardware/`](hardware/) | Editable KiCad schematic and PCB, project-local libraries and 3D models |
| [`hardware/Manufacturing_Output_Files/`](hardware/Manufacturing_Output_Files/) | Gerbers, drill files, placement data, BOM, and fabrication notes |
| [`documentation/architecture/`](documentation/architecture/) | System architecture and block diagram |
| [`documentation/schematic/`](documentation/schematic/) | Schematic PDF |
| [`documentation/pcb/`](documentation/pcb/) | PCB layer plot and 3D views |
| [`documentation/dfmea/`](documentation/dfmea/) | Risk register and review report |

## Design status

The project includes routed PCB files and a manufacturing output package, but these are review artifacts. The [architecture notes](documentation/architecture/ARCHITECTURE.md), [BOM notes](hardware/Manufacturing_Output_Files/BOM/BOM_NOTES.md), and [DFMEA report](documentation/dfmea/DFMEA_REPORT.md) record the remaining assumptions and validation work.

Before fabrication, the main open items are:

- Verify the CAN common-mode choke land pattern and terminal numbering.
- Select the CAN crystal and choose part numbers for the remaining BOM entries.
- Resolve the CAN controller's `nWKRQ` power-domain interface in hardware.
- Confirm the required conformal-coating process for the input-section clearances.

Electrical operation, vehicle transients, thermal behavior, RF performance, and EMC still require prototype testing. Do not treat the included manufacturing files as a production release.
