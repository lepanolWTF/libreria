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
table{border-collapse:collapse;}
table,tr,td{border: 1px solid black;}
td{width: 10em; text-align: center;}
.tipo1{background: white;}
.tipo2{background: #a69490;}


/*DESPLEGABLES acordeon*/
/*.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 40%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}*/

.active, .accordion:hover {
  background-color: #ccc; 
}

.panel {
  padding: 0 18px;
  display: none;
  background-color: white;
  overflow: hidden;
}
/*------------------------------------*/
</style>
<script type="text/javascript">
	function recuperaPorIsbn() {
	    // se genera la query_string
	    borrar();
	    var datos = 'isbn=' + document.getElementById("porIsbn").value;
	    /**alert("Datos a enviar: " + datos);**/
	
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
	
	function borrar(){
		document.getElementById("libros").innerHTML="";
		
		var table = document.getElementById("libros");
		var row = table.insertRow(0);
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		cell1.innerHTML = "Isbn";
		cell2.innerHTML = "Autor";
		cell3.innerHTML = "Título";
		cell4.innerHTML = "Año";
	}
	
	function anadirTabla(respuesta){
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
	
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
</head>
<body>
<input type="text" id="porIsbn" onkeyup="recuperaPorIsbn()">
	<table id="libros">
		<tr>
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
	<button class="accordion">Section 1</button>
	<div class="panel">
		<form action="">
			ISBN <input type="text">
			<input type="submit">
		</form>
	</div>
	<br/>
	<button class="accordion">Section 1</button>
	<div class="panel">
		<form action="">
			ISBN <input type="text">
			<input type="submit">
		</form>
	</div>
		  
	<script>
		var acc = document.getElementsByClassName("accordion");
		var i;
		
		for (i = 0; i < acc.length; i++) {
		  acc[i].addEventListener("click", function() {
		    this.classList.toggle("active");
		    var panel = this.nextElementSibling;
		    if (panel.style.display === "block") {
		      panel.style.display = "none";
		    } else {
		      panel.style.display = "block";
		    }
		  });
		}
</script>

</body>
</html>
