// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters;
package Fluids "heat carrier fluid data"
	extends Modelica.Icons.MaterialPropertiesPackage;
	record fluidData "heat carrier fluid"
		extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
			rho=995.6,
			cp=4000,
			cv=4000,
			lamda=0.615,
			nue=0.3E-6);
		annotation(Documentation(info="<html>
Medium: properties of water
</html>"));
	end fluidData;
	annotation(
		dateModified="2020-06-04 17:40:38Z",
		Documentation(info="<html>
<p>
Datasets containg information about the thermophysical parameters of different heat carrier fluids
</p>

</html>"));
end Fluids;
