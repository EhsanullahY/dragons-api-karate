package api.dataprovider;

public class DataProvider {
	
	public  static String getApiEmail() {
		String textPart = "ehsaa";
		String domaPart = "@gmail.com";
		int numPart = (int) (Math.random()*2000);
		String autoEmail = textPart + numPart + domaPart;
		return autoEmail;
	}
	
	public static String getPhoneNum() {
		String phoneNO = "9";
		for(int i=0; i < 9; i++) {
			phoneNO += (int) (Math.random()*10);
		}
		return phoneNO;
	}

}
