package com.jacaranda.model;

import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import com.jacaranda.exception.CharacterException;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table (name = "Personaje")
public class Character {

	/* ================= ATTRIBUTES ================= */
	@Id 
	@Column(name = "nombre_persona", unique = true, nullable = false)
	private String characterName;
	
	@Column (name = "nacionalidad_persona")
	private String characterNationality;
	
	@Column (name = "sexo_persona")
	private String characterSex;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "character")
	private List<Work>films;
	
	
	private final static List<String> CHARACTER_SEX_VALID_CHARACTERS = Arrays.asList("H","M","O");
	private final static int CHARACTER_NAME_MAXIMUM_LENGTH = 25;
	private final static int CHARACTER_NATIONALITY_MAXIMUM_LENGTH = 15;

	
	
	
	
	/* ================= CONSTRUCTORS ================= */
	
	//1º constructor
	public Character() {}
	
	
	//2º constructor with attributes
	public Character(String characterName, String characterNationality, String characterSex) throws CharacterException {
				
		if ((characterName != null) && (!characterName.isEmpty()) && (characterNationality != null)
				&& (!characterNationality.isEmpty()) && (characterSex != null) 
				&& (!characterSex.isEmpty()) && (isCharacterSexValid(characterSex) == true)) {
			
			if ((characterName.length() <= CHARACTER_NAME_MAXIMUM_LENGTH) 
					&& (characterNationality.length() <= CHARACTER_NATIONALITY_MAXIMUM_LENGTH)) {
				
				characterSex = characterSex.toUpperCase();
				
				this.characterName = characterName;
				this.characterNationality = characterNationality;
				this.characterSex = characterSex;
			
				
			}else if (characterName.length() > CHARACTER_NAME_MAXIMUM_LENGTH) {
				throw new CharacterException ("The character's name has more than 25 characters.");
				
				
			}else if (characterNationality.length() > CHARACTER_NATIONALITY_MAXIMUM_LENGTH) {
				throw new CharacterException ("The character's nationality has more than 15 characters.");	
			}
		
		
		}else if ((characterName == null) || (characterName.isEmpty())) {
			throw new CharacterException ("The character's name field is empty or its value is null.");
		
		
		}else if ((characterNationality == null) || (characterNationality.isEmpty())) {
			throw new CharacterException ("The character's nationality field is empty or its value is null.");
		
		
		}else if ((characterSex == null) || (characterSex.isEmpty())) {
			throw new CharacterException ("The character's sex field is empty or its value is null.");
		
		
		}else if ((!characterSex.isEmpty()) && (characterSex.trim().length() != 1)) {
			throw new CharacterException ("The character's sex field doesn't have a character.");
		
		
		}else if ((!characterSex.trim().equals("H")) || (!characterSex.trim().equals("M"))
					|| (!characterSex.trim().toUpperCase().equals("O"))) {
			throw new CharacterException ("The character's sex field doesn't have a valid character.");
		
		}
	}
	
	
	
	/* ====================== METHODS ====================== */
	/**
	 * Method to validate if a character is valid for the 
	 * "characterSex" class attribute. If the String is not 1 in length, or it's null, 
	 * or it's empty, it will return a boolean with the value false.
	 * <br> <br>
	 * It uses the constant variable "CHARACTER_SEX_VALID_CHARACTERS" to work with.
	 * 
	 * @param characterSex
	 * @return
	 */
	public boolean isCharacterSexValid (String characterSex) {
		return CHARACTER_SEX_VALID_CHARACTERS.contains(characterSex.toUpperCase());
	}

	
	
	
	/* ================= GETTERS / SETTERS ================= */
	public String getCharacterName() {
		return characterName;
	}


	public void setCharacterName(String characterName) {
		this.characterName = characterName;
	}


	public String getCharacterNationality() {
		return characterNationality;
	}


	public void setCharacterNationality(String characterNationality) {
		this.characterNationality = characterNationality;
	}


	public String getCharacterSex() {
		return characterSex;
	}


	public void setCharacterSex(String characterSex) {
		this.characterSex = characterSex;
	}

	public List<Work> getFilms() {
		return films;
	}


	public void setFilms(List<Work> films) {
		this.films = films;
	}

	/* ================= HASH CODE / EQUALS ================= */
	@Override
	public int hashCode() {
		return Objects.hash(characterName);
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Character other = (Character) obj;
		return Objects.equals(characterName, other.characterName);
	}


	
	
	/* ================= TO STRING() ================= */
	@Override
	public String toString() {
		return "Character [characterName=" + characterName + ", characterNationality=" + characterNationality
				+ ", characterSex=" + characterSex + "]";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
