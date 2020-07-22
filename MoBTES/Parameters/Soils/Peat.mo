// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record Peat "Peat (VDI4640)"
	extends SoilPartial(
		rho=800,
		cp=2625,
		lamda=0.4);
end Peat;
