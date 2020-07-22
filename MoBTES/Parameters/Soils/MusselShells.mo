// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
record MusselShells "Mussel shells for top insulation"
	extends SoilPartial(
		rho=2500,
		cp=3400,
		lamda=0.112);
end MusselShells;
