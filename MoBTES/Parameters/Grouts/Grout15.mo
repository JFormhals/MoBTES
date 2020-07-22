// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Grouts;
record Grout15 "Grout with average thermal conductivity (λ=1,5 W/m/K)"
	extends GroutPartial(
		lamda=1.5,
		cp=1300,
		rho=1900);
end Grout15;
