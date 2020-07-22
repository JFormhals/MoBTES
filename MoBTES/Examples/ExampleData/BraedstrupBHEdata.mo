// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Examples.ExampleData;
record BraedstrupBHEdata "2U - Brædstrup configuration (DN32 - double-U pipe)"
	extends Parameters.BoreholeHeatExchangers.BHEparameters(
		dBorehole=0.15,
		spacing=sqrt(2*0.062^2),
		nShanks=2,
		dPipe1=0.032,
		tPipe1=0.0029,
		lamda1=0.4,
		dPipe2=0.032,
		tPipe2=0.0029,
		lamda2=0.4);
end BraedstrupBHEdata;
