// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record Clay "Clay (VDI4640)"
	extends MoBTES.Parameters.Soils.SoilPartial(
		rho=2100,
		cp=1140,
		lamda=1.8);
end Clay;
