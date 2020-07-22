// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Storage.BoreholeStorage;
model ExampleModel "MoBTES example model "
	extends Modelica.Icons.Example;
	Modelica.Thermal.FluidHeatFlow.Sources.Ambient FLOW(
		medium=Storage.medium,
		constantAmbientPressure=10000,
		useTemperatureInput=true,
		constantAmbientTemperature=294.14999999999998) annotation(Placement(transformation(
		origin={-10,75},
		extent={{10,-10},{-10,10}})));
	Modelica.Thermal.FluidHeatFlow.Sources.Ambient RETURN(
		medium=Storage.medium,
		constantAmbientPressure=10000,
		useTemperatureInput=true,
		constantAmbientTemperature=294.14999999999998) annotation(Placement(transformation(
		origin={45,75},
		extent={{-10,-10},{10,10}})));
	Modelica.Blocks.Sources.Pulse Tin(
		amplitude(
			quantity="CelsiusTemperature",
			displayUnit="K")=60,
		period(displayUnit="a")=31536000,
		y(quantity="CelsiusTemperature"),
		offset(quantity="CelsiusTemperature")=283.15) annotation(Placement(transformation(extent={{-85,80},{-65,100}})));
	BTES Storage(
		nBHEs=25,
		BHElength=50,
		redeclare replaceable parameter Parameters.Locations.TUDa location,
		nBHEsInSeries=5,
		BTESlayout=MoBTES.Utilities.Types.BTESlayout.hexagon,
		settingsData(useAverageSurfaceTemperature=true)) annotation(Placement(transformation(
		origin={20,10},
		extent={{-20,-20},{20,20}})));
	Modelica.Blocks.Sources.Pulse volFlow(
		amplitude(
			quantity="VolumeFlowRate",
			displayUnit="m³/s")=Storage.nBHEs / Storage.nBHEsInSeries * 0.001 * 2,
		period(displayUnit="a")=31536000,
		y(quantity="VolumeFlowRate"),
		offset(
			quantity="VolumeFlowRate",
			displayUnit="m³/s")=-Storage.nBHEs / Storage.nBHEsInSeries * 0.001) annotation(Placement(transformation(extent={{-85,50},{-65,70}})));
	equation
		connect(Tin.y,RETURN.ambientTemperature) annotation(Line(
			points={{-64,90},{-59,90},{60,90},{60,69},{55,69}},
			color={0,0,127},
			thickness=0.0625));
		connect(Tin.y,FLOW.ambientTemperature) annotation(Line(
			points={{-64,90},{-59,90},{-25,90},{-25,69},{-20,69}},
			color={0,0,127},
			thickness=0.0625));
		connect(Storage.busPort.BTES_volFlow[1],volFlow.y) annotation(Line(
			points={{0,20},{-5,20},{-59,20},{-59,60},{-64,60}},
			color={192,192,192}));
		connect(Storage.flowPort,FLOW.flowPort) annotation(Line(
			points={{10,30},{10,35},{10,75},{5,75},{0,75}},
			color={255,0,0},
			thickness=1));
		connect(Storage.returnPort,RETURN.flowPort) annotation(Line(
			points={{30,30},{30,35},{30,75},{35,75}},
			color={0,0,255},
			thickness=1));
	annotation(
		Documentation(info="<html>
<p>
Simple model for the comparison of the performance of different MoBTES models to 3D FEM models.
</p>
<ul>
<li>Simulation of 10 years</li>
<li>Constant charging for 6 months with 80 °C and 2 l/s per BHE</li>
<li>Constant discharging for 6 months with 20 °C and 2 l/s per BHE</li>
<li>Parallel connection of double-U BHEs</li>
<li>Constant thermal properties of the underground</li>
<li>Variation of the number, length, arrangement and radial distance of BHEs </li>
</ul>

</html>"),
		experiment(
			StopTime=315360000,
			StartTime=0,
			Interval=3600,
			Solver(
				bEffJac=false,
				bSparseMat=true,
				typename="CVODE"),
			SolverOptions(
				solver="CVODE",
				typename="ExternalCVODEOptionData"),
			MaxInterval="3600"));
end ExampleModel;
