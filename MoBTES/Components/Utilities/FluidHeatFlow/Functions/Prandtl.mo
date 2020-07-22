// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow.Functions;
function Prandtl "Prandtl number"
	extends Modelica.Icons.Function;
	input Real dynamicViscosity(quantity="DynamicViscosity") "dynamic viscosity of fluid";
	input Real cRefrigerant(quantity="SpecificHeatCapacity") "heat capacity of refrigerant";
	input Real lambdaRefrigerant(quantity="ThermalConductivity") "thermal conductivity of refrigerant";
	output Real Pr "Prandtl Number";
	algorithm
		// enter your algorithm here
		Pr:= dynamicViscosity*cRefrigerant/lambdaRefrigerant;
	annotation(Documentation(info="<html>



<p> Function for caluclation of the Prandtl number after <a href=\"modelica://MoBTES.UsersGuide.References\">[VDI2013]</a></p>


</html>"));
end Prandtl;
