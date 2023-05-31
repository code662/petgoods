package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3307/petgoods", "root", "java1234");
		return conn;
	}
}