// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record Sand_saturated "Sand saturated (VDI4640)"
	extends SoilPartial(
		rho=2100,
		cp=1190,
		lamda=2.4);
end Sand_saturated;
