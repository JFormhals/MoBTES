// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Utilities;
package Interfaces "Interfaces"
	extends Modelica.Icons.InterfacesPackage;
	package componentBusPorts "Bus connectors for the components"
		extends Modelica.Icons.Package;
		expandable connector BTESbus "Borehole thermal energy storage bus"
			parameter Integer nBTES=1 "Number of Borehole Thermal Energy Storages";
			input Modelica.SIunits.VolumeFlowRate BTES_volFlow[nBTES] "Control signal for volume flow rates of BTES pumps";
			annotation(
				Icon(graphics={
				Ellipse(
					pattern=LinePattern.Dash,
					lineColor={192,192,192},
					fillColor={255,215,0},
					fillPattern=FillPattern.Solid,
					lineThickness=1,
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
		end BTESbus;
		expandable connector BHEbus "Borehole heat exchanger bus"
			parameter Integer nBHEs=1 "Number of Borehole Heat Exchangers";
			input Modelica.SIunits.VolumeFlowRate BHE_volFlow[nBHEs] "Control signal for volume flow rates of BHE pumps";
			annotation(
				Icon(graphics={
				Ellipse(
					pattern=LinePattern.Dash,
					lineColor={192,192,192},
					fillColor={255,215,0},
					fillPattern=FillPattern.Solid,
					lineThickness=1,
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
		end BHEbus;
		annotation(dateModified="2020-05-19 20:00:15Z");
	end componentBusPorts;
	annotation(dateModified="2020-05-04 07:04:48Z");
end Interfaces;
