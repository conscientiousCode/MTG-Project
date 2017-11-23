package datagen;
import java.util.ArrayList;
import java.util.Random;

public class GenSqlStatements {
	
	/**
	 * 
	 * @param numToGen number of insert statements to generate
	 * @param table the table that the insert statements will refer to
	 * @param columns the name of the columns to be inserted into, this order must match the order of the data sources
	 * @param dataSources the data used to generate the random values of the statement. The order of dataSources must match the order of columns
	 * @return an array of insert statements referencing table and columns and using dataSources to generate data
	 */
	public static String[] Insert(int numToGen, String table, String[] columns, String[]...dataSources){
		checkDataArgumentsAreCorrect(table, columns, dataSources);
		if(numToGen < 1){
			throw new IllegalArgumentException("The number of items to generate must be greater than 0");
		}
		ArrayList<String> generated = new ArrayList<String>(numToGen);
		Random gen = new Random();
		
		for(int i = 0; i < numToGen; i++){
			StringBuilder statement = new StringBuilder("INSERT INTO " + table);
			if(columns != null){
				statement.append(" (");
				for(int j = 0; j < columns.length -1; j++){
					statement.append(columns[j] + ", ");
				}
				statement.append(columns[columns.length-1] + ")");
			}
			statement.append(" VALUES (");
			for(int j = 0; j < dataSources.length-1; j++){
				statement.append(dataSources[j][gen.nextInt(dataSources[j].length)] + ", ");
			}
			statement.append(dataSources[dataSources.length-1][gen.nextInt(dataSources[dataSources.length-1].length)] + ");");
			
			generated.add(statement.toString());
		}
		return generated.toArray(new String[0]);
		
		
	}
	
	/*Simply checking the validity of the table arguments*/
	private static void checkDataArgumentsAreCorrect(String table, String[] columns, String[][] dataSources){
		if(table == null || table.length() == 0){
			throw new IllegalArgumentException("Invalid table name: null or empty");
		}
		if(columns != null && columns.length == 0){
			throw new IllegalArgumentException("Cannot specify columns and have the array be length == 0");
		}
		if(dataSources == null || dataSources.length == 0){
			throw new IllegalArgumentException("You must specify data sources");
		}
		if(columns != null){
			if(columns.length != dataSources.length){
				throw new IllegalArgumentException("Number of Columns must match number of data soruces");
			}
			for(String s : columns){
				if(s == null || s.length() == 0){
					throw new IllegalArgumentException("A specified column is nul or empty");
				}
			}
			
		}
		
		for(String[] aS: dataSources){
			if(aS == null || aS.length == 0){
				throw new IllegalArgumentException("A data source is null or empty");
			}
			for(String s : aS){
				if(s == null || s.length() == 0){
					throw new IllegalArgumentException("A particular piece of data from a dataSource is null or empty: source array = " + aS);
				}
			}
		}
		
	}

	public static void main(String[] args){
		int numToGen = 5;
		String table = "FakeTable";
		String[] columns = new String[]{"c1", "c2", "c3"};
		String[] d1 = new String[]{"x1","x2","x3", "x4", "x5"};
		String[] d2 = new String[]{"y1","y2","y3", "y4", "y5"};
		String[] d3 = new String[]{"z1","z2","z3", "z4", "z5"};
		
		String[] generated = GenSqlStatements.Insert(numToGen, table, null, d1,d2,d3);
		for(String s: generated){
			System.out.println(s);
		}
		
		generated = InsertSiteUsers(1,10);
		for(String s : generated){
			System.out.println(s);
		}
		
	}
	
	
	public static void InsertCustomers(){
		
	}
	
	/*Returns an array of length 2 with {email, password}
	 * */
	public static String[] InsertSiteUsers(int lower, int upper){
		String[] statements = new String[upper-lower+1];
		
		for(int i = lower; i<= upper; i++){
			String email = GenSqlStatements.fakeEmails(i);
			statements[i - lower] = "INSERT INTO SiteUser (email, password) VALUES (" + email + ", " + email + ");";
		}
		return statements;
		
		
	}
	
	private static String fakeEmails(int emailNumber){
		return "'fakeEmail"+emailNumber+"@hoxmail.com'";
	}
	
	
}
