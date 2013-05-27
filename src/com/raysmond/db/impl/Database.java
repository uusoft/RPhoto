package com.raysmond.db.impl;

import java.sql.*;

public class Database {

	private final String dbName="je1024065";
	private final String dbUser="je1024065";
	private final String dbPass="213171";
	private final String dbHost="10.12.8.28";
	//private final String dbHost="127.0.0.1";
	private final String dbPort="3306";
	private Connection connect;
	
	public Database() throws ClassNotFoundException, SQLException{
		connect=null;
		Class.forName("com.mysql.jdbc.Driver");
		connect=DriverManager.getConnection("jdbc:mysql://"+dbHost+":"+dbPort+"/"+dbName, dbUser, dbPass);

	}
	
	public Connection getConnection(){
		return connect;
	}
	
	public void close() throws SQLException{
		connect.close();
	}
}
