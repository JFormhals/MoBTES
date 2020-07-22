// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Examples.ExampleData;
record BraedstrupGrout "Brædstrup grout (HDG Thermo HS)"
	extends Parameters.Grouts.GroutPartial(
		lamda=1.44,
		cp=1500,
		rho=2000);
end BraedstrupGrout;
