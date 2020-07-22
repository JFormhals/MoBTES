within MoBTES.Components.Sources.Geothermal;
model SingleBHE "NewModel1"
 MoBTES.Utilities.Interfaces.FlowPort flowPort(medium=medium) "flow for storage chrging " annotation(Placement(
  transformation(extent={{-20,90},{0,110}}),
  iconTransformation(extent={{-110,190},{-90,210}})));
 MoBTES.Utilities.Interfaces.ReturnPort returnPort(medium=medium) "return for storage charging" annotation(Placement(
  transformation(extent={{5,90},{25,110}}),
  iconTransformation(extent={{90,190},{110,210}})));
 MoBTES.Utilities.Interfaces.Weather weatherPort if not settingsData.useAverageSurfaceTemperature "Temperature at ground surface" annotation(Placement(
  transformation(extent={{-110,20},{-90,40}}),
  iconTransformation(extent={{-10,-206.7},{10,-186.7}})));
 MoBTES.Utilities.Interfaces.componentBusPorts.BHEbus busPort(nBHEs=numberOfComponents) "Port for system control" annotation(Placement(
  transformation(extent={{-110,40},{-90,60}}),
  iconTransformation(extent={{-210,90},{-190,110}})));
 Modelica.Blocks.Sources.RealExpression TsurfaceAverage(y=location.Taverage) if
                                                                               settingsData.useAverageSurfaceTemperature annotation(Placement(transformation(extent={{130,65},{150,85}})));
 Modelica.SIunits.Temperature Tflow(displayUnit="°C") "BHE flow temperature";
 Modelica.SIunits.Temperature Treturn(displayUnit="°C") "BHE return temperature";
 Modelica.SIunits.Temperature TboreholeWall(displayUnit="°C") "Borehole wall temperature at half BHE depth";
 Modelica.SIunits.VolumeFlowRate volFlow(displayUnit="l/s") "BHE volume flow (flow-> return)";
 Modelica.SIunits.Power Pthermal(displayUnit="kW") "Thermal power";
 Modelica.SIunits.Energy Qthermal(
  displayUnit="MWh",
  start=0,
  fixed=true) "Thermal ernergy balance";
 Modelica.SIunits.Energy QthermalInjected(
  displayUnit="MWh",
  start=0,
  fixed=true) "Thermal energy charged into storage";
 Modelica.SIunits.Energy QthermalExtracted(
  displayUnit="MWh",
  start=0,
  fixed=true) "Thermal energy discharged from storage";
 Modelica.SIunits.Pressure dp "Pressure drop (p_flow - p_return)";
 inner parameter Modelica.SIunits.Length BHElength(
  displayUnit="m",
  min=20,
  max=2000)=100 "Length of BHE" annotation(Dialog(
  group="Borehole Heat Exchanger",
  tab="Design"));
 parameter Modelica.SIunits.Length BHEstart(
  displayUnit="m",
  min=0.5,
  max=10)=1 "Depth of BHE heads" annotation(Dialog(
  group="Borehole Heat Exchanger",
  tab="Design"));
 replaceable parameter Parameters.Locations.TUDa location constrainedby
    MoBTES.Parameters.Locations.LocationPartial                                                                     "Local geology" annotation (
  choicesAllMatching=true,
  Dialog(
   group="Dimensions",
   tab="Design"));
 replaceable model BHEmodel = Geothermal.BaseClasses.DoubleUsegment constrainedby
    MoBTES.Components.Sources.Geothermal.BaseClasses.BHEsegment_partial                                                                               "BHE type" annotation (
  choicesAllMatching=true,
  Placement(transformation(extent={{-10, -10}, {10, 10}})),
  Dialog(
   group="Borehole Heat Exchanger",
   tab="Design"));
 replaceable parameter Parameters.BoreholeHeatExchangers.DoubleU_DN32 BHEdata constrainedby
    MoBTES.Parameters.BoreholeHeatExchangers.BHEparameters                                                                                         "BHE dataset" annotation (
  choicesAllMatching=true,
  Dialog(
   group="Borehole Heat Exchanger",
   tab="Design"));
 parameter Integer numberOfComponents(min=1)=1 "Number of components of the same type" annotation(Dialog(
  group="Setpoint",
  tab="Control",
  enable=useControlInput));
 parameter Integer componentID(min=1)=1 "ID if more than one component of the sam type is used" annotation(Dialog(
  group="Setpoint",
  tab="Control",
  enable=useControlInput));
