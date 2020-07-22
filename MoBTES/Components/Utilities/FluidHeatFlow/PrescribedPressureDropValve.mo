// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow;
model PrescribedPressureDropValve "Valve with prescribed pressure drop"
	extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(
		m=0,
		T0=293.15,
		final tapT=1);
	Modelica.Blocks.Interfaces.RealInput y annotation(Placement(
		transformation(
			origin={0,100},
			extent={{-20,-20},{20,20}},
			rotation=270),
		iconTransformation(
			origin={0,100},
			extent={{-20,-20},{20,20}},
			rotation=270)));
	equation
		dp = if abs(V_flow)>0 then  y else 0;
		// no energy exchange with medium
		Q_flow = 0;
	annotation(
		Icon(graphics={
			Polygon(
				points={{-90,10},{-60,10},{-60,60},{0,0},{60,60},{60,
				10},{90,10},{90,-10},{60,-10},{60,-60},{0,0},{-60,
				-60},{-60,-10},{-90,-10},{-90,10}},
				lineColor={255,0,0},
				fillColor={0,0,255},
				fillPattern=FillPattern.Solid),
			Line(
				points={{0,80},{0,0}},
				color={0,0,127}),
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-150,-70},{150,-110}})}),
		Documentation(info="<html>
<p>This component can be used to emulate a defined pressure drop.</p>
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end PrescribedPressureDropValve;
