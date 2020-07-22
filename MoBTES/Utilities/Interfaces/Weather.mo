// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Utilities.Interfaces;
expandable connector Weather "Weather data connector"
	Modelica.SIunits.Temperature Tambient "Ambient temperature";
	Modelica.SIunits.Irradiance beamIrradiation[3] "Beam irradiance vector {E,N,U}";
	Modelica.SIunits.Irradiance diffuseIrradiation "Diffuse irradiance";
	Modelica.SIunits.Irradiance totalIrradiation "Diffuse irradiance";
	Modelica.SIunits.Angle zenitAngle "Zenit angle of the sun";
	Modelica.SIunits.Angle hourAngle "Hour angle of the sun";
	Integer monthOfTheYear(
		start=1,
		fixed=true) "Counter for the current month of the calendar year";
	Integer dayOfTheYear(
		start=1,
		fixed=true) "Counter for the current day of the calendar year";
	Integer monthOfSimulation(
		start=1,
		fixed=true) "Counter for the current month of the simulation";
	Integer yearOfSimulation(
		start=1,
		fixed=true) "Counter for the current month of the simulation";
	annotation(
		Icon(graphics={
		Ellipse(
			lineColor={0,176,80},
			fillColor={0,176,80},
			fillPattern=FillPattern.Solid,
			extent={{-98,98},{98,-98}})}),
		Diagram(graphics={
			Ellipse(
				lineColor={0,176,80},
				fillColor={0,176,80},
				fillPattern=FillPattern.Solid,
				extent={{-48,48},{48,-48}}),
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-100,110},{100,50}})}));
end Weather;
