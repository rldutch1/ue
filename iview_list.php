<?php
//include('../includes/pw5new.php');
include('mysqli_test1.php');
include('../../includes/functions.php');

echo "<html><head><title></title>
<script type='text/javascript' src='jquery-2.1.1.min.js'></script>
<script type='text/javascript' src='jquery.tablesorter.js'></script>
</head><body>";

$color1 = "#CCD7E3";
$color2 = "#F4F9FF";
//1samt_az_pulmonarycomp.prg
echo "<style>table {border-collapse:collapse;} th {background-color:#00FFFF;}</style>";
echo "<form name='p_list' action='iview.php' method='post'>";

	$query="select * from iview_update1 i1 where checked = 'Y'
			and ff = 'Y'
			and i1.id in (select distinct(ivu_id)
				from iview_programs where ivu_id
				in (select distinct(ivu_id)
					from iview_programs
					where program = '" . $_POST['optiondown'] . "'));";
//	$query="select * from iview_update1 where checked = 'Y' and ff = 'Y';";
		$result=mysqli_query($con, $query);
			confirm_queryi($result);
//		$num_rows = mysql_num_rows($result);
		$num_rows = mysqli_num_rows($result);
		$arraydata2 = array();
//		echo $num_rows;
			echo "<table id='myTable' class='tablesorter' border='1'>
			<caption>
			<h3>" . $_POST['optiondown'] . "</h3><br />
			" . $num_rows . " rows returned.
			</caption>
			<thead>
			<tr>
			<th>ID</th>
			<th>Code Value</th>
			<th>Definition</th>
			<th>Description</th>
			<th>Display</th>
			<th>Display Key</th>
<!--			<th>Checked</th>
			<th>File Found</th>
			<th>Filename</th>
			<th>File Snippet</th> -->
			</tr>
			</thead><tbody>
			";
			$row_count=0;
			while($row = mysqli_fetch_array($result)){
			//echo "<option value='" . $row[0] . "'>" . $row[1] . "</option>";
						$row_color = ($row_count % 2) ? $color1 : $color2;

			echo "
			<tbody>
			<tr bgcolor='" . $row_color . "'>
			<th>" . $row[0] . "</th>
			<td><a href='snippet/iview" . $row[0] . ".1.txt' target='_blank'>" . $row[2] . ".00</td>
			<td><a href='snippet/iview" . $row[0] . ".2.txt' target='_blank'>" . $row[3] . "</a></td>
			<td><a href='snippet/iview" . $row[0] . ".3.txt' target='_blank'>" . $row[4] . "</a></td>
			<td><a href='snippet/iview" . $row[0] . ".4.txt' target='_blank'>" . $row[5] . "</a></td>
			<td><a href='snippet/iview" . $row[0] . ".5.txt' target='_blank'>" . $row[6] . "</a></td>
<!--			<td>" . $row[7] . "</td>
			<td>" . $row[8] . "</td>
			<td><a href='http://www.robholland.net/php/play/test/" . $row[0] . ".txt'>" . $row[0] . ".txt</td> -->
			</tr></tbody>";
						$row_count++;
			}

			echo "</tbody></table>";

			echo "</form></body></html>";
//			header('Location: iview.php');
?>

