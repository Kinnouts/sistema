<?php 
require_once "../modelos/Articulo.php";

$articulo=new Articulo();//Diez atributos instanciar

$idarticulo=isset($_POST["idarticulo"])? limpiarCadena($_POST["idarticulo"]):"";
$idcategoria=isset($_POST["idcategoria"])? limpiarCadena($_POST["idcategoria"]):"";
$codigo=isset($_POST["codigo"])? limpiarCadena($_POST["codigo"]):"";
$nombre=isset($_POST["nombre"])? limpiarCadena($_POST["nombre"]):"";
$stock=isset($_POST["stock"])? limpiarCadena($_POST["stock"]):"";
$imagen=isset($_POST["imagen"])? limpiarCadena($_POST["imagen"]):"";
$descripcion=isset($_POST["descripcion"])? limpiarCadena($_POST["descripcion"]):"";




switch ($_GET["op"]){
	case 'guardaryeditar':
		//en esta parte ponemos codigo de lo de la imagen
		if(!file_exists($_FILES['imagen']['tmp_name'])||!is_uploaded_file($_FILES['imagen']['tmp_name'])){
			$imagen="";
		}
		else{
			$ext=explode(".",$_FILES["imagen"]["name"]);
			if($_FILES['imagen']['type']=="imagen/jpg"||$_FILES['imagen']['type']=="imagen/jpeg"||$_FILES['imagen']['type']=="imagen/png"){
				//la variable imagen va a almacenar el nombre de la imagen + la extensión
				//el nombre de la imagen se va a renombrar utilizando lafunción microtime
				$imagen=round(microtime(true)).'.'.end($ext);
				//Voy a subir el archivo al sistema
				move_uploaded_file($_FILES["imagen"]["tmp_name"],"../files/articulos/".$imagen);
			}
		}

		if (empty($idarticulo)){
			$rspta=$articulo->insertar($idarticulo, $codigo, $nombre,$stock,$descripcion, $imagen);
			echo $rspta ? "Articulo registrado" : "Articulo no se pudo registrar";
		}
		else {
			$rspta=$articulo->editar($idarticulo, $idcategoria, $codigo, $nombre,$stock,$descripcion, $imagen);
			echo $rspta ? "Articulo actualizado" : "Articulo no se pudo actualizar";
		}
	break;

	case 'desactivar':
		$rspta=$articulo->desactivar($idarticulo);
 		echo $rspta ? "Articulo Desactivado" : "Articulo no se puede desactivar";
 	break;

	case 'activar':
		$rspta=$articulo->activar($idarticulo);
 		echo $rspta ? "Articulo activado" : "Articulo no se puede activar";
 	break;

	case 'mostrar':
		$rspta=$articulo->mostrar($idarticulo);
 		//Codificar el resultado utilizando json
 		echo json_encode($rspta);
 	break;

	case 'listar':
		$rspta=$$articulo->listar();
 		//Vamos a declarar un array
 		$data= Array();

 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>($reg->condicion)?'<button class="btn btn-warning" onclick="mostrar('.$reg->idarticulo.')"><i class="fa fa-pencil"></i></button>'.
 					' <button class="btn btn-danger" onclick="desactivar('.$reg->idarticulo.')"><i class="fa fa-close"></i></button>':
 					'<button class="btn btn-warning" onclick="mostrar('.$reg->idarticulo.')"><i class="fa fa-pencil"></i></button>'.
 					' <button class="btn btn-primary" onclick="activar('.$reg->darticulo.')"><i class="fa fa-check"></i></button>',
 				"1"=>$reg->nombre,
 				"2"=>$reg->categoria,//Nombre del rubro
				"3"=>$reg->codigo,
				"4"=>$reg->stock,
				"5"=>"<img src='../files/articulos/".$reg->imagen."'height='50px' width='50px'>",
 				"6"=>($reg->condicion)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>'
 				);
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);

	break;
}
?>