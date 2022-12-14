// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record Gravel_dry "Gravel dry (VDI4640)"
	extends SoilPartial(
		rho=2000,
		cp=725,
		lamda=0.4);
end Gravel_dry;
