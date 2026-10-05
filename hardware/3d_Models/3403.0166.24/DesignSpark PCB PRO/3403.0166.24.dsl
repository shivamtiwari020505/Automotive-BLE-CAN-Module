SamacSys ECAD Model
15665741/2175241/2.50/2/2/Fuse

DESIGNSPARK_INTERMEDIATE_ASCII

(asciiHeader
	(fileUnits MM)
)
(library Library_1
	(padStyleDef "r375_200"
		(holeDiam 0)
		(padShape (layerNumRef 1) (padShapeType Rect)  (shapeWidth 2.000) (shapeHeight 3.750))
		(padShape (layerNumRef 16) (padShapeType Ellipse)  (shapeWidth 0) (shapeHeight 0))
	)
	(textStyleDef "Default"
		(font
			(fontType Stroke)
			(fontFace "Helvetica")
			(fontHeight 50 mils)
			(strokeWidth 5 mils)
		)
	)
	(patternDef "3403016624" (originalName "3403016624")
		(multiLayer
			(pad (padNum 1) (padStyleRef r375_200) (pt -4.250, 0.000) (rotation 0))
			(pad (padNum 2) (padStyleRef r375_200) (pt 4.250, 0.000) (rotation 0))
		)
		(layerContents (layerNumRef 18)
			(attr "RefDes" "RefDes" (pt -0.000, 0.000) (textStyleRef "Default") (isVisible True))
		)
		(layerContents (layerNumRef 28)
			(line (pt -5.05 1.5) (pt 5.05 1.5) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt 5.05 1.5) (pt 5.05 -1.5) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt 5.05 -1.5) (pt -5.05 -1.5) (width 0.1))
		)
		(layerContents (layerNumRef 28)
			(line (pt -5.05 -1.5) (pt -5.05 1.5) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt -6.25 2.875) (pt 6.25 2.875) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt 6.25 2.875) (pt 6.25 -2.875) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt 6.25 -2.875) (pt -6.25 -2.875) (width 0.1))
		)
		(layerContents (layerNumRef 30)
			(line (pt -6.25 -2.875) (pt -6.25 2.875) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt -5.6 0) (pt -5.6 0) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(arc (pt -5.65, 0) (radius 0.05) (startAngle .0) (sweepAngle 180.0) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt -5.7 0) (pt -5.7 0) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(arc (pt -5.65, 0) (radius 0.05) (startAngle 180) (sweepAngle 180.0) (width 0.1))
		)
		(layerContents (layerNumRef 18)
			(line (pt -3 1.5) (pt 3 1.5) (width 0.2))
		)
		(layerContents (layerNumRef 18)
			(line (pt -3 -1.5) (pt 3 -1.5) (width 0.2))
		)
	)
	(symbolDef "3403_0166_24" (originalName "3403_0166_24")

		(pin (pinNum 1) (pt 0 mils 0 mils) (rotation 0) (pinLength 200 mils) (pinDisplay (dispPinName false)) (pinName (text (pt 0 mils -35 mils) (rotation 0]) (justify "UpperLeft") (textStyleRef "Default"))
		))
		(pin (pinNum 2) (pt 700 mils 0 mils) (rotation 180) (pinLength 200 mils) (pinDisplay (dispPinName false)) (pinName (text (pt 700 mils -35 mils) (rotation 0]) (justify "UpperRight") (textStyleRef "Default"))
		))
		(line (pt 200 mils 50 mils) (pt 500 mils 50 mils) (width 6 mils))
		(line (pt 500 mils 50 mils) (pt 500 mils -50 mils) (width 6 mils))
		(line (pt 500 mils -50 mils) (pt 200 mils -50 mils) (width 6 mils))
		(line (pt 200 mils -50 mils) (pt 200 mils 50 mils) (width 6 mils))
		(line (pt 200 mils 0 mils) (pt 500 mils 0 mils) (width 6 mils))
		(attr "RefDes" "RefDes" (pt 550 mils 250 mils) (justify Left) (isVisible True) (textStyleRef "Default"))

	)
	(compDef "3403.0166.24" (originalName "3403.0166.24") (compHeader (numPins 2) (numParts 1) (refDesPrefix F)
		)
		(compPin "1" (pinName "1") (partNum 1) (symPinNum 1) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(compPin "2" (pinName "2") (partNum 1) (symPinNum 2) (gateEq 0) (pinEq 0) (pinType Bidirectional))
		(attachedSymbol (partNum 1) (altType Normal) (symbolName "3403_0166_24"))
		(attachedPattern (patternNum 1) (patternName "3403016624")
			(numPads 2)
			(padPinMap
				(padNum 1) (compPinRef "1")
				(padNum 2) (compPinRef "2")
			)
		)
		(attr "Manufacturer_Name" "SCHURTER")
		(attr "Manufacturer_Part_Number" "3403.0166.24")
		(attr "Mouser Part Number" "693-3403.0166.24")
		(attr "Mouser Price/Stock" "https://www.mouser.co.uk/ProductDetail/Schurter/3403.0166.24?qs=WtG364jHAdwL4lK1GD3AKQ%3D%3D")
		(attr "Arrow Part Number" "3403.0166.24")
		(attr "Arrow Price/Stock" "https://www.arrow.com/en/products/3403.0166.24/schurter?region=asia")
		(attr "Description" "UMT 250 Fuse T 1A L 250V AC")
		(attr "Datasheet Link" "https://www.schurter.com/en/datasheet/UMT_250")
		(attr "Height" "3 mm")
	)

)
