package Principal;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.Iterator;
import java.util.TreeMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

import libro.Libro;

@WebServlet("/Principal")
public class Principal extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String vista = "/Interfaz.jsp";
    public Principal() {
        super();
    }
    TreeMap <String,Libro> biblioteca= new TreeMap<String,Libro>();
       
    private void cargar() {
    	biblioteca.put("165111965206",new Libro("165111965206","Manolito","La luna","1997"));
    	biblioteca.put("188123621585",new Libro("188123621585","Juanito","La franja","1997"));
    	biblioteca.put("565216881266",new Libro("565216881266","Amadeo","Colosus","1997"));
    	biblioteca.put("188912562698",new Libro("188912562698","Josito","Blanca navidad","1997"));
    	biblioteca.put("565612545861",new Libro("565612545861","Josito","Conmentarios","1998"));
    	biblioteca.put("565051515441",new Libro("565051515441","Amadeo","Robots con inteligencia","1993"));
    	biblioteca.put("188412565698",new Libro("188412565698","Juanito","Lugares coultos","1999"));
    	biblioteca.put("188455562698",new Libro("188455562698","Manolito","Misterios en el anden","1994"));
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		cargar();
        PrintWriter out = response.getWriter();
		Boolean esAjax;
        esAjax="XMLHttpRequest".equalsIgnoreCase(request.getHeader("X-Requested-With")); // Cabecera X-Requested-With
        if (esAjax) {
            // Comprobar si el usuario es válido
            String isbn=request.getParameter("isbn");
            if(isbn!=null && isbn!="") {
            	System.out.println("Entro bien");
            	if(biblioteca.containsKey(isbn)) {
            		Libro li1=biblioteca.get(isbn);
            		out.println(concatenar(li1));
            	}else {
            		out.println("");
            	}
            	
            }
            out.println("");
        }else {
    		request.setAttribute("lista", biblioteca);
    		
    		
    		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(vista);
            dispatcher.forward(request, response); 
        }    
    
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	
	private String concatenar(Libro lib) {	
		System.out.println("Hago bien el proceso de concat");
		return lib.getIsbn()+","+lib.getAutor()+","+lib.getTitulo()+","+lib.getAnio();
	}

}
