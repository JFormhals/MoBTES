// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Components.Utilities.FluidHeatFlow;
model Pipe_flowMulti "Pipe with mass multiplication"
	extends BaseClasses.TwoPort_flowMulti;
	extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SimpleFriction;
	parameter Boolean useHeatPort=false "=true, if HeatPort is enabled" annotation(
		choices(checkBox=true),
		Evaluate=true,
		HideResult=true);
	parameter Modelica.SIunits.Length h_g(start=0) "Geodetic height (height difference from flowPort_a to flowPort_b)";
	parameter Modelica.SIunits.Acceleration g(final min=0)=Modelica.Constants.g_n "Gravitation";
	Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort(
		T=T_q,
		Q_flow=Q_flowHeatPort)if useHeatPort annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
	protected
		Modelica.SIunits.HeatFlowRate Q_flowHeatPort "Heat flow at conditional heatPort";
	equation
		if not useHeatPort then
		  Q_flowHeatPort=0;
		end if;
		// coupling with FrictionModel
		volumeFlow = V_flow;
		dp = pressureDrop + medium.rho*g*h_g;
		// energy exchange with medium
		Q_flow = Q_flowHeatPort + Q_friction;
	annotation(
		Icon(graphics={
			Rectangle(
				lineColor={255,0,0},
				fillColor={0,0,255},
				fillPattern=FillPattern.Solid,
				extent={{-90,20},{90,-20}}),
			Polygon(
				points={{-10,-90},{-10,-40},{0,-20},{10,-40},{10,-90},{-10,
				-90}},
				lineColor={255,0,0},
				visible=useHeatPort),
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-150,80},{150,40}})}),
		Documentation(info="<html>
<p>Adapted version of <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.Pipe\">Modelica.Thermal.HeatTransfer.Components.Pipe</a> with mass flow imbalance. Mass flow at port a is larger by a factor n than mass flow at port b.</p>

</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end Pipe_flowMulti;
