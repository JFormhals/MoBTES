// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Examples.ExampleData;
record BenchmarkBHEdata "2U - DN32 - 3D FEM benchmark study"
	extends Parameters.BoreholeHeatExchangers.BHEparameters(
		dBorehole=0.15,
		spacing=0.09,
		nShanks=2,
		dPipe1=0.032,
		tPipe1=0.003,
		lamda1=0.4,
		dPipe2=0.032,
		tPipe2=0.003,
		lamda2=0.4);
end BenchmarkBHEdata;
