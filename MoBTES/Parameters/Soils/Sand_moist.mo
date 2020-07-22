// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record Sand_moist "Sand moist (VDI4640)"
	extends SoilPartial(
		rho=2050,
		cp=930,
		lamda=1.4);
end Sand_moist;
