<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,libro.Libro,java.util.Iterator"%>
    <%TreeMap <String,Libro> biblioteca= new TreeMap<String,Libro>();
    biblioteca=(TreeMap<String, Libro>) request.getAttribute("lista"); int cont=0;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Biblioteca</title>
<style type="text/css">
table,tr{border: 1px solid black;}
.tipo1{background:;}
.tipo2{background:;}
</style>
<script type="text/javascript">
	function recuperaPorIsbn() {
	    // se genera la query_string
	    
	    var datos = 'biblioteca=' + document.getElementById("comunidades").value;
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
	
	function anadirTabla(respuesta){
		document.getElementById("libros").innerHTML="";
		
	}

</script>
</head>
<body>
	<table id="libros">
		<tr>
			<td></td><td>Isbn</td><td>Autor</td><td>Titulo</td><td>Año</td>
			<%Iterator it = biblioteca.keySet().iterator();
			while(it.hasNext()){
				  String key =  (String) it.next();
				  %><tr><td></td><td><%=biblioteca.get(key).getIsbn()%></td><td><%=biblioteca.get(key).getAutor()%></td><td><%=biblioteca.get(key).getTitulo()%></td><td><%=biblioteca.get(key).getAnio()%></td></tr>
			<%} %>
	
	</table>
</body>
</html>