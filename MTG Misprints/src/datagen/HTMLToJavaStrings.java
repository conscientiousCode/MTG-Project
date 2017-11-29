package datagen;
import java.util.Scanner;

public class HTMLToJavaStrings {
	public static void main(String[] args){
		Scanner scanner = new Scanner(System.in);
		while(scanner.hasNextLine()){
			String scanned = scanner.nextLine();
			scanned.trim();
			System.out.print("+ \"");
			for(char c : scanned.toCharArray()){
				if(c == '"'){
					System.out.print("\\\"");
				}else{
					System.out.print(c);
				}
			}
			System.out.println("\"");
		}
		
	}
	
}
