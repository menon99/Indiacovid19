package utils;

public class StringFormatter {
	public static String capitalizeWord(String str){  
	    String words[]=str.split("\\s");  
	    String capitalizeWord="";  
	    for(String w:words){
	    	if(w.equalsIgnoreCase("and")) {
	    		capitalizeWord += "and ";
	    		continue;
	    	}
	        String first=w.substring(0,1);  
	        String afterfirst=w.substring(1);  
	        capitalizeWord+=first.toUpperCase()+afterfirst+" ";  
	    }  
	    return capitalizeWord.trim();  
	}  
}
