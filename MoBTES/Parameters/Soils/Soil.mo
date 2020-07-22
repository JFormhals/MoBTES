// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record Soil "Generic soil"
	extends SoilPartial(
		rho=2500,
		cp=800,
		lamda=2);
end Soil;
