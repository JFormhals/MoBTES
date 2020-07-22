// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow.Functions;
function Xi "auxillary variable"
	extends Modelica.Icons.Function;
	input Real Re "Reynolds number";
	output Real Xi "auxillary variable Xi";
	algorithm
		// enter your algorithm here
		Xi:=(1.8*log10(Re)-1.5)^(-2);
	annotation(Documentation(info="<html>



<p> Function for caluclation of auxillary variable Xi for pipes after <a href=\"modelica://MoBTES.UsersGuide.References\">[VDI2013]</a></p>


</html>"));
end Xi;
