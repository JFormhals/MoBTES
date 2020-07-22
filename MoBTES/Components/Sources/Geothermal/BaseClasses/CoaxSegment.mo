// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Sources.Geothermal.BaseClasses;
model CoaxSegment "Coaxial borehole heat exchanger"
	extends BHEsegment_partial;
	Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C_grout(
		C=groutData.cp*(BHEdata.dBorehole^2-BHEdata.dPipe2^2)/4*segmentLength*groutData.rho*Modelica.Constants.pi,
		T(
			start=Tinitial,
			fixed=true))if useTRCMmodel "Grout thermal capacity";
	Utilities.FluidHeatFlow.SimpleHeatedPipe outerPipe(
		medium=medium,
		m=(((BHEdata.dPipe2/2-BHEdata.tPipe2)^2-(BHEdata.dPipe1/2)^2)*Modelica.Constants.pi*segmentLength*medium.rho),
		T(
			start=Tinitial,
			fixed=true)) "annular gap of coaxial pipe";
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_pipeToPipe(R=log(0.5*BHEdata.dPipe1/(0.5*BHEdata.dPipe1-BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1*segmentLength)) "thermal resistance due to conduction in inner pipe" annotation(Placement(transformation(extent={{-50,65},{-30,85}})));
	Utilities.FluidHeatFlow.SimpleHeatedPipe innerPipe(
		medium=medium,
		m=((BHEdata.dPipe1/2-BHEdata.tPipe1)^2*Modelica.Constants.pi*segmentLength*medium.rho),
		T(
			start=Tinitial,
			fixed=true)) "inner pipe of coaxial pipe";
	Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1(m=2);
	Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor Rconv_inner "convective thermal resistance ";
	Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor Rconv_annularInner "convective thermal resistance";
	Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor Rconv_annularOuter "convective thermal resistance";
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_groutToWall(R=(1-x_grout_center)*log(BHEdata.dBorehole/BHEdata.dPipe2)/(2*Modelica.Constants.pi*groutData.lamda*segmentLength))if useTRCMmodel "conductive thermal resistance from grout centre of mass to borehole wall" annotation(Placement(transformation(
		origin={40,-5},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_pipeToGrout(R=(x_grout_center)*log(BHEdata.dBorehole/BHEdata.dPipe2)/(2*Modelica.Constants.pi*groutData.lamda*segmentLength)) "conductive thermal resistance from outer pipe to grout centre of mass" annotation(Placement(transformation(
		origin={40,25},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	parameter Real x_grout_center=if useTRCMmodel then log(sqrt(BHEdata.dBorehole^2+BHEdata.dPipe2^2)/(sqrt(2)*BHEdata.dPipe2))/log(BHEdata.dBorehole/BHEdata.dPipe2) else 1 "auxillary variable for grout centre of mass";
	parameter Real segmentLength(
		quantity="Length",
		displayUnit="m") "length of pipe segment";
	parameter Real Tinitial(quantity="CelsiusTemperature")=283.14999999999998 "initial BHE temperature";
	equation
		//convective resistances
		Rconv_inner.Rc=Radvective[1]/segmentLength;
		Rconv_annularInner.Rc=Radvective[2]/segmentLength;
		Rconv_annularOuter.Rc=Radvective[3]/segmentLength;
		connect(bottomReturnPort,outerPipe.flowPort_b) annotation(Line(points=0));
		connect(bottomFlowPort,innerPipe.flowPort_a) annotation(Line(points=0));
		connect(topReturnPort,outerPipe.flowPort_a) annotation(Line(points=0));
		
		connect(topFlowPort,innerPipe.flowPort_b) annotation(Line(points=0));
		connect(innerPipe.heatPort,Rconv_inner.fluid) annotation(Line(points=0));
		connect(Rconv_inner.solid,R_pipeToPipe.port_a) annotation(Line(points=0));
		connect(R_pipeToPipe.port_b,Rconv_annularInner.solid) annotation(Line(points=0));
		connect(Rconv_annularInner.fluid,thermalCollector1.port_a[2]) annotation(Line(points=0));
		connect(Rconv_annularOuter.fluid,thermalCollector1.port_a[1]) annotation(Line(points=0));
		connect(Rconv_annularOuter.solid,R_pipeToGrout.port_a) annotation(Line(points=0));
		if useTRCMmodel then
			connect(R_pipeToGrout.port_b,C_grout.port) annotation(Line(points=0));
			connect(C_grout.port,R_groutToWall.port_a) annotation(Line(points=0));
			connect(R_groutToWall.port_b,boreholeWallPort) annotation(Line(points=0));
			
		else
			connect(R_pipeToGrout.port_b,boreholeWallPort) annotation(Line(points=0));
		end if;
		connect(thermalCollector1.port_b,outerPipe.heatPort) annotation(Line(points=0));
	annotation(
		Icon(graphics={
			Rectangle(
				fillColor={120,120,120},
				fillPattern=FillPattern.Solid,
				extent={{-60.2,100},{63.1,-100}}),
			Rectangle(
				fillColor={87,128,255},
				fillPattern=FillPattern.Solid,
				extent={{-50,100},{53.3,-100}}),
			Rectangle(
				fillColor={120,120,120},
				fillPattern=FillPattern.Solid,
				extent={{-33.3,100},{36.7,-100}}),
			Rectangle(
				fillColor={224,0,0},
				fillPattern=FillPattern.Solid,
				extent={{-23.3,100},{26.7,-100}})}),
		Documentation(info="<html>
<p>
Model of a coaxial borehole heat exchanger segment
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
end CoaxSegment;
