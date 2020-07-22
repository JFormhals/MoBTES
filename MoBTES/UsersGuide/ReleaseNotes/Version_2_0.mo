// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.UsersGuide.ReleaseNotes;
class Version_2_0 "Version 2.0"
	extends Modelica.Icons.ReleaseNotes;
	annotation(
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
Major additions, restructuring and fixed compatibility issues.
</p>

<ul>
 <li>Fixed compatibility issues with Dymola</li> 
 <li>Fixed compatibility issues with OpenModelica</li>
 <li>Rearranged library structure</li>
 <li>A model and example for a single borehole heat exchanger (BHE) was added: <a href=\"modelica://MoBTES.Components.Sources.Geothermal.SingleBHE\">Components.Sources.Geothermal.SingleBHE</a></li>
 <li>A new local model was added which exchanges heat via it's outer boundary in contrast to the approach of using the average volume temperature. The model is better suited for the single BHE model: <a href=\"modelica://MoBTES.Components.Ground.CylinderElement_FiniteDifferences\">Components.Ground.CylinderElement_FiniteDifferences</a> </li>
 <li>A model which reads weather data from files was added (experimental): <a href=\"modelica://MoBTES.Components.Weather.WeatherData\">Components.Weather.WeatherData</a></li>
 <li>A model for BHE heads was added to collect all necessary utility components for pressure loss calculations, advective resistances and volume flow adjustments. This simplifies the interconnection of the BHEs and allows for a clean structure view of the MoBTES model: <a href=\"modelica://MoBTES.Components.Sources.Geothermal.BaseClasses.BHEhead\">Components.Sources.Geothermal.BaseClasses.BHEhead</a></li>
 <li>Additional interfaces which inherit from Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort were added.</li>
 <li>A weather interface was defined.</li>
 <li>A new interface for bus systems was added.</li>
 <li>The BTES and single BHE model now include pumps that can be controlled via the bus ports.</li>
 <li>New parameter records were added.</li>
 <li>New component icons</li>
 </ul>
 
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Test environment</th><th>Version</th><th>Remarks</th></tr>
<tr><td>SimulationX</td><td>4.1.2</td><td>-</td></tr>
<tr><td>Dymola</td><td>2020x</td><td>-</td></tr>
<tr><td>OpenModelica</td><td>1.15.0</td><td width=\"500\">
<ul>
<li>The version of OpenModelica available at the time of the test did not support replaceable parameters.</li>
<li> The new front-end of OMEdit has issues with arrays of records. The old front-end, which is still included in OMEdit can be used instead.</li>
</ul>
</td></tr>
</table>
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001),
		preferredView="info");
end Version_2_0;
