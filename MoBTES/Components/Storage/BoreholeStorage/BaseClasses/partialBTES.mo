// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Storage.BoreholeStorage.BaseClasses;
partial model partialBTES "Partial BTES model"
	MoBTES.Utilities.Interfaces.FlowPort flowPort(medium=medium) "flow for storage chrging " annotation(Placement(
		transformation(extent={{-55,90},{-35,110}}),
		iconTransformation(extent={{-110,190},{-90,210}})));
	MoBTES.Utilities.Interfaces.ReturnPort returnPort(medium=medium) "return for storage charging" annotation(Placement(
		transformation(extent={{35,90},{55,110}}),
		iconTransformation(extent={{90,190},{110,210}})));
	MoBTES.Utilities.Interfaces.componentBusPorts.BTESbus busPort(nBTES=numberOfComponents) "Port for system control" annotation(Placement(
		transformation(extent={{-110,40},{-90,60}}),
		iconTransformation(extent={{-210,90},{-190,110}})));
	Modelica.SIunits.Temperature Tflow(displayUnit="°C") "BTES flow temperature";
	Modelica.SIunits.Temperature Treturn(displayUnit="°C") "BTES return temperature";
	Modelica.SIunits.Temperature Tstorage(displayUnit="°C") "Average temperature inside storage volume";
	Modelica.SIunits.VolumeFlowRate volFlow(displayUnit="l/s") "BTES volume flow (flow-> return)";
	Modelica.SIunits.Power Pthermal(displayUnit="kW") "Thermal power";
	Modelica.SIunits.Energy Qthermal(
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal ernergy balance";
	Modelica.SIunits.Energy QthermalCharged(
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal energy charged into storage";
	Modelica.SIunits.Energy QthermalDischarged(
		displayUnit="MWh",
		start=0,
		fixed=true) "Thermal energy discharged from storage";
	Modelica.SIunits.Pressure dp "Pressure drop (p_flow - p_return)";
	inner parameter Integer nBHEs(
		min=1,
		max=1000)=100 "Number of borehole heat exchangers (BHE)" annotation(Dialog(
		group="Dimensions",
		tab="Design"));
	inner parameter Modelica.SIunits.Length BHElength(
		displayUnit="m",
		min=20,
		max=2000)=100 "Length of BHEs" annotation(Dialog(
		group="Dimensions",
		tab="Design"));
	inner replaceable parameter MoBTES.Parameters.Locations.TUDa location constrainedby MoBTES.Parameters.Locations.LocationPartial "Local geology" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Dimensions",
			tab="Design"));
	inner replaceable parameter Parameters.BoreholeHeatExchangers.DoubleU_DN32 BHEdata constrainedby MoBTES.Parameters.BoreholeHeatExchangers.BHEparameters "BHE dataset" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Borehole Heat Exchangers",
			tab="Design"));
	inner parameter Integer nBHEsInSeries(
		min=1,
		max=nBHEs)=1 "Number of BHEs connected in series" annotation(Dialog(
		group="Borehole Heat Exchangers",
		tab="Design"));
	inner replaceable parameter Modelica.Thermal.FluidHeatFlow.Media.Water medium constrainedby Modelica.Thermal.FluidHeatFlow.Media.Medium "Medium inside the BHE" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Borehole Heat Exchangers",
			tab="Design"));
	inner parameter Boolean useUpperGroutSection=false "=true, if grout is divided into an upper and a lower section." annotation(Dialog(
		group="Borehole Heat Exchangers",
		tab="Design",
		enable=BHEmodeIsUsed));
	inner replaceable parameter Parameters.Grouts.Grout15 groutData constrainedby MoBTES.Parameters.Grouts.GroutPartial "Grout dataset" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Borehole Heat Exchangers",
			tab="Design",
			enable=BHEmodeIsUsed));
	inner replaceable parameter Parameters.Grouts.Grout15 groutDataUpper constrainedby MoBTES.Parameters.Grouts.GroutPartial "Grout dataset" annotation(
		choicesAllMatching=true,
		Dialog(
			group="Borehole Heat Exchangers",
			tab="Design",
			enable=(useUpperGroutSection and BHEmodeIsUsed)));
	inner parameter Modelica.SIunits.Length lengthUpperGroutSection(
		displayUnit="m",
		min=1,
		max=0.5 * BHElength)=1 "Length of upper grout section." annotation(Dialog(
		group="Borehole Heat Exchangers",
		tab="Design",
		enable=(useUpperGroutSection and BHEmodeIsUsed)));
	parameter Integer numberOfComponents(min=1)=1 "Number of components of the same type" annotation(Dialog(
		group="Setpoint",
		tab="Control",
		enable=useControlInput));
	parameter Integer componentID(min=1)=1 "ID if more than one component of the sam type is used" annotation(Dialog(
		group="Setpoint",
		tab="Control",
		enable=useControlInput));
	Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow HYDR_pump(
		medium=medium,
		m=1,
		T0=location.Taverage,
		T0fixed=true,
		useVolumeFlowInput=true,
		constantVolumeFlow=1) "BHE pumps" annotation(Placement(transformation(
		origin={-45,65},
		extent={{10,-10},{-10,10}},
		rotation=90)));
	protected
		Boolean BHEmodeIsUsed=true;
	equation
		/*Outputs---------------------------------------------*/
		Tflow = flowPort.h / medium.cp;
		Treturn = returnPort.h / medium.cp;
		volFlow = flowPort.m_flow / medium.rho;
		dp=HYDR_pump.flowPort_b.p-HYDR_pump.flowPort_a.p;
		HYDR_pump.volumeFlow=busPort.BTES_volFlow[componentID];
		Pthermal = (Tflow - Treturn) * flowPort.m_flow * medium.cp;
		der(Qthermal) = Pthermal;
		der(QthermalCharged) = max(Pthermal, 0);
		der(QthermalDischarged) = abs(min(Pthermal, 0));
	equation
		connect(flowPort,HYDR_pump.flowPort_a) annotation(
			Line(
				points={{-45,100},{-45,90},{-45,80},{-45,75}},
				color={255,0,0},
				thickness=1),
			AutoRoute=false);
	annotation(
		Diagram(graphics={
		Rectangle(
			radius=10,
			lineColor={140,86,75},
			fillColor={255,255,255},
			fillPattern=FillPattern.Solid,
			lineThickness=5,
			extent={{-100,100},{100,-100}})}),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.002));
end partialBTES;