protected
  inner parameter Integer nBHEs=1;
  inner parameter Integer nSeries=1;
  parameter Modelica.SIunits.Length rEquivalent=5 "Radius of BHE volume";
  parameter Real heights[nElementsZ]=MoBTES.Components.Storage.BoreholeStorage.Functions.ElementHeights(MoBTES.Components.Storage.BoreholeStorage.Functions.SupermeshZ(BHEstart, useUpperGroutSection, lengthUpperGroutSection,  BHElength, settingsData.relativeModelDepth, location.layerThicknessVector), integer(floor(settingsData.nBHEelementsZdesired / 2)), settingsData.dZminDesired, settingsData.growthFactor, nElementsZ) "Vector for vertical discretization";
  parameter Real meshZ[nElementsZ+1]=cat(1, {0}, array(sum(heights[i] for i in 1:j) for j in 1:nElementsZ)) "Vector containing absolute depth of mesh nodes";
  parameter Real meshR[nElementsR+1]=MoBTES.Components.Storage.BoreholeStorage.Functions.MeshR({1}, rEquivalent, nElementsR) "Vector containing absolute radius of mesh nodes";
  parameter Integer nElementsZ=MoBTES.Components.Storage.BoreholeStorage.Functions.nElementsZ(MoBTES.Components.Storage.BoreholeStorage.Functions.SupermeshZ(BHEstart, useUpperGroutSection, lengthUpperGroutSection,  BHElength, settingsData.relativeModelDepth, location.layerThicknessVector), integer(floor(settingsData.nBHEelementsZdesired / 2)), settingsData.dZminDesired, settingsData.growthFactor) "Number of elements in vertcial direction";
  parameter Integer nElementsR=nBHEelementsR + 3 + settingsData.nAdditionalElementsR "Number of elements in radial direction";
  parameter Integer nTopElementsZ=iBHEheadElement-1;
  parameter Integer nTopElementsR=nElementsR;
  parameter Integer nSideElementsZ=nBHEelementsZ;
  parameter Integer nSideElementsR=nElementsR-nBHEelementsR;
  parameter Integer nBottomElementsZ=nElementsZ-iBHEbottomElement;
  parameter Integer nBottomElementsR=nElementsR;
  parameter Integer nBHEelementsR=1 "Number of rings containg a BHE";
  parameter Integer nBHEelementsZ=iBHEbottomElement - iBHEheadElement + 1 "Number of layers containing  a BHE";
  parameter Integer iBHEheadElement=MoBTES.Components.Storage.BoreholeStorage.Functions.BHE_HeadElementIndex(meshZ, BHEstart) "Index of the element containg the BHE head";
  parameter Integer iGroutChange=if useUpperGroutSection then Modelica.Math.Vectors.find(BHEstart + lengthUpperGroutSection, meshZ) else 0 "Index of the first element of the main/lower grout section.";
  parameter Integer iBHEbottomElement=MoBTES.Components.Storage.BoreholeStorage.Functions.BHE_BottomElementIndex(meshZ, BHEstart, BHElength) "Index of the element containg the BHE bottom";
  parameter Integer iTopStartZ=1;
  parameter Integer iTopEndZ=iBHEheadElement-1;
  parameter Integer iTopStartR=1;
  parameter Integer iTopEndR=nElementsR;
  parameter Integer iSideStartZ=iBHEheadElement;
  parameter Integer iSideEndZ=iBHEbottomElement;
  parameter Integer iSideStartR=nBHEelementsR+1;
  parameter Integer iSideEndR=nElementsR;
  parameter Integer iBottomStartZ=iBHEbottomElement+1;
  parameter Integer iBottomEndZ=nElementsZ;
  parameter Integer iBottomStartR=1;
  parameter Integer iBottomEndR=nElementsR;
  parameter Real GROUND_innerRadiusMatrix[nElementsZ,nElementsR]=fill(meshR[1:nElementsR], nElementsZ) "Inner radii of volume elements";
  parameter Real GROUND_outerRadiusMatrix[nElementsZ,nElementsR]=fill(meshR[2:nElementsR + 1], nElementsZ) "Outer radii of volume elements";
  parameter Real GROUND_elementHeightsMatrix[nElementsZ,nElementsR]=transpose(fill(heights, nElementsR)) "Matrix containg heights for each element of the global problem";
  parameter Real GROUND_TinitialMatrix[nElementsZ,nElementsR]=array(location.Taverage + (meshZ[z] + heights[z] / 2) * location.geoGradient for r in 1:nElementsR, z in 1:nElementsZ) "Matrix containg initial temperature for each element of the global problem";
  parameter Real GROUND_groundDataMatrix[3,nElementsZ,nElementsR]=MoBTES.Components.Storage.BoreholeStorage.Functions.ElementGroundData(heights, nElementsR, location) "Matrix containg thermal properties for each element of the global problem {rho,cp,lamda}";
  parameter Real GROUND_capacityMatrix[nElementsZ,nElementsR]=array(GROUND_groundDataMatrix[1, z, r] * GROUND_groundDataMatrix[2, z, r] * Modelica.Constants.pi * GROUND_elementHeightsMatrix[z, r] * (GROUND_outerRadiusMatrix[z, r] ^ 2 - GROUND_innerRadiusMatrix[z, r] ^ 2) for r in 1:nElementsR, z in 1:nElementsZ) "Matrix containg the thermal capacity for each element of the global problem";
  parameter Real BHE_groutDataMatrix[3,nBHEelementsZ,nBHEelementsR]={array(if z >= iGroutChange then groutData.rho else groutDataUpper.rho for r in 1:nBHEelementsR, z in 1:nBHEelementsZ), array(if z >= iGroutChange then groutData.cp else groutDataUpper.cp for r in 1:nBHEelementsR, z in 1:nBHEelementsZ), array(if z >= iGroutChange then groutData.lamda else groutDataUpper.lamda for r in 1:nBHEelementsR, z in 1:nBHEelementsZ)};
