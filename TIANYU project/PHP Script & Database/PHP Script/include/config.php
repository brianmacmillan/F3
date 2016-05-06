<?php
$con=mysqli_connect(

/* Host Name */               "localhost",

/* Data Base User Name */     "root",

/* Data Base Password */      "root",

/* Data Base Name  */         "restaurant"

);
if($con){ }  else { ?> <script>alert("Connection Error try again !!");</script> <?php } ?>