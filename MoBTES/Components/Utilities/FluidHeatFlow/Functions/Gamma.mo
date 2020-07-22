// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow.Functions;
function Gamma "auxillary variable gamma"
	extends Modelica.Icons.Function;
	input Real Re "Reynolds number";
	output Real Gamma "auxillary variable gamma";
	algorithm
		// enter your algorithm here
		Gamma:=(Re-2300)/(10^4-2300);
	annotation(Documentation(info="<html>



<p> Function for caluclation of auxillary variable gamma for pipes after <a href=\"modelica://MoBTES.UsersGuide.References\">[VDI2013]</a></p>


</html>"));
end Gamma;
