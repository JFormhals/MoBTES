// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Grouts;
record Grout05 "Grout with very low thermal conductivity (λ=0.5 W/m/K)"
	extends GroutPartial(
		lamda=1.0,
		cp=1300,
		rho=1900);
end Grout05;
