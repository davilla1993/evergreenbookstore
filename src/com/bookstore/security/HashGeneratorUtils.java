package com.bookstore.security;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashGeneratorUtils {

	public HashGeneratorUtils() {
		super();
	
	}
	
	public static String generateSHA256(String data) throws HashGenerationException {
		return hashString(data, "SHA-256");
		
	}
	
	private static String hashString(String data, String algorithm) throws HashGenerationException {
		
		try {
			
			MessageDigest digest = MessageDigest.getInstance(algorithm);
			
			byte[] hashedBytes = digest.digest(data.getBytes("UTF-8"));
				
				return convertByteArrayToHexString(hashedBytes);
				
			} catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
				
				throw new HashGenerationException(
						
					"Could not generate hash from String", ex);
			}
	}
	
	
	private static String convertByteArrayToHexString(byte[] arrayBytes) {
			
			StringBuffer stringBuffer = new StringBuffer();
			
			for(int i = 0; i < arrayBytes.length; i++) {
				
				stringBuffer.append(Integer.toString((arrayBytes[i] & 0xff) + 0x100, 16).substring(1));
			}
			
			return stringBuffer.toString();
		}
	
}
