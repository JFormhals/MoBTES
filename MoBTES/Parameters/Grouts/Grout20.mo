// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Grouts;
record Grout20 "Grout with high thermal conductivity (λ=2,0 W/m/K)"
	extends GroutPartial(
		lamda=2,
		cp=1300,
		rho=1900);
end Grout20;
