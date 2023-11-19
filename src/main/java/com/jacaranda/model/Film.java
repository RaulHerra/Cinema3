package com.jacaranda.model;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

import com.jacaranda.exception.FilmException;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table (name ="Pelicula")
public class Film {
	
	private static final int MAX_LENGTH_NATIONALITY = 15;
	private static final int MAX_LENGTH_TITLE_S = 45;
	private static final int MAX_LENGTH_TITLE_P = 45;
	private static final int MAX_LENGTH_CIP = 10;
	
	@Id
	private String cip;
	@Column(name="titulo_p")
	private String titleP;
	@Column(name="ano_produccion")
	private int productionYear;
	@Column(name="titulo_s")
	private String titleS;
	@Column(name="nacionalidad")
	private String nationality;
	@Column(name="presupuesto")
	private int budget;
	@Column(name="duracion")
	private int duration;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "film")
	private List<Work>characters;
	
	public Film(String cip, String titleP, String yearProduction, String titleS, String nationality, String budget,
			String duration) throws FilmException {
		super();
		
		/*Creo estas tres variables como int y inicializadas en 0 porque recibo todo en String y ya voy validando
		 * los numeros sin son correctos*/
		int numyearProduction = 0;
		int numBudget = 0;
		int numduration = 0;
		
		numyearProduction = validateNumYearProdroduction(yearProduction, numyearProduction);
		numBudget = validateNumBudget(budget,numBudget);
		numduration = validateNumDuration(duration, numduration);
		
		//Llamo al método de validar los datos introducidos que he creado más abajo
		validations(cip, titleP, numyearProduction, titleS, nationality, numBudget, numduration);
		
		//Si no hay ningún error se crearía el objeto correctamente
		this.cip = cip;
		this.titleP = titleP;
		this.productionYear = numyearProduction;
		this.titleS = titleS;
		this.nationality = nationality;
		this.budget = numBudget;
		this.duration = numduration;
	}
	
	public Film() { //Añado este constructor vacio porque es necesario para hacer las query con hibernate
		super();
	}
	
	/*Aquí lo que hago es que si me mete un año que no sea un número devuelva una excepcion o si no el numero*/
	private int validateNumYearProdroduction(String yearProduction, int numyearProduction) throws FilmException {
		try {
			numyearProduction = Integer.valueOf(yearProduction);
		}catch (Exception e) {
			throw new FilmException("Error enter a valid year");
		}
		return numyearProduction;
	}
	
	/*Aquí lo que hago es que si me mete un presupuesto que no sea un número devuelva una excepcion o si no el numero*/
	private int validateNumBudget(String budget, int numBudget) throws FilmException {
		try {
			numBudget = Integer.valueOf(budget);
		}catch (Exception e) {
			throw new FilmException("Error enter a valid budget");
		}
		return numBudget;
	}
	
	/*Aquí lo que hago es que si me mete una duracion que no sea un número devuelva una excepcion o si no el numero*/
	private int validateNumDuration(String duration, int numDuration) throws FilmException {
		try {
			numDuration = Integer.valueOf(duration);
		}catch (Exception e) {
			throw new FilmException("Error enter a valid duration");
		}
		return numDuration;
	}

	/*Compruebo que todos los datos estén correctos y en el caso de que no estén correcto salta una excepcion*/
	private void validations(String cip, String titleP, int yearProduction, String titleS, String nationality,
			int budget, int duration) throws FilmException {
		if( cip == null || cip.equals(" ") || cip.length() > MAX_LENGTH_CIP || cip.length() < 0) {
			throw new FilmException("The cip must have a size between 0 and 10,and cannot be empty");
		}else if(titleP == null || titleP.equals(" ") || titleP.length() > MAX_LENGTH_TITLE_P || titleP.length() < 0) {
			throw new FilmException("The main title must have a length between 0 and 45, and cannot be empty");
		}else if(yearProduction <= 1985 || yearProduction > LocalDate.now().getYear()) {
			throw new FilmException("You must enter a valid year on the release date");
		}else if(titleS == null || titleS.length() > MAX_LENGTH_TITLE_S || titleS.length() < 0) {
			throw new FilmException("The secondary"
					+ " title must have a length between 0 and 45");
		}else if(nationality == null || nationality.length() > MAX_LENGTH_NATIONALITY || nationality.length() < 0) {
			throw new FilmException("The nationality must have a length between 0 and 15");
		}else if(budget < 0) {
			throw new FilmException("The budget must be greater than 0");
		}else if(duration < 0) {
			throw new FilmException("The duration must be greater than 0");
		}
	}

	public String getCip() {
		return cip;
	}

	public void setCip(String cip) {
		this.cip = cip;
	}

	public String getTitleP() {
		return titleP;
	}

	public void setTitleP(String titleP) {
		this.titleP = titleP;
	}

	public int getYearProduction() {
		return productionYear;
	}

	public void setYearProduction(int yearProduction) {
		this.productionYear = yearProduction;
	}

	public String getTitleS() {
		return titleS;
	}

	public void setTitleS(String titleS) {
		this.titleS = titleS;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public int getBudget() {
		return budget;
	}

	public void setBudget(int budget) {
		this.budget = budget;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public List<Work> getCharacters() {
		return characters;
	}

	public void setCharacters(List<Work> characters) {
		this.characters = characters;
	}

	@Override
	public int hashCode() {
		return Objects.hash(cip);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Film other = (Film) obj;
		return Objects.equals(cip, other.cip);
	}

	@Override
	public String toString() {
		return "Film [cip=" + cip + ", titleP=" + titleP + ", productionYear=" + productionYear + ", titleS=" + titleS
				+ ", nationality=" + nationality + ", budget=" + budget + ", duration=" + duration + "]";
	}
	
}
