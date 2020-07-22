// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Examples.ExampleData;
record BraedstrupLocationDetailed "Brædstrup BTES location with 5 layers (Tordrup et al. 2017)"
	extends Parameters.Locations.LocationPartial(
		Taverage=281.14999999999998,
		geoGradient=0.0,
		layers=5,
		redeclare replaceable parameter Parameters.Soils.MusselShells strat1,
		redeclare replaceable parameter Parameters.Soils.Soil strat2(
			rho=2270,
			cp=1000,
			lamda=1.39),
		redeclare replaceable parameter Parameters.Soils.Soil strat3(
			rho=(1750*11+2150*6)/17,
			cp=1000,
			lamda=(1.63*11+1.48*6)/17),
		redeclare replaceable parameter Parameters.Soils.Soil strat4(
			rho=1940,
			cp=1000,
			lamda=1.75),
		redeclare replaceable parameter Parameters.Soils.Soil strat5(
			rho=1860,
			cp=1000,
			lamda=2.44),
		layerThicknessVector={1,9,17,15,1000});
end BraedstrupLocationDetailed;
