// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record LiwiSoil "SKEWS: top layer at campus Lichtwiese"
	extends SoilPartial(
		rho=1000,
		cp=2300,
		lamda=1.5);
end LiwiSoil;
