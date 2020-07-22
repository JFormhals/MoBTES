// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities;
package HeatTransfer "HeatTransfer utility components"
	extends Modelica.Icons.Package;
	package Partials "Patial models"
		extends Modelica.Icons.BasesPackage;
		partial model Element1D_amplified "Partial heat transfer element with two HeatPort connectors that does not store energy, where the heat flow at port B is amplified by a factor n"
			Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from port_a -> port_b";
			Modelica.SIunits.TemperatureDifference dT "port_a.T - port_b.T";
			Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(Placement(
				transformation(extent={{-110,-10},{-90,10}}),
				iconTransformation(extent={{-110,-10},{-90,10}})));
			Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation(Placement(
				transformation(extent={{90,-10},{110,10}}),
				iconTransformation(extent={{90,-10},{110,10}})));
			protected
				parameter Integer amplification=1;
			equation
				dT = port_a.T - port_b.T;
				port_a.Q_flow = Q_flow;
				port_b.Q_flow = -Q_flow*amplification;
			annotation(Documentation(info="<html>
<p>
This partial model contains the basic connectors and variables to
allow heat transfer models to be created that <b>do not store energy</b>,
This model defines and includes equations for the temperature
drop across the element, <b>dT</b>, and the heat flow rate
through the element from port_a to port_b, <b>Q_flow</b>.
</p>
<p>
By extending this model, it is possible to write simple
constitutive equations for many types of heat transfer components.
</p>
</html>"));
		end Element1D_amplified;
		annotation(dateModified="2020-05-24 10:58:25Z");
	end Partials;
	annotation(
		dateModified="2020-07-15 10:05:35Z",
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
Utility components for conductive heat transport.
</p>
</html>"),
		Icon(graphics={
			Polygon(
				points={{-54,-6},{-61,-7},{-75,-15},{-79,-24},{-80,-34},{-78,
				-42},{-73,-49},{-64,-51},{-57,-51},{-47,-50},{-41,-43},{-38,
				-35},{-40,-27},{-40,-20},{-42,-13},{-47,-7},{-54,-5},{-54,
				-6}},
				lineColor={128,128,128},
				fillColor={192,192,192},
				fillPattern=FillPattern.Solid,
				origin={13.758,27.517}),
			Polygon(
				points={{-75,-15},{-79,-25},{-80,-34},{-78,-42},{-72,-49},{-64,
				-51},{-57,-51},{-47,-50},{-57,-47},{-65,-45},{-71,-40},{-74,
				-33},{-76,-23},{-75,-15},{-75,-15}},
				fillColor={160,160,164},
				fillPattern=FillPattern.Solid,
				origin={13.758,27.517}),
			Polygon(
				points={{39,-6},{32,-7},{18,-15},{14,-24},{13,-34},{15,
				-42},{20,-49},{29,-51},{36,-51},{46,-50},{52,-43},{55,
				-35},{53,-27},{53,-20},{51,-13},{46,-7},{39,-5},{39,
				-6}},
				lineColor={160,160,164},
				fillColor={192,192,192},
				fillPattern=FillPattern.Solid,
				origin={13.758,27.517}),
			Polygon(
				points={{18,-15},{14,-25},{13,-34},{15,-42},{21,-49},{29,
				-51},{36,-51},{46,-50},{36,-47},{28,-45},{22,-40},{19,
				-33},{17,-23},{18,-15},{18,-15}},
				fillColor={160,160,164},
				fillPattern=FillPattern.Solid,
				origin={13.758,27.517}),
			Polygon(
				points={{-9,-23},{-9,-10},{18,-17},{-9,-23}},
				lineColor={191,0,0},
				fillColor={191,0,0},
				fillPattern=FillPattern.Solid,
				origin={13.758,27.517}),
			Line(
				points={{-41,-17},{-9,-17}},
				color={191,0,0},
				thickness=0.5,
				origin={13.758,27.517}),
			Line(
				points={{-17,-40},{15,-40}},
				color={191,0,0},
				thickness=0.5,
				origin={13.758,27.517}),
			Polygon(
				points={{-17,-46},{-17,-34},{-40,-40},{-17,-46}},
				lineColor={191,0,0},
				fillColor={191,0,0},
				fillPattern=FillPattern.Solid,
				origin={13.758,27.517})}));
end HeatTransfer;
