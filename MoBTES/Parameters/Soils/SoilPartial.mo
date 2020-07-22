// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Soils;
partial record SoilPartial "soil properties"
	extends Modelica.Icons.Record;
	parameter Modelica.SIunits.Density rho(min=1) "Density";
	parameter Modelica.SIunits.SpecificHeatCapacity cp(min=1) "Specific heat capacity at constant pressure";
	parameter Modelica.SIunits.ThermalConductivity lamda(min=0.01) "Thermal conductivity";
	annotation(Documentation(info="<html>
Record containing (constant) soil properties.
</html>"));
end SoilPartial;
