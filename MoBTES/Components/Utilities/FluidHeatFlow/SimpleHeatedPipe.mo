// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow;
model SimpleHeatedPipe "Pipe with heat exchange without pressure calculation"
	extends MoBTES.Components.Utilities.FluidHeatFlow.BaseClasses.SimpleTwoPort;
	Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(Placement(
		transformation(extent={{-10,-110},{10,-90}}),
		iconTransformation(extent={{-10,-110},{10,-90}})));
	equation
		// energy exchange with medium
		Q_flow = heatPort.Q_flow;
		// defines heatPort's temperature
		heatPort.T = T_q;
	annotation(
		Icon(graphics={
			Rectangle(
				lineColor={255,0,0},
				fillColor={0,0,255},
				fillPattern=FillPattern.Solid,
				extent={{-90,20},{90,-20}}),
			Text(
				textString="%name",
				extent={{-150,100},{150,40}}),
			Polygon(
				points={{-10,-90},{-10,-40},{0,-20},{10,-40},{10,-90},{-10,
				-90}},
				lineColor={255,0,0})}),
		Documentation(info="<html>
<p>Adapted version of <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.Pipe\">Modelica.Thermal.HeatTransfer.Components.Pipe</a> that has no pressure drop.</p>

</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end SimpleHeatedPipe;
