// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.UsersGuide.ReleaseNotes;
class Version_1_0 "Version 1.0"
	extends Modelica.Icons.ReleaseNotes;
	annotation(
		Documentation(info="<html>
<head>
<style type=\"text/css\">
a {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt;}
body, blockquote, table, p, li, dl, ul, ol {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; color: black;}
h3 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11pt; font-weight: bold;}
h4 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; font-weight: bold;}
h5 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9pt; font-weight: bold;}
h6 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9pt; font-weight: bold; font-style:italic}
pre {font-family: Courier, monospace; font-size: 9pt;}
td {vertical-align:top;}
th {vertical-align:top;}
</style>
</head>

<p>
First official release of the MoBTES library.
</p>
<table border=1 cellspacing=0 cellpadding=2>
<tr><th>Test environment</th><th>Version</th><th>Test</th><th>Remarks</th></tr>
<tr><td>SimulationX</td><td>4.1.1</td><td>successful</td><td>-</td></tr>
<tr><td>Dymola</td><td>2020</td><td>successful</td><td>-</td></tr>
<tr><td>OpenModelica</td><td>1.15.0</td><td>successful</td><td width=\"500\">
<ul>
<li>The version of OpenModelica available at the time of the test did not support replaceable parameters. The parameter records have to be changed manually by either changing the default record in the code or by manipulating the parameter values inside the default records.</li>
<li> The new front-end of OMEdit has issues with arrays of records. The old front-end, which is still included in OMEdit can be used instead.</li>
</ul>
</td></tr>
<tr><td>Wolfram SystemModeler</td><td>12.0.0</td><td>failed</td><td>
<ul>
<li>record construction handled differently: replace \"recordNameA=recordType()\" with \"recordNameA=recordType\". </li>
<li>heap overflow </li>
</ul></td></tr>
</table>
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001),
		preferredView="info");
end Version_1_0;
