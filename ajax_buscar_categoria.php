<?php
session_start();
require_once("../../conexion.php");

$db->debug=false;

if(isset($_POST['id_rubro'])){
    $id_rubro = $_POST['id_rubro'];
    
    $sql = "SELECT * FROM categorias WHERE id_rubro = ? AND estado = 'A'";
    $rs = $db->Execute($sql, array($id_rubro));
    
    echo '<option value="">Seleccione</option>';
    foreach ($rs as $r) {
        echo "<option value='" . $r['id_categoria'] . "'>" . $r['categoria_rubro'] . "</option>";
    }
}
?>