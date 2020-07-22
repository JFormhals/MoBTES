// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Locations;
record SingleLayerLocation "Simple location with one sandy layer"
	extends LocationPartial(
		Taverage=283.15,
		geoGradient=0.03,
		layers=1,
		redeclare replaceable parameter Soils.Sand_moist strat1,
		layerThicknessVector={1000,1,1,1,1});
end SingleLayerLocation;
