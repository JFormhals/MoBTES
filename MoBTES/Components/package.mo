// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES;
package Components "Components"
	extends Modelica.Icons.Package;
	annotation(
		dateModified="2020-07-15 10:07:10Z",
		Icon(graphics={
			Rectangle(
				fillColor={255,255,255},
				extent={{-30,-20.1488},{30,20.1488}},
				origin={0,35.1488}),
			Rectangle(
				fillColor={255,255,255},
				extent={{-30,-20.1488},{30,20.1488}},
				origin={0,-34.8512}),
			Line(
				points={{21.25,-35},{-13.75,-35},{-13.75,35},{6.25,35}},
				origin={-51.25,0}),
			Polygon(
				points={{10,0},{-5,5},{-5,-5}},
				pattern=LinePattern.None,
				fillPattern=FillPattern.Solid,
				origin={-40,35}),
			Line(
				points={{-21.25,35},{13.75,35},{13.75,-35},{-6.25,-35}},
				origin={51.25,0}),
			Polygon(
				points={{-10,0},{5,5},{5,-5}},
				pattern=LinePattern.None,
				fillPattern=FillPattern.Solid,
				origin={40,-35})}),
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
Collection of components for the simulation of thermal energy storage systems.
</p>
</html>"));
end Components;