public
  parameter Boolean useUpperGroutSection=false "=true, if grout is divided into an upper and a lower section." annotation(Dialog(
   group="Grout",
   tab="Design"));
  replaceable parameter Parameters.Grouts.Grout15 groutData constrainedby
    MoBTES.Parameters.Grouts.GroutPartial                                                                       "Grout dataset" annotation (
   choicesAllMatching=true,
   Dialog(
    group="Grout",
    tab="Design"));
  replaceable parameter Parameters.Grouts.Grout15 groutDataUpper constrainedby
    MoBTES.Parameters.Grouts.GroutPartial                                                                            "Grout dataset" annotation (
   choicesAllMatching=true,
   Dialog(
    group="Grout",
    tab="Design",
    enable=useUpperGroutSection));
  parameter Modelica.SIunits.Length lengthUpperGroutSection(
   displayUnit="m",
   min=1,
   max=0.5 * BHElength)=1 "Length of upper grout section." annotation(Dialog(
   group="Grout",
   tab="Design",
   enable=useUpperGroutSection));
  replaceable parameter Modelica.Thermal.FluidHeatFlow.Media.Gylcol20_20degC medium constrainedby
    Modelica.Thermal.FluidHeatFlow.Media.Medium                                                                                               "Medium inside the BHE" annotation (
   choicesAllMatching=true,
   Dialog(
    group="Hydraulics",
    tab="Design"));
  parameter Boolean useTRCMmodel=true "=true, if BHE model considers thermal capaciities " annotation(Dialog(
   group="Borehole heat exchanger",
   tab="Modeling"));
  replaceable parameter Parameters.Settings.SettingsDefault settingsData constrainedby
    MoBTES.Parameters.Settings.SettingsPartial                                                                                    "Numerical settings" annotation(Dialog(
   group="Model",
   tab="Modeling"));
