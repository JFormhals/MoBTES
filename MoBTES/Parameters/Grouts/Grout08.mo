// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Grouts;
record Grout08 "Grout with thermal conductivity of λ=0.8 W/m/K"
	extends GroutPartial(
		lamda=0.8,
		cp=1300,
		rho=1900);
end Grout08;
