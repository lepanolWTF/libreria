<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,libro.Libro,java.util.Iterator"%>
    <%TreeMap <String,Libro> biblioteca= new TreeMap<String,Libro>();
    biblioteca=(TreeMap<String, Libro>) request.getAttribute("lista"); int cont=1;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Biblioteca</title>
<style type="text/css">
.titulo {
	width: 650px;
	margin: 0 auto;
	margin-bottom: 20px;
	color: black;
}
#libros{border-collapse:collapse;margin: 0 auto; width:98%;}
#libros,#libros tr,#libros td{border: 1px solid black;}
#libros td{width: 10em; text-align: center;}
.tipo1{background: white;}
.tipo2{background: #cdf58c;}
.tipo0{background: #a69490;}
.libros{}
input{   
   background-color:#FFFFFF;
   border:solid 2px #000000;
   font-size:15px;
   color:#000000;
   -moz-border-radius:7px;
   -webkit-border-radius:7px;
   border-radius:7px;
   padding-top:4px;
   padding-bottom:4px;
   padding-left:4px;
   padding-right:4px;
}



/*---------tablas----------*/

/* Style the tab */
.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  
  margin: 0 auto;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
  
  margin: 0 auto;
}
/*--------------------------------------*/
</style>
<script type="text/javascript">
	function recuperaPorIsbn() {
		if(document.getElementById("porIsbn").value==""){
			var datos = 'todo=' + "true";
		    var xmlhttp;  // objeto XMLHttpRequest
		    if (window.XMLHttpRequest) {  // para IE7+, Firefox, Chrome, Opera, Safari
		        xmlhttp = new XMLHttpRequest();
		    } else {  // para IE6, IE5
		        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		    }
		    xmlhttp.onreadystatechange = function() {
		    // si el resultado está listo (readyState==4) y la respuesta es correcta (status==200)
		        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
		            var respuesta = xmlhttp.responseText;
		            respuesta=respuesta.split(";");
					rellenarTabla(respuesta);
		        }
			}
			xmlhttp.open("GET","Principal?" + datos ,true);  // crea la conexión con parámetros: método, url, asíncrono?
			xmlhttp.setRequestHeader("X-Requested-With", "xmlhttprequest");  // establece la cabecera HTTP necesaria
			xmlhttp.send();  // lanza la solicitud
		}else{
			var datos = 'isbn=' + document.getElementById("porIsbn").value;
		    var xmlhttp;  // objeto XMLHttpRequest
		    if (window.XMLHttpRequest) {  // para IE7+, Firefox, Chrome, Opera, Safari
		        xmlhttp = new XMLHttpRequest();
		    } else {  // para IE6, IE5
		        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		    }
		    xmlhttp.onreadystatechange = function() {
		    // si el resultado está listo (readyState==4) y la respuesta es correcta (status==200)
		        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
		            var respuesta = xmlhttp.responseText;
		            respuesta=respuesta.split(",");
					anadirTabla(respuesta);
		        }
			}
			xmlhttp.open("GET","Principal?" + datos ,true);  // crea la conexión con parámetros: método, url, asíncrono?
			xmlhttp.setRequestHeader("X-Requested-With", "xmlhttprequest");  // establece la cabecera HTTP necesaria
			xmlhttp.send();  // lanza la solicitud
		}
	}
	
	function borrar(){
		document.getElementById("libros").innerHTML="";
		
		var table = document.getElementById("libros");
		var row = table.insertRow(0);
		row.className +=" tipo0";
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		cell1.innerHTML = "Isbn";
		cell2.innerHTML = "Autor";
		cell3.innerHTML = "Título";
		cell4.innerHTML = "Año";
	}
	
	function eliminarLibro(){
		
		var datos = 'borrar=' + document.getElementById("borrarIsbn").value;
	    var xmlhttp;  // objeto XMLHttpRequest
	    if (window.XMLHttpRequest) {  // para IE7+, Firefox, Chrome, Opera, Safari
	        xmlhttp = new XMLHttpRequest();
	    } else {  // para IE6, IE5
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	    }
	    xmlhttp.onreadystatechange = function() {
	    // si el resultado está listo (readyState==4) y la respuesta es correcta (status==200)
	        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
	            var respuesta = xmlhttp.responseText;
	            respuesta=respuesta.split(";");
				rellenarTabla(respuesta);
	        }
		}
		xmlhttp.open("GET","Principal?" + datos ,true);  // crea la conexión con parámetros: método, url, asíncrono?
		xmlhttp.setRequestHeader("X-Requested-With", "xmlhttprequest");  // establece la cabecera HTTP necesaria
		xmlhttp.send();  // lanza la solicitud
	}
	
	function anadirLibro(){
		var datos = 'anadir=' + document.getElementById("anadirIsbn").value +","+ document.getElementById("anadirAutor").value+","+ document.getElementById("anadirTitulo").value+","+ document.getElementById("anadirAnio").value;
	    var xmlhttp;  // objeto XMLHttpRequest
	    if (window.XMLHttpRequest) {  // para IE7+, Firefox, Chrome, Opera, Safari
	        xmlhttp = new XMLHttpRequest();
	    } else {  // para IE6, IE5
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	    }
	    xmlhttp.onreadystatechange = function() {
	    // si el resultado está listo (readyState==4) y la respuesta es correcta (status==200)
	        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
	            var respuesta = xmlhttp.responseText;
	            if(respuesta.length<=1){
	            	document.getElementById("anadirIsbn").style.background="white";
		            respuesta=respuesta.split(";");
					rellenarTabla(respuesta);
					document.getElementById("anadirIsbn").value="";
					document.getElementById("anadirAutor").value="";
 					document.getElementById("anadirTitulo").value="";
					document.getElementById("anadirAnio").value="";
					
	            }else{
	            	alert("Error, ese isbn ya existe");
	            	document.getElementById("anadirIsbn").style.background="red";
	            }
	        }
		}
		xmlhttp.open("GET","Principal?" + datos ,true);  // crea la conexión con parámetros: método, url, asíncrono?
		xmlhttp.setRequestHeader("X-Requested-With", "xmlhttprequest");  // establece la cabecera HTTP necesaria
		xmlhttp.send();  // lanza la solicitud
	}
	
	function editarLibro(){
		var datos = 'editar=' + document.getElementById("editarIsbn").value +","+ document.getElementById("editarAutor").value+","+ document.getElementById("editarTitulo").value+","+ document.getElementById("editarAnio").value;
	    var xmlhttp;  // objeto XMLHttpRequest
	    if (window.XMLHttpRequest) {  // para IE7+, Firefox, Chrome, Opera, Safari
	        xmlhttp = new XMLHttpRequest();
	    } else {  // para IE6, IE5
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	    }
	    xmlhttp.onreadystatechange = function() {
	    // si el resultado está listo (readyState==4) y la respuesta es correcta (status==200)
	        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
	            var respuesta = xmlhttp.responseText;
	            if(respuesta.length>1){
	            	document.getElementById("anadirIsbn").style.background="white";
		            respuesta=respuesta.split(";");
					rellenarTabla(respuesta);
					document.getElementById("editarIsbn").value="";
					document.getElementById("editarAutor").value="";
 					document.getElementById("editarTitulo").value="";
					document.getElementById("editarAnio").value="";
					
	            }else{
	            	alert("Error, ese isbn no existe");
	            	document.getElementById("anadirIsbn").style.background="red";
	            }
	        }
		}
		xmlhttp.open("GET","Principal?" + datos ,true);  // crea la conexión con parámetros: método, url, asíncrono?
		xmlhttp.setRequestHeader("X-Requested-With", "xmlhttprequest");  // establece la cabecera HTTP necesaria
		xmlhttp.send();  // lanza la solicitud
	}
	
	function rellenarFormEditaro(){
		var datos = 'isbn=' + document.getElementById("editarIsbn").value;
	    var xmlhttp;  // objeto XMLHttpRequest
	    if (window.XMLHttpRequest) {  // para IE7+, Firefox, Chrome, Opera, Safari
	        xmlhttp = new XMLHttpRequest();
	    } else {  // para IE6, IE5
	        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	    }
	    xmlhttp.onreadystatechange = function() {
	    // si el resultado está listo (readyState==4) y la respuesta es correcta (status==200)
	        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
	            var respuesta = xmlhttp.responseText;
	            respuesta=respuesta.split(",");
				document.getElementById("editarAutor").value=respuesta[1];
				document.getElementById("editarTitulo").value=respuesta[2];
				document.getElementById("editarAnio").value=respuesta[3];
	        }
		}
		xmlhttp.open("GET","Principal?" + datos ,true);  // crea la conexión con parámetros: método, url, asíncrono?
		xmlhttp.setRequestHeader("X-Requested-With", "xmlhttprequest");  // establece la cabecera HTTP necesaria
		xmlhttp.send();  // lanza la solicitud
	}
	
	function anadirTabla(respuesta){
		borrar();
		var table = document.getElementById("libros");
		var row = table.insertRow(document.getElementById("libros").rows.length);
		
		row.className +=" tipo2";
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		cell1.innerHTML = respuesta[0];
		cell2.innerHTML = respuesta[1];
		cell3.innerHTML = respuesta[2];
		cell4.innerHTML = respuesta[3];
		
	}
	
	function rellenarTabla(respuesta){
		borrar();
		var table = document.getElementById("libros");
		var tipo="tipo1";
		
		for(i=0;i<respuesta.length-1;i++){
			var spl=respuesta[i].split(",");
			var row = table.insertRow(document.getElementById("libros").rows.length);
			if(tipo=="tipo1"){
				tipo="tipo2";
			}else{
				tipo="tipo1";				
			}
			row.className +=tipo;
			var cell1 = row.insertCell(0);
			var cell2 = row.insertCell(1);
			var cell3 = row.insertCell(2);
			var cell4 = row.insertCell(3);
			cell1.innerHTML = spl[0];
			cell2.innerHTML = spl[1];
			cell3.innerHTML = spl[2];
			cell4.innerHTML = spl[3];
		}
	}
	
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
</head>
<body>
	<div class="titulo">
		<h1>Libros disponibles en la biblioteca</h1>
	</div>
	<table id="libros">
		<tr class="tipo0">
			<td>Isbn</td><td>Autor</td><td>Título</td><td>Año</td>
			<%Iterator it = biblioteca.keySet().iterator();
			while(it.hasNext()){
				  String key =  (String) it.next();
				  if(cont==1){
					  cont=2;
				  }else{
					  cont=1;
				  }
				  %><tr class="tipo<%=cont%>"><td><%=biblioteca.get(key).getIsbn()%></td><td><%=biblioteca.get(key).getAutor()%></td><td><%=biblioteca.get(key).getTitulo()%></td><td><%=biblioteca.get(key).getAnio()%></td></tr>
			<%} %>

			
	</table>
	<br/>
	<div class="tab">
	  <button class="tablinks" onclick="openCity(event, 'buscar')">Buscar</button>
	  <button class="tablinks" onclick="openCity(event, 'borrar')">Borrar</button>
	  <button class="tablinks" onclick="openCity(event, 'anadir')">Añadir</button>
	  <button class="tablinks" onclick="openCity(event, 'modificar')">Modificar</button>
	</div>
	<div id="buscar" class="tabcontent">
		  <h3>Buscar</h3>
		  Isbn <input type="text" id="porIsbn" onkeyup="recuperaPorIsbn()">
	</div>
	<div id="borrar" class="tabcontent">
		  <h3>Borrar</h3>
		  	<form action="">
				ISBN <input type="text" id="borrarIsbn">
			<button id="borrarlibro" onclick="eliminarLibro()">Borrar Libro</button>
		</form>
	</div>
	<script>
		document.getElementById("borrarlibro").addEventListener("click", function(event){
		    event.preventDefault()
		});
		document.getElementById("anadirNuevoLibro").addEventListener("click", function(event){
		    event.preventDefault()
		});
	</script>
	<div id="anadir" class="tabcontent">
		  <h3>Añadir</h3>
		  <table>
		  <tr><td>ISBN</td><td><input type="text" id="anadirIsbn"></td>
		  <td>Autor</td><td><input type="text" id="anadirAutor"></td></tr>
		  <tr><td>Título</td><td><input type="text" id="anadirTitulo">
		  <td>Año</td><td><input type="text" id="anadirAnio"></td></tr>
		  </table>
		  <br/>
		  <button id="anadirNuevoLibro" onclick="anadirLibro()">Añadir libro</button>
	</div>
	<div id="modificar" class="tabcontent">
		  <h3>Modificar</h3>
		  <table>
		  <tr><td>ISBN</td><td><input type="text" id="editarIsbn" onkeyup="rellenarFormEditaro()"></td>
		  <td>Autor</td><td><input type="text" id="editarAutor"></td></tr>
		  <tr><td>Título</td><td><input type="text" id="editarTitulo"></td>
		  <td>Año</td><td><input type="text" id="editarAnio"></td></tr>
		  </table>
		  <br/>
		  <button id="editarLibro" onclick="editarLibro()">Editar libro</button>
	</div>
	
	<script>
		function openCity(evt, cityName) {
		  var i, tabcontent, tablinks;
		  tabcontent = document.getElementsByClassName("tabcontent");
		  for (i = 0; i < tabcontent.length; i++) {
		    tabcontent[i].style.display = "none";
		  }
		  tablinks = document.getElementsByClassName("tablinks");
		  for (i = 0; i < tablinks.length; i++) {
		    tablinks[i].className = tablinks[i].className.replace(" active", "");
		  }
		  document.getElementById(cityName).style.display = "block";
		  evt.currentTarget.className += " active";
		}
	</script>

</body>
</html>
