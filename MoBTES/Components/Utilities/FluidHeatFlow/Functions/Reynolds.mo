// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow.Functions;
function Reynolds "Reynolds number"
	extends Modelica.Icons.Function;
	input Real velocity(quantity="Velocity") "volume flow velocity";
	input Real diameter(quantity="Length") "diameter of pipe or annular gap";
	input Real nue(quantity="KinematicViscosity") "dynamic viscosity of refrigerant";
	output Real Re "Reynolds number";
	algorithm
		// enter your algorithm here
		Re:= velocity*diameter/nue;
	annotation(Documentation(info="<html>



<p> Function for caluclation of the Reynolds  number for pipes after <a href=\"modelica://MoBTES.UsersGuide.References\">[VDI2013]</a></p>


</html>"));
end Reynolds;
