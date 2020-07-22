// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow.Functions;
function Zeta_annularGap "pressure loss coefficient (VDI Wärmeatlas)"
	extends Modelica.Icons.Function;
	input Real Re "Reynolds number";
	output Real Zeta "Pressure loss coefficient";
	algorithm
		if Re<2300 then
			Zeta:=1.5*64/Re;
		else
			Zeta:=0.3164/(Re^(1/4));
		end if;
	annotation(Documentation(info="<html>



<p> Function for caluclation of the pressure loss coefficient Zeta for the annular gap of a coaxial pipe after <a href=\"modelica://MoBTES.UsersGuide.References\">[VDI2013]</a></p>


</html>"));
end Zeta_annularGap;
