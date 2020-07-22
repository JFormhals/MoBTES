// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.UsersGuide;
class References "References"
	extends Modelica.Icons.References;
	annotation(
		Documentation(info="<html>
<h4>References</h4>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    
    <tr>
      <td><a href=\"https://elib.uni-stuttgart.de/handle/11682/1996\">[Bauer2012]</a></td>
      <td>D. Bauer
        &quot;Zur thermischen Modellierung von Erdwärmesonden und Erdsonden-Wärmespeichern,&quot;
        <em>Dissertation</em>,
        Stuttgart, Germany, 2012.</td>
    </tr>
    <tr>
      <td><a href=\"https://buildingphysics.com/eed-2/\">[EED2000]</a></td>
      <td>G. Hellström and B. Sanner 
        &quot;Earth Energy Designer,&quot;
        <em>Software</em>,
        v 2.0, Blocon, Lund, Sweden, 2000.</td>
    </tr>
    <tr>
      <td><a href=\"https://doi.org/10.3390/en13092327\">[Formhals2020]</a></td>
      <td>J. Formhals, H. Hemmatabady, B. Welsch, D.O. Schulte and I. Sass 
        &quot;A Modelica Toolbox for the Simulation of Borehole Thermal Energy Storage Systems ,&quot;
        <em>Article</em>, 
        Energies 2020, 13, 2327, 2020.</td>
    </tr>
    <tr>
      <td>[Franke1998]</td>
      <td>R.Franke
        &quot;Integrierte dynamische Modellierung und Optimierung von Systemen mit saisonaler Wärmespeicherung,&quot;
        <em>Book series</em>,
        in Fortschrittberichte VDI : Reihe 6, Energietechnik Nr. 394, VDI-Verlag,Düsseldorf, Germany, 1998</td>
    </tr>
    <tr>
      <td><a href=\"https://doi.org/10.1016/j.renene.2016.12.011\">[Tordrup2017]</a></td>
      <td>K.W. Tordrup, S.E. Poulsen, and H.Bjørn
        &quot;An improved method for upscaling borehole thermal energy storage using inverse finite element modelling,&quot;
        <em>Renewable Energy</em>,
        vol. 105, pp. 13-21, 2017.</td>
    </tr>
     <tr>
      <td><a href=\"https://www.trnsys.com\">[TRNSYS2017]</a></td>
      <td>Solar Energy laboratory
        &quot;TRNSYS - A Transient System Simulation Program,&quot;
        <em>Software</em>,
        University of Wisconsin-Madison, Solar Energy Laboratory: Madison, WI, USA, 2017.</td>
    </tr>
    <tr>
      <td><a href=\"https://planenergi.dk/wp-content/uploads/2018/05/15-10496-Slutrapport-Boreholes-in-Br%C3%A6dstrup.pdf\">[Sørensen2013]</a></td>
      <td>P.A. Sørensen, J. Larsen, L. Thøgersen, J. Dannemand Andersen, C. Østergaard, T. Schmidt,
        &quot;Boreholes in Brædstrup&quot;,
      PlanEnergi,Brædstrup Totalenergianlæg, Via University College, GEO, Per Aarsleff and Solites prepared for ForskEL (2010-1-10498) and EUDP (64012-0007-1) Final Report, June 2013</td>
    </tr>
    <tr>
      <td><a href=\"https://doi.org/10.1007/978-3-642-19981-3\">[VDI2013]</a></td>
      <td>VDI  
        &quot;VDI-Wärmeatlas: Wärmeübertragung bei der Strömung durch Rohre (heat transfer in flowt hrough pipes).&quot;,
        <em>VDI-Gesellschaft EVerfahrenstechnik und Chemieingenieurwesen</em>,
         2013.</td>
    </tr>
    <tr>
      <td><a href=\"https://www.vdi.de/richtlinien/details/vdi-4640-blatt-2-thermische-nutzung-des-untergrunds-erdgekoppelte-waermepumpenanlagen\">[VDI4640]</a></td>
      <td>VDI  
        &quot;VDI 4640 Part 2, Thermal use of the underground - Ground source heat pump systems&quot;,
        <em>VDI-Gesellschaft Energie und Umwelt</em>,
         2019.</td>
    </tr>
</table>

</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end References;
