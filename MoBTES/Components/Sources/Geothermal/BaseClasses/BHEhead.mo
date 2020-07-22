// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Sources.Geothermal.BaseClasses;
model BHEhead "Borehole heat excxhanger head"
	MoBTES.Utilities.Interfaces.FlowPort flowPort(medium=medium) "Port used for hot fluid" annotation(Placement(
		transformation(
			origin={-45,100},
			extent={{-10,-10},{10,10}},
			rotation=90),
		iconTransformation(extent={{-60,90},{-40,110}})));
	MoBTES.Utilities.Interfaces.FlowPort BHEflow(medium=medium) "Connection to top BHE segment flow" annotation(Placement(
		transformation(
			origin={-45,5},
			extent={{-10,-10},{10,10}},
			rotation=180),
		iconTransformation(
			origin={-50,-96.7},
			extent={{-10,-10},{10,10}},
			rotation=180)));
	MoBTES.Utilities.Interfaces.ReturnPort returnPort(medium=medium) "Port used for cool fluid" annotation(Placement(
		transformation(extent={{45,90},{65,110}}),
		iconTransformation(extent={{40,90},{60,110}})));
	MoBTES.Utilities.Interfaces.ReturnPort BHEreturn(medium=medium) "Connection to top BHE segment return" annotation(Placement(
		transformation(
			origin={55,5},
			extent={{-10,-10},{10,10}},
			rotation=180),
		iconTransformation(
			origin={50,-96.7},
			extent={{-10,-10},{10,10}},
			rotation=180)));
	Modelica.Blocks.Interfaces.RealOutput Radvective[3] "Advective resistance of BHE" annotation(Placement(
		transformation(extent={{-115,65},{-135,85}}),
		iconTransformation(extent={{-90,-10},{-110,10}})));
	replaceable parameter Parameters.BoreholeHeatExchangers.DoubleU_DN32 BHEdata constrainedby MoBTES.Parameters.BoreholeHeatExchangers.BHEparameters;
	replaceable parameter Modelica.Thermal.FluidHeatFlow.Media.Water medium constrainedby Modelica.Thermal.FluidHeatFlow.Media.Medium;
	parameter Integer multiplicationFactor=1 "Volume flow inside BHE will be smaller by this factor (e.g. ti represent parallel BHEs)";
	parameter Modelica.SIunits.Temperature Tinitial=283.14999999999998 "initial BHE temperature";
	parameter Modelica.SIunits.Length BHElength=100;
	Utilities.FluidHeatFlow.Pipe_flowMulti pipe_flowMulti1(
		multiplicationFactor=max(1,BHEdata.nShanks)*multiplicationFactor,
		medium=medium,
		m=1,
		T0=Tinitial,
		T0fixed=true,
		V_flowLaminar=0.1,
		dpLaminar=0.09999999999999999,
		V_flowNominal=1,
		dpNominal=1,
		h_g=0) annotation(Placement(transformation(
		origin={-50,80},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Utilities.FluidHeatFlow.Pipe_flowMulti pipe_flowMulti2(
		multiplicationFactor=max(1,BHEdata.nShanks)*multiplicationFactor,
		medium=medium,
		m=1,
		T0=Tinitial,
		T0fixed=true,
		V_flowLaminar=0.1,
		dpLaminar=0.09999999999999999,
		V_flowNominal=1,
		dpNominal=1,
		h_g=0) annotation(Placement(transformation(
		origin={50,80},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Utilities.FluidHeatFlow.PrescribedPressureDropValve prescribedPressureDropValve1(medium=medium) annotation(Placement(transformation(
		origin={-50,30},
		extent={{10,-10},{-10,10}},
		rotation=90)));
	Utilities.FluidHeatFlow.BHEhydraulics bHEhydraulics1(
		BHEdata=BHEdata,
		BHEmedium=medium,
		BHElength=BHElength) annotation(Placement(transformation(extent={{-80,45},{-100,65}})));
	Modelica.Thermal.FluidHeatFlow.Sensors.VolumeFlowSensor volumeFlowSensor1(medium=medium) annotation(Placement(transformation(
		origin={-50,55},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	equation
		connect(flowPort,pipe_flowMulti1.flowPort_a) annotation(Line(
			points={{-45,100},{-50,100},{-50,95},{-50,90}},
			color={255,0,0},
			thickness=1));
		connect(returnPort,pipe_flowMulti2.flowPort_a) annotation(Line(
			points={{55,100},{50,100},{50,95},{50,90}},
			color={0,0,255},
			thickness=1));
		connect(BHEreturn,pipe_flowMulti2.flowPort_b) annotation(Line(
			points={{55,5},{50,5},{50,65},{50,70}},
			color={0,0,255},
			thickness=1));
		connect(BHEflow,prescribedPressureDropValve1.flowPort_b) annotation(Line(
			points={{-45,5},{-50,5},{-50,15},{-50,20}},
			color={255,0,0},
			thickness=1));
		connect(bHEhydraulics1.R[:],Radvective[:]) annotation(Line(
			points={{-99.7,60},{-104.7,60},{-120,60},{-120,75},{-125,75}},
			color={0,0,127},
			thickness=0.0625));
		connect(bHEhydraulics1.dp,prescribedPressureDropValve1.y) annotation(Line(
			points={{-99.7,50},{-104.7,50},{-104.7,30},{-65,30},{-60,30}},
			color={0,0,127},
			thickness=0.0625));
		connect(volumeFlowSensor1.flowPort_a,pipe_flowMulti1.flowPort_b) annotation(Line(
			points={{-50,65},{-50,70},{-50,65},{-50,70}},
			color={255,0,0},
			thickness=0.0625));
		connect(prescribedPressureDropValve1.flowPort_a,volumeFlowSensor1.flowPort_b) annotation(Line(
			points={{-50,40},{-50,45},{-50,40},{-50,45}},
			color={255,0,0},
			thickness=0.0625));
		connect(volumeFlowSensor1.y,bHEhydraulics1.volFlow) annotation(Line(
			points={{-61,55},{-66,55},{-75,55},{-80,55}},
			color={0,0,127},
			thickness=0.0625));
	annotation(
		Icon(graphics={
			Rectangle(
				lineColor={127,127,127},
				fillColor={192,192,192},
				fillPattern=FillPattern.Solid,
				extent={{-100,100},{100,-100}}),
			Rectangle(
				fillColor={120,120,120},
				fillPattern=FillPattern.Solid,
				extent={{-60,33.3},{63.1,-100}}),
			Rectangle(
				fillColor={87,128,255},
				fillPattern=FillPattern.Solid,
				extent={{-50,23.3},{53.3,-100}}),
			Rectangle(
				fillColor={120,120,120},
				fillPattern=FillPattern.Solid,
				extent={{-36.7,-26.7},{36.7,-100}}),
			Rectangle(
				fillColor={224,0,0},
				fillPattern=FillPattern.Solid,
				extent={{-26.7,-36.7},{26.7,-100}}),
			Rectangle(
				fillColor={120,120,120},
				fillPattern=FillPattern.Solid,
				extent={{-33.3,63.3},{3.3,-26.7}}),
			Rectangle(
				fillColor={224,0,0},
				fillPattern=FillPattern.Solid,
				extent={{-26.7,62.3},{-3.3,-37.7}}),
			Rectangle(
				fillColor={120,120,120},
				fillPattern=FillPattern.Solid,
				extent={{10,63.2},{43.3,23.3}}),
			Rectangle(
				fillColor={87,128,255},
				fillPattern=FillPattern.Solid,
				extent={{16.7,63.3},{36.7,23.3}})}),
		Documentation(info="<html>
<p>
Borehole heat exchanger head model. Includes hydraulic utility components and can be regarded as an interface for the different BHE types.
</p>
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end BHEhead;
