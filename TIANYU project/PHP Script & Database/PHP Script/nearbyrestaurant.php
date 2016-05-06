<?php
include'include/config.php';
if(isset($_GET['lat']) && (isset($_GET['long']))) {
    $origLat = $_GET['lat'];
    $origLon = $_GET['long'];

    if (isset($_GET['search'])) {
        $search=$_GET['search'];
        $query = mysqli_query($con, "
SELECT tbl_restourant.id,tbl_restourant.name,tbl_restourant.address,tbl_restourant.latitude,tbl_restourant.longitude,
tbl_restourant.ratting,tbl_restourant.vegtype,tbl_restourant.thumimage,
tbl_restourant.zipcode,tbl_restourant.phone_no,tbl_restourant.time,tbl_restourant.video,tbl_restourant.email,tbl_restourant.is_active,
( 3959 * ACOS( COS( RADIANS( $origLat ) ) * COS( RADIANS( `latitude` ) ) *
COS( RADIANS( `longitude` ) - RADIANS( $origLon ) ) + SIN( RADIANS( $origLat ) ) * SIN( RADIANS( `latitude` ) ) ) ) AS distance
FROM tbl_restourant
WHERE
tbl_restourant.name LIKE  '" . $search . "%'
OR tbl_restourant.zipcode LIKE  '%" . $search . "'
OR tbl_restourant.vegtype LIKE '" . $search . "%'
HAVING distance < 10000000000000000000000
order by  distance
");
        $query44 = mysqli_query($con, "
SELECT tbl_restourant.id,tbl_restourant.name,tbl_restourant.address,tbl_restourant.latitude,tbl_restourant.longitude,
tbl_restourant.ratting,tbl_restourant.vegtype,tbl_restourant.thumimage,
tbl_restourant.zipcode,tbl_restourant.phone_no,tbl_restourant.time,tbl_restourant.video,tbl_restourant.email,tbl_restourant.is_active,
( 3959 * ACOS( COS( RADIANS( $origLat ) ) * COS( RADIANS( `latitude` ) ) *
COS( RADIANS( `longitude` ) - RADIANS( $origLon ) ) + SIN( RADIANS( $origLat ) ) * SIN( RADIANS( `latitude` ) ) ) ) AS distance
FROM tbl_restourant
WHERE
tbl_restourant.name LIKE  '" . $search . "%'
OR tbl_restourant.zipcode LIKE  '%" . $search . "'
OR tbl_restourant.vegtype LIKE '" . $search . "%'
HAVING distance < 10000000000000000000000
order by  distance
");
        $dd = mysqli_num_rows($query44);
        if ($dd) {
            while ($row = mysqli_fetch_array($query)) {
                $sql = mysqli_query($con, "SELECT res_id, AVG(ratting) AS ratavg FROM tbl_userfeedback WHERE res_id='" . $row['id'] . "'");
                while ($res = mysqli_fetch_array($sql)) {
                    $avg = $res['ratavg'];
                    $vg1 = round($avg, 1);
                }
                $rev = mysqli_query($con, "select * from tbl_userfeedback WHERE res_id='" . $row['id'] . "' ");
                $my = mysqli_num_rows($rev);
                $miles = round($row['distance'], 3);
                $emparray[] = array(
                    "distance" => $miles,
                    "id" => $row['id'],
                    "name" => $row['name'],
                    "address" => $row['address'],
                    "latitude" => $row['latitude'],
                    "longitude" => $row['longitude'],
                    "ratting" => $vg1,
                    "vegtype" => $row['vegtype'],
                    "zipcode" => $row['zipcode'],
                    "totalreview" => $my,
                    "thumbnailimage" => $row['thumimage']
                );
            }
            if (isset($emparray)) {
                $jsondata['Restaurant']=$emparray;
            }
            if (isset($emparray)) {
                echo json_encode($jsondata, JSON_UNESCAPED_SLASHES);
            } else {
                $arr[] = array("id" => "record not found");
                $json['Error'] = $arr;
                echo json_encode($json);
            }

        }
        else {


        $search = $_GET['search'];
        $queryadas = mysqli_query($con, "SELECT  * , ( 3959 * ACOS( COS( RADIANS( $origLat ) ) * COS( RADIANS( `latitude` ) ) *
    COS( RADIANS( `longitude` ) - RADIANS( $origLon ) ) + SIN( RADIANS( $origLat ) ) * SIN( RADIANS( `latitude` ) ) ) ) AS distance
    FROM tbl_restourant
    HAVING distance < 10000000000000000000000
    ORDER BY distance
 ");
        while ($row = mysqli_fetch_assoc($queryadas)) {
            // echo $row['id']."<br/>";
            $queryfind = mysqli_query($con, "select food_id,food_type  from tbl_food WHERE  food_type
                LIKE '" . $search . "%' ");
            $queryfind123 = mysqli_query($con, "select food_id,food_type  from tbl_food WHERE  food_type
                LIKE '" . $search . "%' ");
            $foodcheck = mysqli_num_rows($queryfind123);

            while ($ser = mysqli_fetch_assoc($queryfind)) {
                // echo $ser['food_id']."<br>";
                if ($row['id'] == $ser['food_id']) {
                    $sql = mysqli_query($con, "SELECT res_id, AVG(ratting) AS ratavg FROM tbl_userfeedback WHERE res_id='" . $row['id'] . "'");
                    while ($res = mysqli_fetch_array($sql)) {
                        $avg = $res['ratavg'];
                        $vg1 = round($avg, 1);
                    }
                    $rev = mysqli_query($con, "select * from tbl_userfeedback WHERE res_id='" . $row['id'] . "' ");
                    $my = mysqli_num_rows($rev);
                    $miles = round($row['distance'], 3);
                    $emparray[] = array(
                        "distance" => $miles,
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


            }
        }
        if (isset($emparray)) {
            $jsondata['Restaurant']=$emparray;
        }
        if (isset($emparray)) {
            echo json_encode($jsondata, JSON_UNESCAPED_SLASHES);
        } else {
            $arr[] = array("id" => "record not found");
            $json['Error'] = $arr;
            echo json_encode($json);
        }

    }
}
    else {
            $origLat = $_GET['lat'];
            $origLon = $_GET['long'];
            $from =$_GET['no'];
            $to=$_GET['to'];

            $query = mysqli_query($con, "SELECT  * , ( 3959 * ACOS( COS( RADIANS( $origLat ) ) * COS( RADIANS( `latitude` ) ) *
COS( RADIANS( `longitude` ) - RADIANS( $origLon ) ) + SIN( RADIANS( $origLat ) ) * SIN( RADIANS( `latitude` ) ) ) ) AS distance
FROM tbl_restourant
HAVING distance < 1000
ORDER BY distance
limit $from,$to
");
            $query1 = mysqli_query($con, "SELECT  * , ( 3959 * ACOS( COS( RADIANS( $origLat ) ) * COS( RADIANS( `latitude` ) ) *
COS( RADIANS( `longitude` ) - RADIANS( $origLon ) ) + SIN( RADIANS( $origLat ) ) * SIN( RADIANS( `latitude` ) ) ) ) AS distance
FROM tbl_restourant
HAVING distance < 1000
ORDER BY distance
limit $from,$to
");
            $num = mysqli_num_rows($query1);
            if ($num > 0) {
                while ($row = mysqli_fetch_assoc($query)) {
                    $sql = mysqli_query($con, "SELECT res_id, AVG(ratting) AS ratavg FROM tbl_userfeedback WHERE res_id='" . $row['id'] . "'");
                    while ($res = mysqli_fetch_array($sql)) {
                        $avg = $res['ratavg'];
                        $vg1 = round($avg, 1);
                    }
                    $rev = mysqli_query($con, "select * from tbl_userfeedback WHERE res_id='" . $row['id'] . "' ");
                    $my = mysqli_num_rows($rev);
                    $miles = round($row['distance'], 3);
                    $emparray[] = array(

                        "id" => $row['id'],
                        "name" => $row['name'],
                        "address" => $row['address'],
                        "latitude" => $row['latitude'],
                        "longitude" => $row['longitude'],
                        "distance" => $miles,
                        "ratting" => $vg1,
                        "vegtype" => $row['Vegtype'],
                        "zipcode" => $row['zipcode'],
                        "totalreview" => $my,
                        "thumbnailimage" => $row['thumimage']
                    );
                    if (isset($emparray)) {
                        $json['Restaurant'] = $emparray;
                    } else {
                        $arr[] = array("id" => "record not found");
                        $json['Error'] = $arr;
                        echo json_encode($json);
                    }
                }
                echo json_encode($json, JSON_UNESCAPED_SLASHES);
            } else {
                $arr[] = array("id" => "record not found");
                $json['Error'] = $arr;
                echo json_encode($json);
            }

        }
    }

?>
