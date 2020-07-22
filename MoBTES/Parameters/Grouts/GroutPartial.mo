// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Grouts;
partial record GroutPartial "grout"
	extends Modelica.Icons.Record;
	parameter Real lamda(quantity="ThermalConductivity") "thermal conductivity of grout" annotation(Dialog(
		group="grout",
		tab="BTES"));
	parameter Real cp(
		quantity="SpecificHeatCapacity",
		displayUnit="kJ/(kg·K)") "thermal capacity of grout" annotation(Dialog(
		group="grout",
		tab="BTES"));
	parameter Real rho(quantity="Density") "density of grout" annotation(Dialog(
		group="grout",
		tab="BTES"));
end GroutPartial;
