// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow.Functions;
function vFluid "fluid velocity"
	extends Modelica.Icons.Function;
	input Real volFlow(quantity="VolumeFlowRate") "volume flow";
	input Real dInner(quantity="Length") "inner diameter";
	input Real dOuter(quantity="Length") "outer diameter";
	output Real velocity(quantity="Velocity") "volume flow velocity";
	algorithm
		// enter your algorithm here
		velocity:=volFlow/(Modelica.Constants.pi*(dOuter^2-dInner^2)/4);
	annotation(Documentation(info="<html>



<p> Function for caluclation of fluid velocity inside a pipe or an annular gap</p>


</html>"));
end vFluid;
