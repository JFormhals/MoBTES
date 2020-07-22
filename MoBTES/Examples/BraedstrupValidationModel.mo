// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Examples;
model BraedstrupValidationModel "MoBTES model for comparison to Brædstrup BTES monitoring data"
	extends Modelica.Icons.Example;
	Modelica.Thermal.FluidHeatFlow.Sources.Ambient FLOW(
		medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
		constantAmbientPressure=10000,
		useTemperatureInput=true,
		constantAmbientTemperature=294.14999999999998) annotation(Placement(transformation(
		origin={5,85},
		extent={{10,-10},{-10,10}})));
	Modelica.Thermal.FluidHeatFlow.Sources.Ambient RETURN(
		medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
		constantAmbientPressure=10000,
		useTemperatureInput=true,
		constantAmbientTemperature=294.14999999999998) annotation(Placement(transformation(
		origin={75,85},
		extent={{-10,-10},{10,10}})));
	Real deltaT(
		quantity="CelsiusTemperature",
		displayUnit="K");
	Real ToutSim(quantity="CelsiusTemperature");
	Real deltaT_modelOutlet(
		quantity="CelsiusTemperature",
		displayUnit="K");
	Real Pmonitoring(quantity="Power") "Thermal power";
	Real Qmonitoring(
		quantity="Energy",
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal ernergy balance";
	Real QmonitoringIn(
		quantity="Energy",
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal energy charged into storage";
	Real QmonitoringOut(
		quantity="Energy",
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal energy discharged from storage";
	Real Pmodel(quantity="Power") "Thermal power";
	Real Qmodel(
		quantity="Energy",
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal ernergy balance";
	Real QmodelIn(
		quantity="Energy",
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal energy charged into storage";
	Real QmodelOut(
		quantity="Energy",
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal energy discharged from storage";
	Modelica.Thermal.FluidHeatFlow.Components.Pipe Pipe1(
		medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
		m=600 * 0.05 ^ 2 * Modelica.Constants.pi * 1000,
		T0=333.15,
		T0fixed=true,
		V_flowLaminar=0.11,
		dpLaminar=0.11,
		V_flowNominal=1.1,
		dpNominal=1.1,
		h_g=0.0) annotation(Placement(transformation(
		origin={30,15},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Modelica.Thermal.FluidHeatFlow.Components.Pipe Pipe2(
		medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
		m=600 * 0.05 ^ 2 * Modelica.Constants.pi * 1000,
		T0=286.65,
		T0fixed=true,
		V_flowLaminar=0.11,
		dpLaminar=0.11,
		V_flowNominal=1.1,
		dpNominal=1.1,
		h_g=0.0) annotation(Placement(transformation(
		origin={50,15},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Modelica.Thermal.FluidHeatFlow.Sensors.TemperatureSensor Tout_sim(
		medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
		y(displayUnit="°C")) annotation(Placement(transformation(extent={{80,40},{100,60}})));
	Modelica.Thermal.FluidHeatFlow.Sensors.TemperatureSensor Tin_sim(
		medium=Modelica.Thermal.FluidHeatFlow.Media.Water(),
		y(displayUnit="°C")) annotation(Placement(transformation(extent={{55,25},{75,45}})));
	MoBTES.Components.Storage.BoreholeStorage.BTES Storage(
		nBHEs=48,
		BHElength=45,
		redeclare replaceable parameter ExampleData.BraedstrupLocation location,
		redeclare replaceable parameter ExampleData.BraedstrupBHEdata BHEdata,
		nBHEsInSeries=6,
		redeclare replaceable parameter ExampleData.BraedstrupGrout groutData,
		BTESlayout=MoBTES.Utilities.Types.BTESlayout.hexagon,
		BHEspacing=3,
		redeclare replaceable model LOCALmodel = MoBTES.Components.Ground.LocalElement_steadyFlux annotation(Dialog(
			group="Local problem",
			tab="Modeling")),
		settingsData=MoBTES.Parameters.Settings.SettingsDefault(nAdditionalElementsR = 6, relativeModelDepth = 1.8, useAverageSurfaceTemperature = false)) annotation(Placement(transformation(extent={{20,-45},{60,-5}})));
	Modelica.Blocks.Tables.CombiTable1D Tin_monitoring(
		y(quantity="CelsiusTemperature"),
		tableOnFile=true,
		tableName="Tin_monitoring",
		fileName=Modelica.Utilities.Files.loadResource("modelica://MoBTES/Data/BoreholeStorage/BraedstrupExampleData_Tin.txt"),
		smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-55,55},{-35,75}})));
	Modelica.Blocks.Tables.CombiTable1D Tout_monitoring(
		y(quantity="CelsiusTemperature"),
		tableOnFile=true,
		tableName="Tout_monitoring",
		fileName=Modelica.Utilities.Files.loadResource("modelica://MoBTES/Data/BoreholeStorage/BraedstrupExampleData_Tout.txt"),
		smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-55,5},{-35,25}})));
	Modelica.Blocks.Tables.CombiTable1D volumeFlow_monitoring(
		y(
			quantity="VolumeFlowRate",
			displayUnit="l/s"),
		tableOnFile=true,
		tableName="volumeFlow_monitoring",
		fileName=Modelica.Utilities.Files.loadResource("modelica://MoBTES/Data/BoreholeStorage/BraedstrupExampleData_volumeFlow.txt"),
		smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-55,-45},{-35,-25}})));
	Modelica.Blocks.Sources.Clock clock1(
		offset=0,
		startTime=0) annotation(Placement(transformation(extent={{-95,5},{-75,25}})));
	Modelica.Blocks.Tables.CombiTable1D Tambient(
		y(quantity="CelsiusTemperature"),
		tableOnFile=true,
		tableName="Tambient",
		fileName=Modelica.Utilities.Files.loadResource("modelica://MoBTES/Data/BoreholeStorage/BraedstrupExampleData_Tambient_daily.txt"),
		smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative) annotation(Placement(transformation(extent={{-55,-80},{-35,-60}})));
	equation
		deltaT = Tin_monitoring.y[1] - Tout_monitoring.y[1];
		Pmonitoring = deltaT * abs(volumeFlow_monitoring.y[1]) * Storage.medium.rho * Storage.medium.cp;
		der(Qmonitoring) = Pmonitoring;
		der(QmonitoringIn) = max(Pmonitoring, 0);
		der(QmonitoringOut) = abs(min(Pmonitoring, 0));
		Pmodel = (Tin_sim.y - Tout_sim.y) * volumeFlow_monitoring.y[1] * Storage.medium.rho * Storage.medium.cp;
		der(Qmodel) = Pmodel;
		der(QmodelIn) = max(Pmodel, 0);
		der(QmodelOut) = abs(min(Pmodel, 0));
		ToutSim = if abs(Storage.volFlow) < 0.00000001 then Tout_monitoring.y[1] elseif Storage.volFlow > 0 then Tout_sim.y else Tin_sim.y;
		deltaT_modelOutlet = if abs(Storage.volFlow) < 0.00000001 then 0 elseif Storage.volFlow > 0 then abs(Tout_sim.y - Tout_monitoring.y[1]) else abs(Tin_sim.y - Tout_monitoring.y[1]);
		connect(Pipe2.flowPort_a, RETURN.flowPort) annotation(
		  Line(points = {{50, 25}, {50, 30}, {50, 85}, {60, 85}, {65, 85}}, color = {255, 0, 0}, thickness = 0.0625));
		connect(Pipe2.flowPort_a, Tout_sim.flowPort) annotation(
		  Line(points = {{50, 25}, {50, 30}, {50, 50}, {75, 50}, {80, 50}}, color = {255, 0, 0}, thickness = 0.0625));
		connect(Tin_sim.flowPort, Pipe1.flowPort_a) annotation(
		  Line(points = {{55, 35}, {50, 35}, {30, 35}, {30, 30}, {30, 25}}, color = {255, 0, 0}, thickness = 0.0625));
		connect(clock1.y, Tin_monitoring.u[1]) annotation(
		  Line(points = {{-74, 15}, {-69, 15}, {-62, 15}, {-62, 65}, {-57, 65}}, color = {0, 0, 127}, thickness = 0.0625));
		connect(clock1.y, Tout_monitoring.u[1]) annotation(
		  Line(points = {{-74, 15}, {-69, 15}, {-62, 15}, {-57, 15}}, color = {0, 0, 127}, thickness = 0.0625));
		connect(clock1.y, volumeFlow_monitoring.u[1]) annotation(
		  Line(points = {{-74, 15}, {-69, 15}, {-62, 15}, {-62, -35}, {-57, -35}}, color = {0, 0, 127}, thickness = 0.0625));
		connect(Tin_monitoring.y[1], FLOW.ambientTemperature) annotation(
		  Line(points = {{-34, 65}, {-29, 65}, {-10, 65}, {-10, 79}, {-5, 79}}, color = {0, 0, 127}, thickness = 0.0625));
		connect(Tin_monitoring.y[1], RETURN.ambientTemperature) annotation(
		  Line(points = {{-34, 65}, {-29, 65}, {90, 65}, {90, 79}, {85, 79}}, color = {0, 0, 127}, thickness = 0.0625));
		connect(clock1.y, Tambient.u[1]) annotation(
		  Line(points = {{-74, 15}, {-69, 15}, {-62, 15}, {-62, -70}, {-57, -70}}, color = {0, 0, 127}, thickness = 0.0625));
		connect(Storage.flowPort, Pipe1.flowPort_b) annotation(
		  Line(points = {{30, -5}, {30, 0}, {30, 5}}, color = {255, 0, 0}, thickness = 1));
		connect(Storage.returnPort, Pipe2.flowPort_b) annotation(
		  Line(points = {{50, -5}, {50, 0}, {50, 5}}, color = {0, 0, 255}, thickness = 1));
		connect(FLOW.flowPort, Pipe1.flowPort_a) annotation(
		  Line(points = {{15, 85}, {20, 85}, {30, 85}, {30, 30}, {30, 25}}, color = {255, 0, 0}, thickness = 0.0625));
		connect(Tambient.y[1], Storage.weatherPort.Tambient) annotation(
		  Line(points = {{-34, -70}, {-29, -70}, {40, -70}, {40, -49.7}, {40, -44.7}}, color = {0, 0, 127}, thickness = 0.0625));
		connect(volumeFlow_monitoring.y[1], Storage.busPort.BTES_volFlow[1]) annotation(
		  Line(points = {{-34, -35}, {-29, -35}, {15, -35}, {15, -15}, {20, -15}}, color = {0, 0, 127}, thickness = 0.0625));
	annotation(
		
		Documentation(info="<html>
<p>
MoBTES model of the Brædtrup BTES system:
</p>
<ul>
<li>Monitoring data for the first 1680 days of BTES operation (inlet and outlet temperatures and volume flow on a 5 minute basis)</li>
<li>48 BHEs each 45 m long</li>
<li>6 BHEs in series</li>
<li>Charging from center BHEs to outer BHEs/ reversal of flow for discharging</li>
<li>(Aggregated) thermal properties of the subsurface after <a href=\"modelica://MoBTES.UsersGuide.References\">[Tordrup2017]</a></li>
<li>Parametrization of the grout, BHEs and top insulation after <a href=\"modelica://MoBTES.UsersGuide.References\">[Sørensen2013]</a></li>
<li>Consideration of the distance between the BTES and monitoring sensors by pipe elements</li>
</ul>


</html>"),
		experiment(
			StopTime=145152000,
			StartTime=0,
			Interval=300,
			Solver(
				bEffJac=true,
				bSparseMat=true,
				typename="CVODE"),
			SolverOptions(
				solver="CVODE",
				typename="ExternalCVODEOptionData")));
end BraedstrupValidationModel;
