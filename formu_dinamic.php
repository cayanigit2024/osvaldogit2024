<?php
session_start();
require_once("../../conexion.php");
require_once("../../libreria_menu.php");

$db->debug=false;

echo "<html> 
       <head>
       <link rel='stylesheet' href='../../../css/bootstrap.min.css'>
       <link rel='stylesheet' href='../../css/nuevo_estilo.css' type='text/css'>
       <script type='text/javascript' src='../../../js/bootstrap.bundle.min.js'></script>
         <title>INSERTAR ACTIVO FIJO</title>
       </head>
       <body>
         <div class='formu_ingreso_datos'>
           <h2>INSERTAR ACTIVO FIJO</h2>
           <form action='activos_fijos_nuevo1.php' method='post' name='formu' class='formulario-responsive'>
             <div class='form-row'>
               <div class='form-column'>
                 <label for='id_rubro'><b>(*)Selecciona Rubro</b></label>
                 <select name='id_rubro' id='id_rubro'>
                   <option value=''>Seleccione</option>";
                   $sql = "SELECT * FROM rubros WHERE estado = 'A'";
                   $rs = $db->Execute($sql);
                   foreach ($rs as $r) {
                     echo "<option value='".$r['id_rubro']."'>".$r['rubro']."</option>";
                   }
echo "           </select>
               </div>
               <div class='form-column'>
                 <label for='id_categoria'><b>(*)Categoría</b></label>
                 <select name='id_categoria' id='id_categoria' disabled>
                   <option value=''>Seleccione un rubro primero</option>
                 </select>
               </div>
             </div>
             <div id='datos_adicionales' style='display:none;'>
               <div class='form-row'>
                 <div class='form-column'>
                   <label for='descripcion'><b>(*)Descripción</b></label>
                   <input type='text' name='descripcion' id='descripcion' size='40'>
                 </div>
               </div>
               <div class='form-row'>
                 <div class='form-column'>
                   <label for='fecha_adquisicion'><b>(*)Fecha adquisición</b></label>
                   <input type='date' name='fecha_adquisicion' id='fecha_adquisicion'>
                 </div>
                 <div class='form-column'>
                   <label for='fecha_activacion'><b>Fecha activación</b></label>
                   <input type='date' name='fecha_activacion' id='fecha_activacion'>
                 </div>
               </div>
               <div class='form-row'>
                 <div class='form-column'>
                   <label for='fotografia'><b>Fotografía</b></label>
                   <input type='file' name='fotografia' id='fotografia'>
                 </div>
                 <div class='form-column'>
                   <label for='nro_documento'><b>Nro documento</b></label>
                   <input type='text' name='nro_documento' id='nro_documento'>
                 </div>
               </div>
               <div class='form-row'>
                 <div class='form-column'>
                   <label for='valor'><b>(*)Valor</b></label>
                   <input type='number' name='valor' id='valor' step='0.01'>
                 </div>
                 <div class='form-column'>
                   <label for='valor_residual'><b>Valor Residual</b></label>
                   <input type='number' name='valor_residual' id='valor_residual' step='0.01'>
                 </div>
               </div>
               <div class='form-row'>
                 <div class='form-column'>
                   <label for='responsable'><b>Responsable</b></label>
                   <input type='text' name='responsable' id='responsable'>
                 </div>
               </div>
               <div class='form-row' id='depreciacion_row' style='display:none;'>
                 <div class='form-column'>
                   <label for='depreciacion'><b>Depreciación</b></label>
                   <input type='text' name='depreciacion' id='depreciacion'>
                 </div>
               </div>
               <div class='form-row' id='marca_row' style='display:none;'>
                 <div class='form-column'>
                   <label for='marca_del_activo'><b>Marca del Activo</b></label>
                   <input type='text' name='marca_del_activo' id='marca_del_activo'>
                 </div>
               </div>
               <div class='form-row' id='serie_placa_row' style='display:none;'>
                 <div class='form-column'>
                   <label for='nro_serie_placa'><b>Número de Serie/Placa</b></label>
                   <input type='text' name='nro_serie_placa' id='nro_serie_placa'>
                 </div>
               </div>
               <div class='form-row'>
                 <input type='hidden' name='accion' value=''>
                 <input type='button' value='Adicionar Activo Fijo' onclick='validar();' class='boton'>
                 <input type='button' value='Borrar' onclick='location.href=\"activos_fijos.php\";' class='boton'>
               </div>
             </div>
           </form>
         </div>
       </body>
     </html>";
?>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var idRubro = document.getElementById('id_rubro');
    var idCategoria = document.getElementById('id_categoria');
    var datosAdicionales = document.getElementById('datos_adicionales');

    function resetForm() {
        idCategoria.innerHTML = '<option value=\"\">Seleccione un rubro</option>';
        idCategoria.disabled = true;
        datosAdicionales.style.display = 'none';
        document.getElementById('depreciacion_row').style.display = 'none';
        document.getElementById('marca_row').style.display = 'none';
        document.getElementById('serie_placa_row').style.display = 'none';
    }

    idRubro.addEventListener('change', function() {
        var rubroValue = this.value;
        resetForm();
        if(rubroValue) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'ajax_buscar_categoria.php', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if(xhr.readyState == 4 && xhr.status == 200) {
                    idCategoria.innerHTML = xhr.responseText;
                    idCategoria.disabled = false;
                }
            };
            xhr.send('id_rubro=' + rubroValue);
        }
    });

    idCategoria.addEventListener('change', function() {
        var categoriaValue = parseInt(this.value);
        if (categoriaValue && idRubro.value) {
            datosAdicionales.style.display = 'block';
            document.getElementById('depreciacion_row').style.display = 'none';
            document.getElementById('marca_row').style.display = 'none';
            document.getElementById('serie_placa_row').style.display = 'none';

            if(categoriaValue >= 4) {
                document.getElementById('depreciacion_row').style.display = 'flex';
            }
            if(categoriaValue >= 9) {
                document.getElementById('marca_row').style.display = 'flex';
            }
            if(categoriaValue == 14) {
                document.getElementById('serie_placa_row').style.display = 'flex';
            }
        } else {
            datosAdicionales.style.display = 'none';
        }
    });
});

function validar() {
    document.formu.submit();
}
</script>"