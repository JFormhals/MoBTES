// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow;
model BHEhydraulics "Pressure drop  and advective thermal resistances of BHEs"
	Modelica.Blocks.Interfaces.RealInput volFlow(quantity="VolumeFlowRate") "volume flow of fluid" annotation(Placement(
		transformation(extent={{-20,-20},{20,20}}),
		iconTransformation(extent={{-120,-20},{-80,20}})));
	Modelica.Blocks.Interfaces.RealOutput R[3](each quantity="ThermalResistance") "thermal resistance" annotation(Placement(
		transformation(extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{86.7,40},{106.7,60}})));
	Modelica.Blocks.Interfaces.RealOutput dp(
		quantity="Pressure",
		displayUnit="bar") "pressure drop of one BHE (shank)" annotation(Placement(
		transformation(extent={{86.7,-60},{106.7,-40}}),
		iconTransformation(extent={{86.7,-60},{106.7,-40}})));
	replaceable parameter Parameters.BoreholeHeatExchangers.DoubleU_DN32 BHEdata constrainedby MoBTES.Parameters.BoreholeHeatExchangers.BHEparameters;
	replaceable parameter Modelica.Thermal.FluidHeatFlow.Media.Water BHEmedium constrainedby Modelica.Thermal.FluidHeatFlow.Media.Medium;
	parameter Real BHElength "characteristic Length";
	protected
		parameter Real my=BHEmedium.rho*BHEmedium.nue;
		parameter Real Pr=MoBTES.Components.Utilities.FluidHeatFlow.Functions.Prandtl(my,BHEmedium.cp,BHEmedium.lamda) "Prandtl number";
		parameter Real dPipe1inner(
			quantity="Length",
			displayUnit="m")=BHEdata.dPipe1-2*BHEdata.tPipe1 "characteristic Length";
		parameter Real dPipe2inner(
			quantity="Length",
			displayUnit="m")=BHEdata.dPipe2-2*BHEdata.tPipe2 "characteristic Length";
		parameter Real dRef(
			quantity="Length",
			displayUnit="m")=dPipe2inner-BHEdata.dPipe1 "characteristic Length";
		Real Re[2] "Reynolds number";
		Real vFluid[2] "fluid velocity in pipe";
		Real Xi[2] "auxillary variable";
		Real gamma[2] "auxillary varibale";
		Real Nu[2] "Nusselt number";
	equation
		vFluid[1]=	MoBTES.Components.Utilities.FluidHeatFlow.Functions.vFluid(max(abs(volFlow),Modelica.Constants.small),0,dPipe1inner);
		vFluid[2]=	if BHEdata.nShanks==0 then MoBTES.Components.Utilities.FluidHeatFlow.Functions.vFluid(max(abs(volFlow),Modelica.Constants.small),BHEdata.dPipe1,dPipe2inner) else 0;
		Re[1]=		MoBTES.Components.Utilities.FluidHeatFlow.Functions.Reynolds(vFluid[1],dPipe1inner,BHEmedium.nue);
		Re[2]=		if BHEdata.nShanks==0 then MoBTES.Components.Utilities.FluidHeatFlow.Functions.Reynolds(vFluid[2],dRef,BHEmedium.nue) else 1;
		Xi[1]=		MoBTES.Components.Utilities.FluidHeatFlow.Functions.Xi(Re[1]);
		Xi[2]=		if BHEdata.nShanks==0 then MoBTES.Components.Utilities.FluidHeatFlow.Functions.Xi(Re[2]) else 1;
		gamma[1]=	MoBTES.Components.Utilities.FluidHeatFlow.Functions.Gamma(Re[1]);
		gamma[2]=	if BHEdata.nShanks==0 then MoBTES.Components.Utilities.FluidHeatFlow.Functions.Gamma(Re[2]) else 1;
		Nu[1]=MoBTES.Components.Utilities.FluidHeatFlow.Functions.Nusselt_pipe(dPipe1inner,gamma[1],BHElength,Pr,Re[1],Xi[1]);
		Nu[2]=if BHEdata.nShanks==0 then MoBTES.Components.Utilities.FluidHeatFlow.Functions.Nusselt_annularGap(BHEdata.dPipe1,dPipe2inner,gamma[2],BHElength,Pr,Re[2],Xi[2]) else 1;
		
		R[1]=1/(Nu[1]*BHEmedium.lamda*Modelica.Constants.pi);
		R[2]=if BHEdata.nShanks==0 then 1/(Nu[2]*BHEmedium.lamda*Modelica.Constants.pi)*dRef/BHEdata.dPipe1 else 1;
		R[3]=if BHEdata.nShanks==0 then 1/(Nu[2]*BHEmedium.lamda*Modelica.Constants.pi)*dRef/dPipe2inner else 1;
		dp=sign(volFlow)*(if BHEdata.nShanks==0 then (MoBTES.Components.Utilities.FluidHeatFlow.Functions.Zeta_pipe(Re[1])*BHElength/dPipe1inner*(BHEmedium.rho*vFluid[1]^2)/2+MoBTES.Components.Utilities.FluidHeatFlow.Functions.Zeta_annularGap(Re[2])*BHElength/dRef*(BHEmedium.rho*vFluid[2]^2)/2) else MoBTES.Components.Utilities.FluidHeatFlow.Functions.Zeta_pipe(Re[1])*BHElength/dPipe1inner*(BHEmedium.rho*vFluid[1]^2)/2);
	annotation(
		Icon(graphics={
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-153.3,138.2},{146.7,98.2}}),
			Text(
				textString="G=%G",
				extent={{-150,-75},{150,-105}}),
			Ellipse(
				fillColor={0,192,255},
				fillPattern=FillPattern.Solid,
				lineThickness=4.5,
				extent={{79.7,74.09999999999999},{-70,-66.90000000000001}}),
			Line(
				points={{0,73.3},{0,3.3},{30,3.3},{33.3,3.3}},
				thickness=1),
			Line(
				points={{0,73.3},{30,60},{33.3,3.3},{30,3.3}},
				smooth=Smooth.Bezier,
				thickness=1.5),
			Line(
				points={{0,60},{23.3,60}},
				arrow={
					Arrow.None,Arrow.Filled},
				thickness=1.5),
			Line(
				points={{0.2,46.6},{26.7,46.7}},
				arrow={
					Arrow.None,Arrow.Filled},
				thickness=1.5),
			Line(
				points={{0,33.3},{33.3,33.3}},
				arrow={
					Arrow.None,Arrow.Filled},
				thickness=1.5),
			Line(
				points={{0,16.7},{33.3,16.7}},
				arrow={
					Arrow.None,Arrow.Filled},
				thickness=1.5),
			Text(
				textString="dp & alpha",
				textStyle={
					TextStyle.Bold},
				extent={{-69.90000000000001,6.6},{80.09999999999999,-30.1}})}),
		Documentation(info="<html>
<p>Component for the calculation of the pressure drop and the advective resistances in borehole heat exchangers.</p>

</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end BHEhydraulics;
