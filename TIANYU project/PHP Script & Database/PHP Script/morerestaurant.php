<?php
include("include/config.php");
if(isset($_GET['no'])) {
    $no = $_GET['no'];
    $to = $_GET['to'];
    $query = mysqli_query($con, "select * from tbl_restourant limit $no,$to");
    while($row=mysqli_fetch_assoc($query))
    {
        $sql = mysqli_query($con, "SELECT res_id, AVG(ratting) AS ratavg FROM tbl_userfeedback WHERE res_id='" . $row['id'] . "'");
        while ($res = mysqli_fetch_array($sql)) {
            $avg = $res['ratavg'];
            $vg1 = round($avg, 1);
        }
        $rev = mysqli_query($con, "select * from tbl_userfeedback WHERE res_id='" . $row['id'] . "' ");
        $my = mysqli_num_rows($rev);
        $emparray[] = array(
            "id" => $row['id'],
            "name" => $row['name'],
            "address" => $row['address'],
            "latitude" => $row['latitude'],
            "longitude" => $row['longitude'],
            "ratting" => $vg1,
            "vegtype" => $row['Vegtype'],
            "zipcode" => $row['zipcode'],
            "totalreview" => $my,
            "thumbnailimage" => $row['thumimage']
        );
    }
    if (isset($emparray)) {
        $json['Restaurant'] = $emparray;
        echo json_encode($json);
    }
    else {
        $arr[] = array("id" => "record not found");
        $json['Error'] = $arr;
        echo json_encode($json);
    }
}

?>

