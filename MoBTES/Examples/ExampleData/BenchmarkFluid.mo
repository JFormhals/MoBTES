// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Examples.ExampleData;
record BenchmarkFluid "3D FEM benchmark study fluid"
	extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
		rho=995.6,
		cp=4000,
		cv=4000,
		lamda=0.615,
		nue=0.3E-6);
	annotation(Documentation(info="<html>
Medium: properties of water
</html>"));
end BenchmarkFluid;
