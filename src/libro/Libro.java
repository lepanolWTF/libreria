package libro;

import java.util.Date;

public class Libro {
	private String isbn,autor,titulo,anio;
	
	public Libro(String isbn, String autor, String titulo, String anio) {
		this.isbn = isbn;
		this.autor = autor;
		this.titulo = titulo;
		this.anio = anio;
	}
	
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getAutor() {
		return autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getAnio() {
		return anio;
	}
	public void setAnio(String anio) {
		this.anio = anio;
	}
	
	
}
