package datagen;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

public class ConvertJASON {

	public static void main(String[] args){
		
	}
	public static void convertNamesToCard(File input, File output){
		String delimiter = ": {";
		
		try{
			output.createNewFile();
		}catch(IOException e){
			System.err.println(e);
			return;
		}
		
		try(Scanner scanner = new Scanner(input)){

			
			
			
		}catch(FileNotFoundException e){
			System.err.println("FILE NOT FOUND: " + input);
		}
	}
	
}
