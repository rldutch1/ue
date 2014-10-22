<?php
//include('../includes/pw5new.php');
include('mysqli_test1.php');
include('../includes/functions.php');

echo "<html><head><title></title></head><body>";

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
		$arraydata2 = array();

			echo "<table border='1'><caption><h3>" . $_POST['optiondown'] . "</h3></caption>
			<tr>
			<th>ID</th>
			<th>Code Value</th>
			<th>Definition</th>
			<th>Description</th>
			<th>Display</th>
			<th>Display Key</th>
<!--			<th>Checked</th>
			<th>File Found</th>
			<th>Filename</th> -->
			</tr>
			";

			while($row = mysqli_fetch_array($result)){
			//echo "<option value='" . $row[0] . "'>" . $row[1] . "</option>";
						$row_color = ($row_count % 2) ? $color1 : $color2;
//						echo "<tr bgcolor='" . $row_color . "'><th>" . ($row_count + 1) . "</th><td>" . $firstnumber . "-" . $middlenumber . "-" . $lastnumber . "</td></tr>";

			echo "
			<tr bgcolor='" . $row_color . "'>
			<th>" . $row[0] . "</th>
			<td>" . $row[2] . ".00</td>
			<td>" . $row[3] . "</td>
			<td>" . $row[4] . "</td>
			<td>" . $row[5] . "</td>
			<td>" . $row[6] . "</td>
<!--			<td>" . $row[7] . "</td>
			<td>" . $row[8] . "</td>
			<td><a href='http://www.robholland.net/php/play/test/" . $row[0] . ".txt'>" . $row[0] . ".txt</td> -->
			</tr>";
						$row_count++;
			}

			echo "</table>";

			echo "</form></body></html>";
//			header('Location: iview.php');
?>

