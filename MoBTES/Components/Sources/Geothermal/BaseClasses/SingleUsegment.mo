// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Sources.Geothermal.BaseClasses;
model SingleUsegment "Single-U borehole heat exchanger"
	extends BHEsegment_partial;
	Utilities.FluidHeatFlow.SimpleHeatedPipe returnPipe(
		medium=medium,
		m=((BHEdata.dPipe1/2-BHEdata.tPipe1)^2*Modelica.Constants.pi*segmentLength*medium.rho),
		T(
			start=Tinitial,
			fixed=true)) "annular gap of coaxial pipe" annotation(Placement(transformation(
		origin={80,55},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Utilities.FluidHeatFlow.SimpleHeatedPipe flowPipe(
		medium=medium,
		m=((BHEdata.dPipe1/2-BHEdata.tPipe1)^2*Modelica.Constants.pi*segmentLength*medium.rho),
		T(
			start=Tinitial,
			fixed=true)) "inner pipe of coaxial pipe" annotation(Placement(transformation(
		origin={-120,55},
		extent={{-10,-10},{10,10}},
		rotation=90)));
	Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C_grout_flow(
		C=Modelica.Constants.pi*((BHEdata.dBorehole/2)^2/2-(BHEdata.dPipe1/2)^2)*groutData.cp*groutData.rho*segmentLength,
		T(
			start=Tinitial,
			fixed=true))if useTRCMmodel annotation(Placement(transformation(extent={{-60,70},{-40,90}})));
	Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C_grout_return(
		C=Modelica.Constants.pi*((BHEdata.dBorehole/2)^2/2-(BHEdata.dPipe1/2)^2)*groutData.cp*groutData.rho*segmentLength,
		T(
			start=Tinitial,
			fixed=true))if useTRCMmodel annotation(Placement(transformation(extent={{-5,70},{15,90}})));
	Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistorFlow annotation(Placement(transformation(extent={{-85,45},{-105,65}})));
	Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistorReturn annotation(Placement(transformation(extent={{45,45},{65,65}})));
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_fluidToGrout_flow(R=if useTRCMmodel then (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+x_grout_center*R_grout_spec)/segmentLength else (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+R_grout_spec)/segmentLength) annotation(Placement(transformation(extent={{-80,45},{-60,65}})));
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_groutToGrout(R=if useTRCMmodel then((2*(1-x_grout_center)*R_grout_spec*(R_pipeToPipe_spec-2*x_grout_center*R_grout_spec))/(2*(1-x_grout_center)*R_grout_spec-R_pipeToPipe_spec+2*x_grout_center*R_grout_spec))/segmentLength else (2*log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+R_pipeToPipe_spec)/segmentLength) annotation(Placement(transformation(extent={{-35,45},{-15,65}})));
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_fluidToGrout_return(R=if useTRCMmodel then (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+x_grout_center*R_grout_spec)/segmentLength else (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+R_grout_spec)/segmentLength) annotation(Placement(transformation(extent={{20,45},{40,65}})));
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_groutToWall_flow(R=(1-x_grout_center)*R_grout_spec/segmentLength)if useTRCMmodel annotation(Placement(transformation(
		origin={-50,25},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_groutToWall_return(R=(1-x_grout_center)*R_grout_spec/segmentLength)if useTRCMmodel annotation(Placement(transformation(
		origin={5,25},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	parameter Real segmentLength(
		quantity="Length",
		displayUnit="m") "length of pipe segment" annotation(Dialog(tab="BHE"));
	parameter Real Tinitial(quantity="CelsiusTemperature")=283.14999999999998 "initial BHE temperature" annotation(Dialog(tab="Ground"));
	protected
		parameter Real R_grout_spec=Modelica.Math.acosh((BHEdata.dBorehole^2+BHEdata.dPipe1^2-BHEdata.spacing^2)/(2*BHEdata.dBorehole*BHEdata.dPipe1))/(2*Modelica.Constants.pi*groutData.lamda)*(1.601-0.888*BHEdata.spacing/BHEdata.dBorehole);
		parameter Real R_pipeToPipe_spec=Modelica.Math.acosh((2*BHEdata.spacing^2-BHEdata.dPipe1^2)/(BHEdata.dPipe1^2))/(2*Modelica.Constants.pi*groutData.lamda);
		parameter Real x_grout_center(
			min=0,
			max=1)=MoBTES.Components.Storage.BoreholeStorage.Functions.xGroutCenter_1U(BHEdata,groutData);
	initial algorithm
		assert(BHEdata.nShanks==1,"Incompatible BHE record. Number of shanks has to be 1 for single-U BHEs!",level=AssertionLevel.error);
	equation
		//convective resistances
		convectiveResistorFlow.Rc=Radvective[1]/segmentLength;
		convectiveResistorReturn.Rc=Radvective[1]/segmentLength;
		//fluid ports
		connect(bottomReturnPort,returnPipe.flowPort_b) annotation(Line(
			points={{85,5},{80,5},{80,40},{80,45}},
			color=DynamicSelect({255,0,0},if time>0.000000 then{255,0,0}else if time>0.000000 then{255,0,0}else{0,0,255}),
			thickness=0.0625));
		connect(bottomFlowPort,flowPipe.flowPort_a) annotation(Line(
			points={{-125,5},{-120,5},{-120,40},{-120,45}},
			color=DynamicSelect({255,0,0},if time>0.000000 then{255,0,0}else if time>0.000000 then{255,0,0}else{0,0,255}),
			thickness=0.0625));
		connect(topReturnPort,returnPipe.flowPort_a) annotation(Line(
			points={{85,95},{80,95},{80,70},{80,65}},
			color=DynamicSelect({255,0,0},if time>0.000000 then{255,0,0}else if time>0.000000 then{255,0,0}else{0,0,255}),
			thickness=0.0625));
		
		connect(topFlowPort,flowPipe.flowPort_b) annotation(Line(
			points={{-125,95},{-120,95},{-120,70},{-120,65}},
			color=DynamicSelect({255,0,0},if time>0.000000 then{255,0,0}else if time>0.000000 then{255,0,0}else{0,0,255}),
			thickness=0.0625));
		connect(convectiveResistorReturn.fluid,returnPipe.heatPort) annotation(Line(
			points={{65,55},{70,55},{65,55},{70,55}},
			color={191,0,0},
			thickness=0.0625));
		connect(convectiveResistorFlow.fluid,flowPipe.heatPort) annotation(Line(
			points={{-110,55},{-105,55},{-110,55},{-105,55}},
			color={191,0,0},
			thickness=0.0625));
		//TRCM
		connect(convectiveResistorReturn.solid,R_fluidToGrout_return.port_a) annotation(Line(
			points={{40,55},{45,55},{40,55},{45,55}},
			color={191,0,0},
			thickness=0.0625));
		connect(convectiveResistorFlow.solid,R_fluidToGrout_flow.port_a) annotation(Line(
			points={{-85,55},{-80,55},{-85,55},{-80,55}},
			color={191,0,0},
			thickness=0.0625));
		if useTRCMmodel then		
			//flow part
			connect(R_fluidToGrout_flow.port_b,C_grout_flow.port) annotation(Line(
			points={{-60,55},{-55,55},{-50,55},{-50,65},{-50,70}},
			color={191,0,0},
			thickness=0.0625));
			connect(C_grout_flow.port,R_groutToWall_flow.port_a) annotation(Line(
			points={{-50,35},{-50,40},{-50,65},{-50,70}},
			color={191,0,0},
			thickness=0.0625));
			connect(R_groutToWall_flow.port_b,boreholeWallPort) annotation(Line(
			points={{-50,15},{-50,10},{-50,-25},{-25,-25},{-20,-25}},
			color={191,0,0},
			thickness=0.0625));
			connect(C_grout_flow.port,R_groutToGrout.port_a) annotation(Line(
			points={{-15,55},{-10,55},{5,55},{5,65},{5,70}},
			color={191,0,0},
			thickness=0.0625));
			//return part
			connect(R_fluidToGrout_return.port_b,C_grout_return.port) annotation(Line(
			points={{-60,55},{-55,55},{-50,55},{-50,65},{-50,70}},
			color={191,0,0},
			thickness=0.0625));
			connect(C_grout_return.port,R_groutToWall_return.port_a) annotation(Line(
			points={{-50,35},{-50,40},{-50,65},{-50,70}},
			color={191,0,0},
			thickness=0.0625));
			connect(R_groutToWall_return.port_b,boreholeWallPort) annotation(Line(
			points={{-50,15},{-50,10},{-50,-25},{-25,-25},{-20,-25}},
			color={191,0,0},
			thickness=0.0625));
			connect(C_grout_return.port,R_groutToGrout.port_b) annotation(Line(
			points={{-15,55},{-10,55},{5,55},{5,65},{5,70}},
			color={191,0,0},
			thickness=0.0625));
		else
			connect(R_fluidToGrout_flow.port_b,boreholeWallPort) annotation(Line(points=0));
			connect(R_fluidToGrout_return.port_b,boreholeWallPort) annotation(Line(points=0));
			connect(convectiveResistorFlow.solid,R_groutToGrout.port_a) annotation(Line(points=0));
			connect(convectiveResistorReturn.solid,R_groutToGrout.port_b) annotation(Line(points=0));
		end if;
	annotation(
		Icon(graphics={
			Rectangle(
				fillColor={150,150,150},
				fillPattern=FillPattern.Solid,
				extent={{-66.7,100},{-30,-100}}),
			Rectangle(
				fillColor={224,0,0},
				fillPattern=FillPattern.Solid,
				extent={{-60,-100},{-36.7,100}}),
			Rectangle(
				fillColor={150,150,150},
				fillPattern=FillPattern.Solid,
				extent={{32.5,99.8},{69.2,-100.2}}),
			Rectangle(
				fillColor={87,128,255},
				fillPattern=FillPattern.Solid,
				extent={{39.4,-100.2},{62.7,99.8}})}),
		Documentation(info="<html>
<p>
Model of a single-U borehole heat exchanger segment:
</p>



</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.002,
			Solver(
				bOptimization=true,
				bBigObj=true,
				typename="MultiStepMethod2"),
			MaxInterval="0.001"));
end SingleUsegment;