protected
  BaseClasses.BHEhead BHE_Head(
   BHEdata=BHEdata,
   medium=medium,
   Tinitial=location.Taverage,
   BHElength=BHElength) annotation(Placement(transformation(extent={{-10,20},{10,40}})));
  replaceable BHEmodel BHE_SegmentMatrix[nBHEelementsZ,nBHEelementsR] constrainedby
    MoBTES.Components.Sources.Geothermal.BaseClasses.BHEsegment_partial(
   segmentLength(each fixed=true)=GROUND_elementHeightsMatrix[iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
   Tinitial(each fixed=true)=GROUND_TinitialMatrix[iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
   each medium=medium,
   each BHEdata=BHEdata,
   groutData(
    rho(each fixed=true)=BHE_groutDataMatrix[1],
    cp(each fixed=true)=BHE_groutDataMatrix[2],
    lamda(each fixed=true)=BHE_groutDataMatrix[3]),
   each useTRCMmodel=useTRCMmodel) "Borehole heat exchanger type" annotation (
   Placement(transformation(extent={{-10,-10},{10,10}})),
   Dialog(
    group="Borehole Heat Exchanger",
    tab="Design"));
  Ground.GlobalElement_circular GLOBAL_elementMatrixTop[nTopElementsZ,nTopElementsR](
   groundData(
    rho(each fixed=true)=GROUND_groundDataMatrix[1,iTopStartZ:iTopEndZ,iTopStartR:iTopEndR],
    cp(each fixed=true)=GROUND_groundDataMatrix[2,iTopStartZ:iTopEndZ,iTopStartR:iTopEndR],
    lamda(each fixed=true)=GROUND_groundDataMatrix[3,iTopStartZ:iTopEndZ,iTopStartR:iTopEndR]),
   innerRadius(each fixed=true)=GROUND_innerRadiusMatrix[iTopStartZ:iTopEndZ,iTopStartR:iTopEndR],
   outerRadius(each fixed=true)=GROUND_outerRadiusMatrix[iTopStartZ:iTopEndZ,iTopStartR:iTopEndR],
   elementHeight(each fixed=true)=transpose(fill(heights[iTopStartZ:iTopEndZ],nTopElementsR))) "Global problem modeling approach" annotation (
   Placement(transformation(extent={{50,30},{70,50}})),
   Dialog(
    group="Global problem",
    tab="Modeling"));
  Ground.GlobalElement_circular GLOBAL_elementMatrixSide[nSideElementsZ,nSideElementsR](
   groundData(
    rho(each fixed=true)=GROUND_groundDataMatrix[1,iSideStartZ:iSideEndZ,iSideStartR:iSideEndR],
    cp(each fixed=true)=GROUND_groundDataMatrix[2,iSideStartZ:iSideEndZ,iSideStartR:iSideEndR],
    lamda(each fixed=true)=GROUND_groundDataMatrix[3,iSideStartZ:iSideEndZ,iSideStartR:iSideEndR]),
   innerRadius(each fixed=true)=GROUND_innerRadiusMatrix[iSideStartZ:iSideEndZ,iSideStartR:iSideEndR],
   outerRadius(each fixed=true)=GROUND_outerRadiusMatrix[iSideStartZ:iSideEndZ,iSideStartR:iSideEndR],
   elementHeight(each fixed=true)=transpose(fill(heights[iSideStartZ:iSideEndZ],nSideElementsR))) "Global problem modeling approach" annotation (
   Placement(transformation(extent={{50,-10},{70,10}})),
   Dialog(
    group="Global problem",
    tab="Modeling"));
  Ground.GlobalElement_circular GLOBAL_elementMatrixBottom[nBottomElementsZ,nBottomElementsR](
   groundData(
    rho(each fixed=true)=GROUND_groundDataMatrix[1,iBottomStartZ:iBottomEndZ,iBottomStartR:iBottomEndR],
    cp(each fixed=true)=GROUND_groundDataMatrix[2,iBottomStartZ:iBottomEndZ,iBottomStartR:iBottomEndR],
    lamda(each fixed=true)=GROUND_groundDataMatrix[3,iBottomStartZ:iBottomEndZ,iBottomStartR:iBottomEndR]),
   innerRadius(each fixed=true)=GROUND_innerRadiusMatrix[iBottomStartZ:iBottomEndZ,iBottomStartR:iBottomEndR],
   outerRadius(each fixed=true)=GROUND_outerRadiusMatrix[iBottomStartZ:iBottomEndZ,iBottomStartR:iBottomEndR],
   elementHeight(each fixed=true)=transpose(fill(heights[iBottomStartZ:iBottomEndZ], nBottomElementsR))) "Global problem modeling approach" annotation (
   Placement(transformation(extent={{50,-50},{70,-30}})),
   Dialog(
    group="Global problem",
    tab="Modeling"));
  Ground.CylinderElement_FiniteDifferences LOCAL_elementMatrix[nBHEelementsZ,nBHEelementsR](
   groundData(
    rho(each fixed=true)=GROUND_groundDataMatrix[1, iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
    cp(each fixed=true)=GROUND_groundDataMatrix[2, iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
    lamda(each fixed=true)=GROUND_groundDataMatrix[3, iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR]),
   each numberOfBHEsInRing(each fixed=true)=1,
   each nRings=settingsData.dynamicModelOrder,
   each rEquivalent=rEquivalent,
   each rBorehole=BHEdata.dBorehole / 2,
   elementHeight(each fixed=true)=GROUND_elementHeightsMatrix[iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR],
   Tinitial(each fixed=true)=GROUND_TinitialMatrix[iBHEheadElement:iBHEbottomElement, 1:nBHEelementsR]) "Local problem modeling approach" annotation (
   Placement(transformation(extent={{20,-10},{40,10}})),
   Dialog(
    group="Local problem",
    tab="Modeling"));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor GLOBAL_groundCapacitiesTop[nTopElementsZ,nTopElementsR](
   C=GROUND_capacityMatrix[iTopStartZ:iTopEndZ,iTopStartR:iTopEndR],
   T(
    start=GROUND_TinitialMatrix[iTopStartZ:iTopEndZ,iTopStartR:iTopEndR],
    each fixed=true)) "Thermal capacities of global model elements above the storage" annotation (
   choicesAllMatching=true,
   Placement(transformation(extent={{65,50},{85,70}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor GLOBAL_groundCapacitiesSide[nSideElementsZ,nSideElementsR](
   C=GROUND_capacityMatrix[iSideStartZ:iSideEndZ,iSideStartR:iSideEndR],
   T(
    start=GROUND_TinitialMatrix[iSideStartZ:iSideEndZ,iSideStartR:iSideEndR],
    each fixed=true)) "Thermal capacities of global model elements beside the storage" annotation(Placement(transformation(extent={{65,10},{85,30}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor GLOBAL_groundCapacitiesBottom[nBottomElementsZ,nBottomElementsR](
   C=GROUND_capacityMatrix[iBottomStartZ:iBottomEndZ,iBottomStartR:iBottomEndR],
   T(
    start=GROUND_TinitialMatrix[iBottomStartZ:iBottomEndZ,iBottomStartR:iBottomEndR],
    each fixed=true)) "Thermal capacities of global model elements below the storage" annotation(Placement(transformation(extent={{65,-30},{85,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GLOBAL_outerBC[nElementsZ](T(each fixed=true)=GROUND_TinitialMatrix[:, 1]) "Fixed temperature boundary condition at the model side" annotation(Placement(transformation(extent={{125,-10},{105,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow GLOBAL_innerBC[nElementsZ-nBHEelementsZ](each Q_flow=0) "Fixed heat flow boundary condition at the inner model boundary" annotation(Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature GLOBAL_bottomBC[nElementsR](each T=location.Taverage + meshZ[nElementsZ + 1] * location.geoGradient) "Fixed temperature boundary condition at the model bottom" annotation(Placement(transformation(
   origin={60,-80},
   extent={{-10,-10},{10,10}},
   rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature GLOBAL_topBC[nElementsR] "Variable temperature boundary condition at the model top" annotation(Placement(transformation(
   origin={60,80},
   extent={{-10,-10},{10,10}},
   rotation=-90)));
  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(
   medium=medium,
   T0=location.Taverage,
   T0fixed=true,
   useVolumeFlowInput=true) "BHE pumps" annotation(Placement(transformation(
   origin={-10,80},
   extent={{10,-10},{-10,10}},
   rotation=90)));
initial algorithm
  if settingsData.printModelStructure then
    Modelica.Utilities.Streams.print("GLOBAL[" + String(nElementsZ) + "," + String(nElementsR) + "]:", "");
    Modelica.Utilities.Streams.print("superMeshZ: " + Modelica.Math.Vectors.toString(MoBTES.Components.Storage.BoreholeStorage.Functions.SupermeshZ(BHEstart, useUpperGroutSection, lengthUpperGroutSection,  BHElength, settingsData.relativeModelDepth, location.layerThicknessVector), "", 6), "");
    Modelica.Utilities.Streams.print("meshZ[" + String(nElementsZ) + "]" + Modelica.Math.Vectors.toString(meshZ, "", 6), "");
    Modelica.Utilities.Streams.print("meshR[" + String(nElementsR) + "]" + Modelica.Math.Vectors.toString(meshR, "", 6), "");
    Modelica.Utilities.Streams.print("LOCAL[" + String(nBHEelementsZ) + "," + String(nBHEelementsR) + "]:", "");
    Modelica.Utilities.Streams.print("iBHEheadElement: " + String(iBHEheadElement) + "/ iGroutChange: " + String(iGroutChange) + "/ iBHEbottomElement: " + String(iBHEbottomElement), "");
    end if;
equation
  /*Outputs---------------------------------------------*/
  Tflow = flowPort.h / medium.cp;
  Treturn = returnPort.h / medium.cp;
  volFlow=flowPort.m_flow/medium.rho;
  Pthermal=(Tflow-Treturn)*volFlow*medium.cp*medium.rho;
  der(Qthermal)=Pthermal;
  dp=flowPort.p-returnPort.p;
  der(QthermalInjected) = max(Pthermal, 0);
  der(QthermalExtracted) = abs(min(Pthermal, 0));
  TboreholeWall = BHE_SegmentMatrix[integer((iBHEbottomElement + iBHEheadElement) / 2),1].boreholeWallPort.T;
  pump.volumeFlow=busPort.BHE_volFlow[componentID];
  /*diagnostics*/
  assert(GLOBAL_elementMatrixSide[integer((iBHEbottomElement + iBHEheadElement) / 2), nElementsR-nBHEelementsR].groundCenterPort.T < GROUND_TinitialMatrix[iBHEheadElement-1 + integer((iBHEbottomElement + iBHEheadElement) / 2), nElementsR] + 1, "Temperature of outer model boundary increased by more than 1K --> increase radial model size", AssertionLevel.warning);
  assert(GLOBAL_elementMatrixBottom[nElementsZ-iBHEbottomElement, 1].groundCenterPort.T < GROUND_TinitialMatrix[nElementsZ, 1] + 1, "Temperature at model bottom increased by more than 1K --> increase model depth", AssertionLevel.warning);


  /*GLOBAL Horizontal: connect to neighbour GLOBAL and BCs -----------------------------------------*/
  for z in 1:nElementsZ loop
  /*above BHE*/
    if z <= iTopEndZ then
     connect(GLOBAL_innerBC[z].port,GLOBAL_elementMatrixTop[z,1].innerHeatPort) annotation(Line(points=0));
     connect(GLOBAL_elementMatrixTop[z,nTopElementsR].outerHeatPort,GLOBAL_outerBC[z].port) annotation(Line(points=0));
     for r in 1:nTopElementsR - 1 loop
       connect(GLOBAL_elementMatrixTop[z,r].outerHeatPort,GLOBAL_elementMatrixTop[z,r+1].innerHeatPort) annotation(Line(points=0));
    end for;
  /*beside BHE*/
    elseif z<= iSideEndZ then
     connect(LOCAL_elementMatrix[z-iTopEndZ,1].local2globalPort,GLOBAL_elementMatrixSide[z-iTopEndZ,1].innerHeatPort) annotation(Line(points=0));
     connect(GLOBAL_elementMatrixSide[z-iTopEndZ,nSideElementsR].outerHeatPort,GLOBAL_outerBC[z].port) annotation(Line(points=0));
     for r in 1:(nSideElementsR-1) loop
       connect(GLOBAL_elementMatrixSide[z-iTopEndZ,r].outerHeatPort,GLOBAL_elementMatrixSide[z-iTopEndZ,r+1].innerHeatPort) annotation(Line(points=0));
    end for;
  /*below BHE*/
   else
    connect(GLOBAL_innerBC[z-nSideElementsZ].port,GLOBAL_elementMatrixBottom[z-iSideEndZ,1].innerHeatPort) annotation(Line(points=0));
    connect(GLOBAL_elementMatrixBottom[z-iSideEndZ,nElementsR].outerHeatPort,GLOBAL_outerBC[z].port) annotation(Line(points=0));
    for r in 1:(nBottomElementsR-1) loop
       connect(GLOBAL_elementMatrixBottom[z-iSideEndZ,r].outerHeatPort,GLOBAL_elementMatrixBottom[z-iSideEndZ,r+1].innerHeatPort) annotation(Line(points=0));
    end for;
   end if;
  end for;

  /*GLOBAL Vertical: connect to neighbour GLOBAL and BCs -------------------------------------------*/
  for r in 1:nElementsR loop
    /*GLOBAL to top/bottom boundary conditions*/
   connect(weatherPort.Tambient,GLOBAL_topBC[r].T) annotation(Line(points=0));
   connect(TsurfaceAverage.y,GLOBAL_topBC[r].T) annotation(Line(points=0));
   connect(GLOBAL_topBC[r].port,GLOBAL_elementMatrixTop[1,r].topHeatPort) annotation(Line(points=0));
   connect(GLOBAL_elementMatrixBottom[nBottomElementsZ,r].bottomHeatPort,GLOBAL_bottomBC[r].port) annotation(Line(points=0));
    /*GLOBAL to GLOBAL*/
     /*above BHE*/
     for z in 1:(nTopElementsZ-1) loop
    connect(GLOBAL_elementMatrixTop[z,r].bottomHeatPort,GLOBAL_elementMatrixTop[z+1,r].topHeatPort) annotation(Line(points=0));
     end for;
    /*beside BHE*/
     if r<=nSideElementsR then
      for z in 1:(nSideElementsZ-1) loop
     connect(GLOBAL_elementMatrixSide[z,r].bottomHeatPort,GLOBAL_elementMatrixSide[z+1,r].topHeatPort) annotation(Line(points=0));
      end for;
     end if;
    /*below BHE*/
    for z in 1:(nBottomElementsZ-1) loop
   connect(GLOBAL_elementMatrixBottom[z,r].bottomHeatPort,GLOBAL_elementMatrixBottom[z+1,r].topHeatPort) annotation(Line(points=0));
    end for;
  end for;

  /*GLOBAL: Connect external capacities---------------------------------------------------*/
  /*above storage*/
   connect(GLOBAL_elementMatrixTop.groundCenterPort,GLOBAL_groundCapacitiesTop.port) annotation(Line(
   points={{55,30.33},{55,55},{70,55},{70,45},{75,45},{75,50}},
   color={191,0,0},
   thickness=0.0625));

  /*beside storage*/
   connect(GLOBAL_elementMatrixSide.groundCenterPort,GLOBAL_groundCapacitiesSide.port) annotation(Line(
   points={{55,-9.67},{55,15},{70,15},{70,5},{75,5},{75,10}},
   color={191,0,0},
   thickness=0.0625));

  /*below storage*/
   connect(GLOBAL_elementMatrixBottom.groundCenterPort,GLOBAL_groundCapacitiesBottom.port) annotation(Line(
   points={{55,-49.67},{55,-25},{70,-25},{70,-35},{75,-35},{75,-30}},
   color={191,0,0},
   thickness=0.0625));


  /*BHE element connection----------------------------------------*/
  /*Connect Model in- and outlets to BHE and pump*/
  connect(flowPort,pump.flowPort_a) annotation(Line(
   points={{-10,100},{-15,100},{-15,97.7},{-10,97.7},{-10,95},{-10,
   90}},
   color={255,0,0},
   thickness=1));
  connect(BHE_Head.flowPort,pump.flowPort_b) annotation(Line(
   points={{-5,40},{-5,45},{-5,65},{-10,65},{-10,70}},
   color={255,0,0},
   thickness=1));
  connect(BHE_Head.BHEflow,BHE_SegmentMatrix[1,1].topFlowPort) annotation(Line(
   points={{-5,20.33},{-5,20.33},{-5,15},{-5,10}},
   color={255,0,0},
   thickness=1));
  connect(BHE_Head.BHEreturn,BHE_SegmentMatrix[1,1].topReturnPort) annotation(Line(
   points={{5,20.33},{5,20.33},{5,15},{5,10}},
   color={0,0,255},
   thickness=1));
  connect(BHE_Head.returnPort,returnPort) annotation(Line(
   points={{5,40},{5,45},{5,100},{10,100},{15,100}},
   color={0,0,255},
   thickness=1));
  /*connect BHE segments & LOCAL elements*/
  for r in 1:1 loop
    for z in 1:nBHEelementsZ loop
      if z < nBHEelementsZ then
    connect(BHE_SegmentMatrix[z,r].bottomFlowPort,BHE_SegmentMatrix[z+1,r].topFlowPort) annotation(Line(points=0));
    connect(BHE_SegmentMatrix[z,r].bottomReturnPort,BHE_SegmentMatrix[z+1,r].topReturnPort) annotation(Line(points=0));
      else
    connect(BHE_SegmentMatrix[z,r].bottomFlowPort,BHE_SegmentMatrix[z,r].bottomReturnPort) annotation(Line(points=0));
      end if;
      connect(BHE_SegmentMatrix[z,r].boreholeWallPort,LOCAL_elementMatrix[z,r].boreholeWallPort) annotation(Line(points=0));
    connect(BHE_Head.Radvective,BHE_SegmentMatrix[z, r].Radvective)  annotation(Line(
   points={{-10,30},{-15,30},{-15,0},{-10,0}},
   color={0,0,127},
   thickness=0.0625));
    end for;
  end for;
 annotation (
  Icon(
   coordinateSystem(extent={{-200,-200},{200,200}}),
   graphics={
       Bitmap(
        imageSource="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
GLnqY9rEhRdeOPVq3ERERNRZ9R+f2RA1TW0oj6wyu7K6CY9obsv1PNmZbNmyJf5slNqGDRvkx7Sp
8MrZvAgYERFRZ9V/dGZD1DS1oTyyyuzK6iY8orlr48aN9SdwPaxyuuaaa+LPSKldeeWV8mPajbVr
18arExER0UzVf2xmQ9Q0taE8ssrsyuomPKK5Kbx1keXzll9u2bJl8Wel1MKLpqmPabf4NnkiIqLZ
q//IzIaoaWpDeWSV2ZXVTXhEve/48ePmz1t+uYULF8afmVI6dOiQ/HjmEH5NwvPXiYiIqH31H5nZ
EDVNbSiPrDK7sroJj6j3XXvttfUnbj2krDDO0hsZGZEfy1zCW1YRERFR++o/LrMhapraUB5ZZXZl
dRMeUW87cOBAV9+Kffnll0+92rL6/81kbGwsPgLqtPDcb/WxzGnv3r3xZyMiIqLp1X9UZkPUNLWh
PLLK7MrqJjyi3hZeJVkNp06Eb+MN76nc5JW1eaXs9BYvXiw/ljmFn4NXzSYiItLVf1RmQ9Q0taE8
ssrsyuomPKLe1e23+J57oag1a9bI//9MeKXstMLzzHv1omybN2+OPysRERG9vPqPyWyImqY2lEdW
mV1Z3YRH1JsmJiamvkKsBlMnXv5WRFu3bpX/zEx4pey0wquYq4+jhfBK3OE7B4iIiKi1+o/JbIia
pjaUR1aZXVndhEfUm5p8VficJUuWtHzbbpMxxytlp7Vp0yb5cZzJt3/7t8v/vRMrV66MPzMRERGd
q/4jMhuipqkN5ZFVZldWN+ER2Re+ejh//vz6k7UeSzNZsGBBNT4+Hq/0UuEVr9U/OxteKbvzli9f
Lj+GM/nlX/7lxt9FEL79+/Dhw/FnJyIiolD9R2Q2RE1TG8ojq8yurG7CI7Kvm68uh690qpoMM14p
u/OavBJ5+Fb5bdu2yf9fJ/gqMxERUWv1H4/ZEDVNbSiPrDK7sroJj8i28Nzl8FViNZBmc+mll7Z9
BeXwnGT1Y2bCK2V31pEjR+THbzb79++f+vFLly6V///ZhK8y81xmIiKib1b/8ZgNUdPUhvLIKrMr
q5vwiGxbv359/UlaD6TZhOcqt6vJewTzStmdtWPHDvnxm0n4S5FzdfNe2+G7EYiIiOil6j8asyFq
mtpQHllldmV1Ex6RXeGry+EVkNUwms2qVaviVXThq8Xqx82EV8rurCbfQj/9Y9v02/DDc935KjMR
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
6r7w/rxq4Mwm97f5nqvJtx0Pwitlh493k+d379ixI14hX00ex6FDh+KPJiIiGozqP/6yIWqa2lAe
WWV2ZXUTHlGeLrjggvqTsR467VgNoHBd9fPNpt9fKbvJex8HR44ciVfIU5MXHps3b57ZX7AQERF5
rf4jMBuipqkN5ZFVZldWN+ER5Wnp0qX1J2M9dtoJ75lsVXihKvVzzqTfXyl7y5Yt8r5nctFFF8Uf
na/du3fLn2smg/Ze2URERKH6j8BsiJqmNpRHVpldWd2ER5SnJi+0ZfHc2HM1eY5sv79SdpNfo6uu
uir+6HytX79e/lwzGZTnmBMREb28+o/AbIiapjaUR1aZXVndhEeUpyYvtHXppZfGH52/Jq/C3O+v
lB2+SqvueyYWr0wdXnVb/VwzCa/uTURENGjVfwRmQ9Q0taE8ssrsyuomPKI87dq1q/5krMfOTMLz
WS3ilbJbm5iYkPc8m/AK6Dk7fvz41POR1c81k0F5n2wiIqKXV/8RmA1R09SG8sgqsyurm/CI8tR0
CI2MjMQr5I1Xym4tPF9c3fNMwq9n7hdC8/YXK0RERJ6r/wjMhqhpakN5ZJXZldVNeET5avLCX+F5
tRbxStmtrVu3Tt7vTJYsWRJ/dL7C89bVzzUTXvCLiIgGtfqPwWyImqY2lEdWmV1Z3YRHlK/wHGA1
eGayaNGi+KPzxytlf7MrrrhC3u9Mrrnmmvij8xWet65+rpmsXr06/mgiIqLBqv5jMBuipqkN5ZFV
ZldWN+ER5avpt9vmfp7suXil7G/W5H2yc3+7/IEDB+TPMxuev0xERINa/cdgNkRNUxvKI6vMrqxu
wiPKV9PnMa9atSpeIW9NXik7vOVRv9V0qB4+fDheIU/hla7VzzMbnr9MRESDWv3HYDZETVMbyiOr
zK6sbsIjyluT5zGHr35aPHe4yStlW7zv8Fy3bds2ea8zWbhwYfzReTp16lR10UUXyZ9rJjx/mYiI
Brn6j8JsiJqmNpRHVpldWd2ER5S3Ji8uFVh8222TV8q2fG/ouSo8B1jd60yuvPLK+KPz1PTb9cOL
hBEREQ1q9R+F2RA1TW0oj6wyu7K6CY8ob01fnTr3QAs1eSzhW8rDV0P7qSbP5d6wYUP80XlasWKF
/Hlms3fv3ngFIiKiwav+ozAboqapDeWRVWZXVjfhEeWvybdlh6Fq8VzVJq+UHZ7z2y+F55Wre5zN
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",
        extent={{-199.8,-200},{199.8,200}})}),
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

<h4>General</h4>
<p>The SingleBHE model is an adapted version of the <a href=\"modelica://MoBTES.Components.Storage.BoreholeStorage.BTES\">MoBTES</a> model. It only allows for a single borehole heat exchanger and uses and adapted version of the <a href=\"modelica://MoBTES.Components.Ground.CylinderElement_FiniteDifferences\">finite differences local model</a>. This local model is not connected to the global model via it's average volume temperatuer, but by the temperatures at it's outer boundary. This straight forward approach is better suited for a single BHE and thus more accurate.</p>
<h5>BHE model</h5>
<p>For the BHE models there are currently two options. A thermal-resistance model (TRM) which only considers the thermal resistance between the fluid and the borehole wall and a thermal-resistance-capacitance model (TRCM) which additionally considers the thermal capacity of the grout. For each modelling approach models for single-U, double-U and coaxial heat exchangers are available. <a href=\"modelica://MoBTES.UsersGuide.References\">[Bauer2012]</a></p>

<h4>Model parametrization</h4>
<h5>Design</h5>
<p>Parameters for the BHE <strong>Dimensions, Location, Heat Exchanger types, the Grout and the Heat Carrier Medium</strong> can be defined.</p>
<p>The <strong>location</strong> record contains information on the local geology at the storage site. Up to 5 different layers can be defined in the record, including the insulation layer. Each layer is defined by its type of soil/rock and thickness. The layer thickness can generally be any number greater 0.5 m, but it is strongly recommended to use integer values to avoid unwanted model behaviour and to limit the size of the model's mesh. The average surface temperature and the geothermal gradient define the initial temperature of the model and the boundary conditions.</p>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
  <caption align=\"bottom\"><strong>Fig. 1: </strong>Vertical cross section (Image from MoBTES model)</caption>
  <tr>
    <td>
   <img src=\"modelica://MoBTES/Utilities/Images/BTESsideView.png\" width=\"500\">
    </td>
  </tr>
</table>

<p>The <strong>Borehole Heat Exchanger</strong> parameters define the model inside the borehole. The type of BHE can be selected from single-U, double-U or coaxial. Accordingly a matching BHE data record has to be chosen. Optionally an upper grout section can be defined in the <strong>Grout</strong> section. For each of the two grout sections a different grout data record can be chosen, allowing the user to use a grout material with a reduced thermal conductivity in the top section, thus reducing thermal losses through the surface. </p>

<h5>Modeling</h5>
<p>The numerical settings <strong>settingsData</strong> of the model are collected in records. The level of discretization (number of volume elements) are defined by the model's geometry and the parameters <strong>nAdditionalElementsR, dZminDesired, nBHEelementsZdesired, growthFactor and relativeModelDepth</strong>. The term \"desired\" indicates that the parameter is not fixed and will be ignored if another parameter value results in a finer level of discretization.</p>
<p>If the parameter <strong>useAverageSurfaceTemperature</strong> is set to false, the temperature at the ground surface has to be given to the model by a real input via <strong>Tambient</strong> of the conditional <strong>weatherPort</strong>.</p> 
<h5>Control</h5>
<p>The model contains a pump and the flow rate has to be defined via the busPort. To allow for more than one component of the same type the <strong>numberOfComponents</strong> has to be defined and each of those components has to be given a unique <strong>componentID</strong> in the range of the former parameter.</p>

<h4>Implementation</h4>
<p>The model was compared against a common software for the design of borehole heat exchanger sytsems EED (Earth Energy Designer <a href=\"modelica://MoBTES.UsersGuide.References\">[EED2020]</a>) with typical load and design data as given by the German VDI 4640 standard (VDI 4640 - Part 2 - 2019).  <a href=\"modelica://MoBTES.UsersGuide.References\">[VDI2019]</a></p>
</html>"),
  experiment(
   StopTime=1,
   StartTime=0,
   Interval=0.002));
end SingleBHE;
