// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record Concrete "Concrete (VDI4640)"
	extends SoilPartial(
		rho=2000,
		cp=900,
		lamda=1.6);
end Concrete;
