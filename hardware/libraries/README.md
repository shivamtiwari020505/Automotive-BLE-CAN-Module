# CC2340R5 library import

Imported and reviewed on 2026-09-24 using KiCad 9.0.7.

## Use in this project

Save any open design work, close the editors, and reopen
`BLE-CAN-module.kicad_pro` through KiCad. In the Schematic Editor,
press **A** and search for `CC2340R53E0RKPR` in the **BLE-CAN** library.

- Symbol: `BLE_CAN:CC2340R53E0RKPR`
- Default footprint: `BLE_CAN:RKP0040B-MFG`
- STEP model: `${KIPRJMOD}/libraries/BLE_CAN.3dshapes/RKP0040B.stp`

The symbol and footprint tables are project-specific. Keep this entire
`libraries` folder, `sym-lib-table`, and `fp-lib-table` with the project when
moving it. No global KiCad libraries were edited. The MCU symbol is used in the
project schematic; the current design status is recorded in the top-level README.

## Source and part selection

The original symbol and footprint were obtained from the
[Ultra Librarian listing](https://app.ultralibrarian.com/details/d82a6783-d427-11ef-bf12-024899f9dfe1/Texas-Instruments/CC2340R53E0RKPR),
marked **Built by Texas Instruments**. The extracted source files are kept under
`MCU_CC2340R5/` and are not registered as active libraries.

The selected orderable device is **CC2340R53E0RKPR**, within the CC2340R5 family.
Selecting this orderable package is a project design decision. It must
not be described as a CC2340R5-Q1 or as AEC-Q100-qualified without separate evidence.

## Changes made to the working copy

1. Linked the symbol to the project-local **MFG** footprint. The downloaded
   symbol still defaulted to `RKP0040B-IPC_A`, despite including the MFG option.
2. Corrected the MFG footprint's internal name/value, which the exporter also
   incorrectly left as `RKP0040B-IPC_A`.
3. Changed thermal-hole pad numbers **42-53** to **41**. These twelve holes belong
   to the exposed ground pad; they are not twelve additional IC terminals.
4. Restored 0.05 mm rounded copper-pad corners and changed the imported 0.2032 mm
   thermal-hole drills to the drawing's nominal 0.2 mm. Pad positions and overall
   copper-land dimensions were retained, including the export's micron-scale
   rounding. The existing nine chamfer-corner paste windows were retained.
5. Removed the literal `Designator685` silkscreen text and moved the live reference
   outside the pad field. Added a 6 x 6 mm courtyard: a local placement allowance,
   not a dimension specified by TI. The vendor's maximum-body F.Fab outline and
   pin-1 marker were retained.
6. Added the STEP link with unit scale, zero offset, and zero rotation. The STEP
   file itself is byte-for-byte identical to the download.
7. Refined KiCad electrical-rule-checking types: VDDD and DCDC are internal
   regulator/switching outputs; crystal and RF pins use passive analog types;
   NC uses no-connect; EP uses power-input/ground. These are KiCad modeling choices
   derived from the described pin functions, not permission to power other loads
   from the internal regulator nodes. Existing pin numbers and names were retained.
8. Moved the symbol reference/value above its body. Its functional pin layout was
   retained. `RST_N` in the imported symbol denotes datasheet `RSTN`.

## Verification and limitations

Checked against [TI datasheet SWRS272F](https://www.ti.com/lit/ds/symlink/cc2340r5.pdf),
saved at `../../documentation/datasheets/cc2340r5.pdf`: Figure 6-1, the pin-function tables,
and RKP0040B drawing 4219083/A. TI also confirms that
[EGP/pad 41 is the exposed ground reference](https://e2e.ti.com/support/wireless-connectivity/bluetooth-group/bluetooth/f/bluetooth-forum/1532388/lp-em-cc2340r5-cc2340r5-egp-pin-41).

- All 40 perimeter pin names/numbers match Figure 6-1, allowing the `RST_N` alias.
  Pad 41 matches the exposed-pad numbering in the mechanical drawing.
- 0.4 mm pitch, 0.6 x 0.2 mm perimeter lands, 4.8 mm opposite-row center spacing,
  and a 3.5 x 3.5 mm central copper pad pass the geometry checks.
- All twelve thermal holes share pad 41; no unmatched pads 42-53 remain.
- Nine approximately 1 x 1 mm paste windows are retained. The exported chamfered
  shapes calculate to about 73.10% EP paste coverage, rather than exactly the
  drawing's rounded 74% annotation. Stencil details need assembly review.
- KiCad's native symbol and footprint SVG exports succeeded. The footprint loaded
  through KiCad's PCB parser; top and angled STEP renders were visually inspected.
- An isolated test board reported **0 footprint errors and 0 unconnected items**.
  It reported **12 drill-size errors** because the default minimum hole is 0.3 mm
  while this pattern uses 0.2 mm holes. Fabrication capability must be selected
  and documented before release.

The thermal-hole fill/plug/tenting process, solder-mask registration, stencil,
stackup, and RF ground-via implementation are not finalized by this library import.
TI recommends treating vias under paste to avoid solder loss; arrange this with
the intended fabricator/assembler. Do not treat this as fabrication approval.

The isolated library test and its preview artifacts are not included here. That
library check does not certify the complete circuit, RF design, or PCB layout.


## Adding project symbols and footprints

When a schematic uses a custom symbol or footprint, keep its library files in this project: place symbols under libraries/ and footprints in a .pretty folder there. Register each symbol library in the project sym-lib-table and each footprint library in fp-lib-table, using ${KIPRJMOD} paths. Copy the referenced library files with the project so it opens on another computer. Do not replace existing library entries; add new entries and files alongside them.

## Portable sheet symbol coverage

The local `BLE_CAN_Power` library includes the vehicle-input, buck/LDO, and battery-backup symbols. `BLE_CAN_CAN` contains the CAN interface symbols. Their footprints are stored in `BLE_CAN.pretty`; that folder is already registered by this project's `fp-lib-table`. Keep these files and both project tables with the `.kicad_pro` when copying or submitting the project.
