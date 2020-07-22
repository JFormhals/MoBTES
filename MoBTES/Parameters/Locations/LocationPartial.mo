// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Parameters.Locations;
partial record LocationPartial
	extends Modelica.Icons.Record;
	parameter Modelica.SIunits.Temperature Taverage(displayUnit="°C") "average ambience temperature";
	parameter Real geoGradient "geothermal gradient (K/m)";
	parameter Integer layers(
		min=1,
		max=5,
		fixed=true) "number of ground layers";
	replaceable parameter Soils.Soil strat1 constrainedby Parameters.Soils.SoilPartial "thermo physical properties layer 1";
	replaceable parameter Soils.Soil strat2 constrainedby Parameters.Soils.SoilPartial "thermo physical properties layer 2";
	replaceable parameter Soils.Soil strat3 constrainedby Parameters.Soils.SoilPartial "thermo physical properties layer 3";
	replaceable parameter Soils.Soil strat4 constrainedby Parameters.Soils.SoilPartial "thermo physical properties layer 4";
	replaceable parameter Soils.Soil strat5 constrainedby Parameters.Soils.SoilPartial "thermo physical properties layer 5";
	parameter Modelica.SIunits.Length layerThicknessVector[5](each min=1)={1000,1,1,1,1} "Thickness of all ground layers.";
	final parameter Real cpVector[5]={strat1.cp,strat2.cp,strat3.cp,strat4.cp,strat5.cp};
	final parameter Real rhoVector[5]={strat1.rho,strat2.rho,strat3.rho,strat4.rho,strat5.rho};
	final parameter Real lamdaVector[5]={strat1.lamda,strat2.lamda,strat3.lamda,strat4.lamda,strat5.lamda};
end LocationPartial;
