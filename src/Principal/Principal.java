package Principal;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import libro.Libro;

@WebServlet("/Principal")
public class Principal extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Principal() {
        super();
    }
    ArrayList <Libro> biblioteca= new ArrayList<Libro>();
       
    private void cargar() {
    	biblioteca.add(new Libro("165111965206","Manolito","La luna","1997"));
    	biblioteca.add(new Libro("188123621585","Juanito","La franja","1997"));
    	biblioteca.add(new Libro("565216881266","Amadeo","Colosus","1997"));
    	biblioteca.add(new Libro("188912562698","Josito","Blanca navidad","1997"));
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
