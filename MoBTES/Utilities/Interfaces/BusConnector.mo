// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Utilities.Interfaces;
expandable connector BusConnector "Bus for system control"
	parameter Integer nBTES=1 "Number of Borehole Thermal Energy Storages";
	Modelica.SIunits.VolumeFlowRate BTES_volFlow[nBTES] "Control signal for volume flow rates of BTES pumps";
	annotation(
		Icon(graphics={
		Ellipse(
			lineColor={192,192,192},
			fillColor={255,215,0},
			fillPattern=FillPattern.Solid,
			extent={{-98,98},{98,-98}})}),
		Diagram(graphics={
			Ellipse(
				pattern=LinePattern.Dash,
				lineColor={192,192,192},
				fillColor={255,215,0},
				fillPattern=FillPattern.Solid,
				extent={{-48,48},{48,-48}}),
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-100,110},{100,50}})}));
end BusConnector;
