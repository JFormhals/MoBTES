// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Locations;
record TUDa "TU Darmstadt - Campus Lichtwiese"
	extends LocationPartial(
		Taverage=283.15,
		geoGradient=0.03,
		layers=2,
		redeclare replaceable parameter Soils.LiwiSoil strat1,
		redeclare replaceable parameter Soils.LiwiCrystalline strat2,
		layerThicknessVector={50,2000,1,1,1});
end TUDa;
