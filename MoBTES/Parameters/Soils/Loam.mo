// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record Loam "Till/loam (VDI4640)"
	extends SoilPartial(
		rho=2050,
		cp=1000,
		lamda=2.4);
end Loam;
