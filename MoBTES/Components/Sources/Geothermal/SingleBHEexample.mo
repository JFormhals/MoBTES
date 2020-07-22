within MoBTES.Components.Sources.Geothermal;
model SingleBHEexample "Single BHE example model "
 extends Modelica.Icons.Example;
 SingleBHE bhe(
  location(
   layers=1,
   layerThicknessVector={1000,1000,1,1,1}),
  redeclare replaceable parameter Parameters.Grouts.Grout08 groutData,
  redeclare replaceable parameter Modelica.Thermal.FluidHeatFlow.Media.Gylcol20_20degC medium(rho(displayUnit="kg/m³"))) annotation(Placement(transformation(extent={{55,-10},{95,30}})));
 Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe1(medium=
        Modelica.Thermal.FluidHeatFlow.Media.Gylcol20_20degC(),
  m=20,
  T0(displayUnit="K")=bhe.location.Taverage,
  T0fixed=true,
  tapT=0.5,
  V_flowLaminar=0.1,
  dpLaminar=0.09999999999999999,
  V_flowNominal=1,
  dpNominal=1,
  useHeatPort=true,
  h_g=0) annotation(Placement(transformation(
  origin={65,50},
  extent={{-10,-10},{10,10}},
  rotation=-90)));
 Modelica.Thermal.FluidHeatFlow.Sources.AbsolutePressure absolutePressure1(
  medium = Modelica.Thermal.FluidHeatFlow.Media.Gylcol20_20degC(),
  p=100000) annotation(Placement(transformation(
  origin={75,90},
  extent={{-10,-10},{10,10}},
  rotation=90)));
 Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation(Placement(transformation(extent={{30,40},{50,60}})));
 Modelica.Blocks.Tables.CombiTable1D VDI4640heatingProfile(
  table={{1,0.155},
   {2,0.15},
   {3,0.125},
   {4,0.1},
   {5,0.065},
   {6,0},
   {7,0},
   {8,0},
   {9,0.06},
   {10,0.085},
   {11,0.115},
   {12,0.145}},
  smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) annotation(Placement(transformation(extent={{-70,45},{-50,65}})));
 Modelica.Blocks.Sources.RealExpression annualHeatExtraction(y(
  quantity="Energy",
  displayUnit="MWh")=-22680000000.0) annotation(Placement(transformation(extent={{-65,70},{-45,90}})));
 Weather.WeatherData weatherData annotation(Placement(transformation(extent={{-45,-5},{-85,35}})));
 Modelica.Blocks.Math.Division monthlyExtractionPower annotation(Placement(transformation(extent={{5,40},{25,60}})));
 Modelica.Blocks.Math.Product monthlyHeatDemand annotation(Placement(transformation(extent={{-30,55},{-10,75}})));
 Modelica.Blocks.Sources.RealExpression volumeFlow(y(
  quantity="VolumeFlowRate",
  displayUnit="l/s")=0.001) annotation(Placement(transformation(extent={{15,10},{35,30}})));
 Modelica.Blocks.Tables.CombiTable1D EEDinletTemperature(
  y(quantity="CelsiusTemperature"),
  tableOnFile=true,
  table={{1,0.155},
   {2,0.15},
   {3,0.125},
   {4,0.1},
   {5,0.065},
   {6,0},
   {7,0},
   {8,0},
   {9,0.06},
   {10,0.085},
   {11,0.115},
   {12,0.145}},
  tableName="Tin",
  fileName=Modelica.Utilities.Files.loadResource("modelica://MoBTES/Data/Geothermal/MoBTES_SingleBHEexampleEEDresultTin.txt"),
  smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation(Placement(transformation(extent={{5,-20},{25,0}})));
 Modelica.Blocks.Sources.Clock clock1 annotation(Placement(transformation(extent={{-30,-20},{-10,0}})));
 Modelica.Blocks.Tables.CombiTable1D EEDoutletTemperature1(
  y(quantity="CelsiusTemperature"),
  tableOnFile=true,
  table={{1,0.155},
   {2,0.15},
   {3,0.125},
   {4,0.1},
   {5,0.065},
   {6,0},
   {7,0},
   {8,0},
   {9,0.06},
   {10,0.085},
   {11,0.115},
   {12,0.145}},
  tableName="Tout",
  fileName=Modelica.Utilities.Files.loadResource("modelica://MoBTES/Data/Geothermal/MoBTES_SingleBHEexampleEEDresultTout.txt"),
  smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation(Placement(transformation(extent={{5,-45},{25,-25}})));
 Modelica.Blocks.Sources.RealExpression secondsPerMonth1(y=8760*3600/12) annotation(Placement(transformation(extent={{-30,30},{-10,50}})));

equation
  connect(pipe1.flowPort_a,absolutePressure1.flowPort) annotation(Line(
   points={{65,60},{65,65},{65,75},{75,75},{75,80}},
   color={255,0,0},
   thickness=0.0625));
  connect(pipe1.flowPort_b,bhe.flowPort) annotation(Line(
   points={{65,40},{65,35},{65,30}},
   color={255,0,0},
   thickness=0.0625));
  connect(prescribedHeatFlow1.port,pipe1.heatPort) annotation(Line(
   points={{50,50},{55,50},{50,50},{55,50}},
   color={191,0,0},
   thickness=0.0625));
  connect(VDI4640heatingProfile.y[1],monthlyHeatDemand.u2) annotation(Line(
   points={{-49,55},{-44,55},{-37,55},{-37,59},{-32,59}},
   color={0,0,127},
   thickness=0.0625));
  connect(annualHeatExtraction.y,monthlyHeatDemand.u1) annotation(Line(
   points={{-44,80},{-39,80},{-37,80},{-37,71},{-32,71}},
   color={0,0,127},
   thickness=0.0625));
  connect(monthlyHeatDemand.y,monthlyExtractionPower.u1) annotation(Line(
   points={{-9,65},{-4,65},{-2,65},{-2,56},{3,56}},
   color={0,0,127},
   thickness=0.0625));
  connect(monthlyExtractionPower.y,prescribedHeatFlow1.Q_flow) annotation(Line(
   points={{26,50},{31,50},{25,50},{30,50}},
   color={0,0,127},
   thickness=0.0625));
  connect(volumeFlow.y,bhe.busPort.BHE_volFlow[1]) annotation(Line(
   points={{36,20},{41,20},{50,20},{55,20}},
   color={0,0,127},
   thickness=0.0625));
  connect(clock1.y,EEDinletTemperature.u[1]) annotation(Line(
   points={{-9,-10},{-4,-10},{-2,-10},{3,-10}},
   color={0,0,127},
   thickness=0.0625));
  connect(EEDoutletTemperature1.u[1],clock1.y) annotation(Line(
   points={{3,-35},{-2,-35},{-4,-35},{-4,-10},{-9,-10}},
   color={0,0,127},
   thickness=0.0625));
  connect(secondsPerMonth1.y,monthlyExtractionPower.u2) annotation(Line(
   points={{-9,40},{-4,40},{-2,40},{-2,44},{3,44}},
   color={0,0,127},
   thickness=0.0625));
  connect(VDI4640heatingProfile.u[1],weatherData.weatherPort.monthOfTheYear) annotation(Line(
   points={{-72,55},{-77,55},{-89.7,55},{-89.7,15},{-84.67,15}},
   color={0,0,127},
   thickness=0.0625));
  connect(bhe.returnPort,absolutePressure1.flowPort) annotation(Line(
   points={{85,30},{85,35},{85,75},{75,75},{75,80}},
   color={0,0,255},
   thickness=0.0625));
    annotation (Placement(transformation(extent={{-62,-62},{-42,-42}})),
  Documentation(info="<html>
<head>
<style type=\"text/css\">
a {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt;}
body, blockquote, table, p, li, dl, ul, ol {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; color: black;}
h3 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11pt; font-weight: bold;}
h4 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; font-weight: bold;}
h5 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9pt; font-weight: bold;}
h6 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9pt; font-weight: bold; font-style:italic}
pre {font-family: Courier, monospace; font-size: 9pt;}
td {vertical-align:top;}
th {vertical-align:top;}
</style>
</head>

<p>
Simple model for the comparison of the performance of different MoBTES models to 3D FEM models.
</p>
<ul>
<li>Simulation of 50 years</li>
<li>The model was compared against a common software for the design of borehole heat exchanger sytsems EED (Earth Energy Designer <a href=\"modelica://MoBTES.UsersGuide.References\">[EED2020]</a>)</li>
<li>Typical load and design data as given by the German VDI 4640 standard (VDI 4640 - Part 2 - 2019).  <a href=\"modelica://MoBTES.UsersGuide.References\">[VDI2019]</a></li>
</ul>

</html>"),
  experiment(
   StopTime=1576800000,
   StartTime=0,
   Interval=86400,
   Solver(
    bEffJac=true,
    bSparseMat=true,
    typename="CVODE"),
   SolverOptions(
    solver="CVODE",
    typename="ExternalCVODEOptionData"),
   MaxInterval="86400"));
end SingleBHEexample;
