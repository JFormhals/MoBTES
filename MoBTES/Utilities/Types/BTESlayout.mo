// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Utilities.Types;
type BTESlayout = enumeration( 
	rectangle "Rectangle layout", 
	circle "Circle layout", 
	hexagon "Hexagon layout") "Layout of the BTES" annotation(Documentation(info="<html>

<p>
Possible options for the layout of the BTES:
</p>
<ul>
<li>Rectangular</li>
<li>Circular</li>
<li>Hexagonal</li>
</ul>
</html>"));
