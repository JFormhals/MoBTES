// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow.BaseClasses;
partial model SimpleTwoPort "Partial model of two port without pressure calculations"
	parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium() "Medium in the component" annotation(choicesAllMatching=true);
	parameter Modelica.SIunits.Mass m(start=1) "Mass of medium";
	parameter Real tapT(
		final min=0,
		final max=1)=1 "Defines temperature of heatPort between inlet and outlet temperature";
	Modelica.SIunits.VolumeFlowRate V_flow "Volume flow a->b";
	Modelica.SIunits.HeatFlowRate Q_flow "Heat exchange with ambient";
	output Modelica.SIunits.Temperature T "Outlet temperature of medium";
	output Modelica.SIunits.Temperature T_a "Temperature at flowPort_a";
	output Modelica.SIunits.Temperature T_b "Temperature at flowPort_b";
	output Modelica.SIunits.TemperatureDifference dT "Temperature increase of coolant in flow direction";
	protected
		Modelica.SIunits.SpecificEnthalpy h "Medium's specific enthalpy";
		Modelica.SIunits.Temperature T_q "Temperature relevant for heat exchange with ambient";
	public
		Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium=medium) annotation(Placement(
			transformation(extent={{-110,-10},{-90,10}}),
			iconTransformation(extent={{-110,-10},{-90,10}})));
		Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium=medium) annotation(Placement(
			transformation(extent={{90,-10},{110,10}}),
			iconTransformation(extent={{90,-10},{110,10}})));
	equation
		flowPort_a.p=flowPort_b.p;
		V_flow=flowPort_a.m_flow/medium.rho;
		T_a=flowPort_a.h/medium.cp;
		T_b=flowPort_b.h/medium.cp;
		dT=if noEvent(V_flow>=0) then T-T_a else T_b-T;
		h = medium.cp*T;
		T_q = T  - noEvent(sign(V_flow))*(1 - tapT)*dT;
		// mass balance
		flowPort_a.m_flow + flowPort_b.m_flow = 0;
		// energy balance
		if m>Modelica.Constants.small then
		  flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = m*medium.cv*der(T);
		else
		  flowPort_a.H_flow + flowPort_b.H_flow + Q_flow = 0;
		end if;
		// mass flow a->b mixing rule at a, energy flow at b defined by medium's temperature
		// mass flow b->a mixing rule at b, energy flow at a defined by medium's temperature
		flowPort_a.H_flow = semiLinear(flowPort_a.m_flow,flowPort_a.h,h);
		flowPort_b.H_flow = semiLinear(flowPort_b.m_flow,flowPort_b.h,h);
	annotation(Documentation(info="<html>
<p>Adapted version of <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort\">Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort</a> that has no pressure drop.</p>

</html>"));
end SimpleTwoPort;
