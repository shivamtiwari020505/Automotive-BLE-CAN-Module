PULSONIX_LIBRARY_ASCII "SamacSys ECAD Model"
//173388/2175241/2.50/2/2/Capacitor Polarised

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "r400_200"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 2.000) (shapeHeight 4.000))
		(padShape (layerNumRef 16) (padShapeType Ellipse)  (shapeWidth 0) (shapeHeight 0))
	)
	(textStyleDef "Normal"
		(font
			(fontType Stroke)
			(fontFace "Helvetica")
			(fontHeight 1.27)
			(strokeWidth 0.127)
		)
	)
	(patternDef "EEHZT1E331UP" (originalName "EEHZT1E331UP")
		(multiLayer
			(pad (padNum 1) (padStyleRef r400_200) (pt -3.550, 0.000) (rotation 90))
			(pad (padNum 2) (padStyleRef r400_200) (pt 3.550, 0.000) (rotation 90))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt -0.350, 0.000) (textStyleRef "Normal") (isVisible True))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt -7.05 5.15) (pt 6.35 5.15) (width 0.05))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt 6.35 5.15) (pt 6.35 -5.15) (width 0.05))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt 6.35 -5.15) (pt -7.05 -5.15) (width 0.05))
		)
		(layerContents (layerNumRef Courtyard_Top)
			(line (pt -7.05 -5.15) (pt -7.05 5.15) (width 0.05))
		)
		(layerContents (layerNumRef 28)
			(line (pt -4.15 2) (pt -2 4.15) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt -2 4.15) (pt 4.15 4.15) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt 4.15 4.15) (pt 4.15 -4.15) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt 4.15 -4.15) (pt -2 -4.15) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt -2 -4.15) (pt -4.15 -2) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt -4.15 -2) (pt -4.15 2) (width 0.025))
		)
		(layerContents (layerNumRef 28)
			(line (pt -4.15 2) (pt -2 4.15) (width 0.025))
		)
		(layerContents (layerNumRef 18)
			(line (pt -4.15 2) (pt -2 4.15) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt -2 4.15) (pt 4.15 4.15) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt 4.15 4.15) (pt 4.15 2) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt -4.15 -2) (pt -2 -4.15) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt -2 -4.15) (pt 4.15 -4.15) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt 4.15 -4.15) (pt 4.15 -2) (width 0.2))
		)
	)
	(symbolDef "EEEFK2A220P" (originalName "EEEFK2A220P")

		(pin (pinNum 1) (pt 0 mils 0 mils) (rotation 0) (pinLength 100 mils) (pinDisplay (dispPinName false)) (pinName (text (pt 0 mils -35 mils) (rotation 0]) (justify "UpperLeft") (textStyleRef "Normal"))
		))
		(pin (pinNum 2) (pt 500 mils 0 mils) (rotation 180) (pinLength 100 mils) (pinDisplay (dispPinName false)) (pinName (text (pt 500 mils -35 mils) (rotation 0]) (justify "UpperRight") (textStyleRef "Normal"))
		))
		(line (pt 200 mils 100 mils) (pt 200 mils -100 mils) (width 6 mils))
		(line (pt 200 mils -100 mils) (pt 230 mils -100 mils) (width 6 mils))
		(line (pt 230 mils -100 mils) (pt 230 mils 100 mils) (width 6 mils))
		(line (pt 230 mils 100 mils) (pt 200 mils 100 mils) (width 6 mils))
		(line (pt 180 mils 50 mils) (pt 140 mils 50 mils) (width 6 mils))
		(line (pt 160 mils 70 mils) (pt 160 mils 30 mils) (width 6 mils))
		(line (pt 100 mils 0 mils) (pt 200 mils 0 mils) (width 6 mils))
		(line (pt 300 mils 0 mils) (pt 400 mils 0 mils) (width 6 mils))
		(poly (pt 300 mils 100 mils) (pt 300 mils -100 mils) (pt 270 mils -100 mils) (pt 270 mils 100 mils) (pt 300 mils 100 mils) (width 10  mils))
		(attr "RefDes" "RefDes" (pt 350 mils 250 mils) (justify 24) (isVisible True) (textStyleRef "Normal"))
		(attr "Type" "Type" (pt 350 mils 150 mils) (justify 24) (isVisible True) (textStyleRef "Normal"))

	)
	(compDef "EEEFK2A220P" (originalName "EEEFK2A220P") (compHeader (numPins 2) (numParts 1) (refDesPrefix C)
		)
		(compPin "1" (pinName "+") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Unknown))
		(compPin "2" (pinName "-") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Unknown))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "EEEFK2A220P"))
		(attachedPattern (patternNum 1) (patternName "EEHZT1E331UP")
			(numPads 2)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
			)
		)
		(attr "Manufacturer_Name" "Panasonic")
		(attr "Manufacturer_Part_Number" "EEEFK2A220P")
		(attr "Mouser Part Number" "")
		(attr "Mouser Price/Stock" "")
		(attr "Arrow Part Number" "EEEFK2A220P")
		(attr "Arrow Price/Stock" "https://www.arrow.com/en/products/eee-fk2a220p/panasonic")
		(attr "Description" "Panasonic 22F +/-20% 1.3 100 V F SMD Metal Can Aluminium Electrolytic Capacitor")
		(attr "<Hyperlink>" "http://industrial.panasonic.com/cdbs/www-data/pdf/RDE0000/ABA0000C1181.pdf")
		(attr "<Component Height>" "10.8")
		(attr "<STEP Filename>" "EEEFK2A220P.stp")
		(attr "<STEP Offsets>" "X=0.06;Y=0;Z=0")
		(attr "<STEP Rotation>" "X=90;Y=0;Z=180")
	)

)
