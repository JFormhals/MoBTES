// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Utilities.Interfaces;
connector WarmPort "Port used for warm fluid"
	extends Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort;
	annotation(
		Icon(graphics={
		Ellipse(
			lineColor={177,0,177},
			fillColor={177,0,177},
			fillPattern=FillPattern.Solid,
			extent={{-98,98},{98,-98}})}),
		Diagram(graphics={
			Ellipse(
				lineColor={177,0,177},
				fillColor={177,0,177},
				fillPattern=FillPattern.Solid,
				extent={{-48,48},{48,-48}}),
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-100,110},{100,50}})}),
		Documentation(info="<html>
Same as FlowPort, but icon allows to differentiate direction of flow.
</html>"));
end WarmPort;
