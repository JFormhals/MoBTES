// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.HeatTransfer;
model ThermalResistor_amplified "Lumped thermal element transporting heat without storing it, where the heat flow at port B is amplified by a factor n"
	extends MoBTES.Components.Utilities.HeatTransfer.Partials.Element1D_amplified(amplification=amplification_factor);
	parameter Modelica.SIunits.ThermalResistance R "Constant thermal resistance of material";
	parameter Integer amplification_factor=1 "factor by which the flow at port b is amplified";
	equation
		dT = R*Q_flow;
	annotation(
		Icon(graphics={
			Rectangle(
				pattern=LinePattern.None,
				fillColor={192,192,192},
				fillPattern=FillPattern.Forward,
				extent={{-90,70},{90,-70}}),
			Line(
				points={{-90,70},{-90,-70}},
				thickness=0.5),
			Line(
				points={{90,70},{90,-70}},
				thickness=0.5),
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-150,115},{150,75}}),
			Text(
				textString="R=%R",
				extent={{-150,-75},{150,-105}}),
			Text(
				textString="xN",
				textStyle={
					TextStyle.Bold},
				extent={{-63.3,40},{60,-46.7}})}),
		Diagram(graphics={
			Line(
				points={{-80,0},{80,0}},
				color={255,0,0},
				arrow={
					Arrow.None,Arrow.Filled},
				thickness=0.5),
			Text(
				textString="Q_flow",
				lineColor={255,0,0},
				extent={{-100,-20},{100,-40}}),
			Text(
				textString="dT = port_a.T - port_b.T",
				extent={{-100,40},{100,20}})}),
		Documentation(info="<html>
<p>
This is a model for transport of heat without storing it, same as the
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">ThermalConductor</a>
but using the thermal resistance instead of the thermal conductance as a parameter.
This is advantageous for series connections of ThermalResistors,
especially if it shall be allowed that a ThermalResistance is defined to be zero (i.e. no temperature difference).
</p>
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end ThermalResistor_amplified;
