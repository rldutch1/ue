<?php
//include('../includes/pw5new.php');
include('mysqli_test1.php');
include('../includes/functions.php');

//echo "\r\n <br /> Holland \r\n <br />";
echo "<html><head><title></title></head><body>";
/*
echo "<form name='p_list' action='iview.php' method='post'><select>";

$query="select * from iview_update where checked = 'N';";
		$result=mysqli_query($con, $query);
			confirm_queryi($result);
		$arraydata = array();

			while($row = mysqli_fetch_array($result)){
			echo "<option value='" . $row[0] . "'>" . $row[1] . "</option>";
			}
			echo "</select>

			</form></body></html>";
*/

echo "<style>table {border-collapse:collapse;}</style>";
echo "<form name='p_list' action='iview.php' method='post'>";

	$query="select * from iview_update1 where checked = 'Y' and ff = 'Y';";
		$result=mysqli_query($con, $query);
			confirm_queryi($result);
		$arraydata = array();
			echo "<table border='1'>
			<tr>
			<th>ID</th>
			<th>Code Value</th>
			<th>Definition</th>
			<th>Description</th>
			<th>Display</th>
			<th>Display Key</th>
			<th>Checked</th>
			<th>Filename</th>
			</tr>
			";

			while($row = mysqli_fetch_array($result)){
			//echo "<option value='" . $row[0] . "'>" . $row[1] . "</option>";
			echo "
			<tr>
			<th>" . $row[0] . "</th>
			<td>" . $row[2] . ".00</td>
			<td>" . $row[3] . "</td>
			<td>" . $row[4] . "</td>
			<td>" . $row[5] . "</td>
			<td>" . $row[6] . "</td>
			<td>" . $row[7] . "</td>
			<td><a href='http://www.robholland.net/php/play/test/" . $row[0] . ".txt'>" . $row[0] . ".txt</td>
			</tr>";
			}

			echo "</table>";

/*
			while($row1 = mysqli_fetch_array($result)){
			//echo "<option value='" . $row[0] . "'>" . $row[1] . "</option>";
			echo "
			grep -i \"" . $row1[2] . "\" *.prg |cut -d : -f1 > RH" . $row1[0] . ".1<br />
			grep -i \"" . $row1[3] . "\" *.prg |cut -d : -f1 > RH" . $row1[0] . ".2<br />
			grep -i \"" . $row1[4] . "\" *.prg |cut -d : -f1 > RH" . $row1[0] . ".3<br />
			grep -i \"" . $row1[5] . "\" *.prg |cut -d : -f1 > RH" . $row1[0] . ".4<br />
			grep -i \"" . $row1[6] . "\" *.prg |cut -d : -f1 > RH" . $row1[0] . ".5<br />
			";
			}
*/
/*
			while($row2 = mysqli_fetch_array($result)){
			//echo "<option value='" . $row[0] . "'>" . $row[1] . "</option>";
			echo "
			cat RH" . $row2[0] . ".* >> RH" . $row2[0] . ".txt<br />
			";
			}
*/

//select * from iview_update1 where checked = 'Y' and ff = 'Y';
//create view vw_ivprograms as select ivu_id, program from iview_programs group by program;
//select distinct(ivu_id) from iview_programs where program = '1bh_mpage_crystalloids_jdm.prg';
//select ivu_id from vw_ivprograms where program = '1bh_mpage_crystalloids_jdm.prg';
//select * from iview_update1 i1 where checked = 'Y' and ff = 'Y' and i1.id in (select distinct(ivu_id) from iview_programs where program = '1samt_az_pulmonarycomp.prg'); //Dropdown choice will be entered for the program name.
//select * from vw_ivprograms order by program, ivu_id; //Dropdown choices will be made from this select.
/*Walkthrough:
The original CCL query generated 88 DISPLAY_KEY/CODE_SETS/Terms to look for. I added code_set 14003 because it is used on some forms.
Code_set 14003 generated an additional 50 terms to look for, making a total of a 138 search terms.
This page shows all 138 terms.
Running grep on the backend to search for those terms generated a list of 400?? text files that contained the filenames
where the term could be found. ????????

 7,323 files. The large number of files was due to
the term being found multiple times in the same file and the filename being generated for each occurance.
After removing the duplicate files only 138 files remained. 100 terms remained (meaning I could not find 38 terms).

*/
			echo "</form></body></html>";
?>

