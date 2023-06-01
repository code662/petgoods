package dao;

import util.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AddressDao {
	// 최근 배송지 조회
	public ArrayList<Address> selectLastAddress(String id) throws Exception {
		// 반환할 ArrayList<Address> 생성
		ArrayList<Address> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT address_no addressNo, id, address, max(address_last_date) addressLastDate, createdate, updatedate FROM address WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Address address = new Address();
			address.setAddressNo(rs.getInt("addressNo"));
			address.setId(rs.getString("id"));
			address.setAddress(rs.getString("address"));
			address.setAddressLastDate(rs.getString("addressLastDate"));
			address.setCreatedate(rs.getString("createdate"));
			address.setUpdatedate(rs.getString("updatedate"));
			list.add(address);	
		}
		
		return list;
	}
	// 배송지 조회
	public ArrayList<Address> selectAddress(String id) throws Exception {
		// 반환할 ArrayList<Address> 생성
		ArrayList<Address> list = new ArrayList<>();
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "SELECT address_no addressNo, id, address, address_last_date addressLastDate, createdate, updatedate FROM address WHERE id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Address address = new Address();
			address.setAddressNo(rs.getInt("addressNo"));
			address.setId(rs.getString("id"));
			address.setAddress(rs.getString("address"));
			address.setAddressLastDate(rs.getString("addressLastDate"));
			address.setCreatedate(rs.getString("createdate"));
			address.setUpdatedate(rs.getString("updatedate"));
			list.add(address);	
		}
		
		return list;
	}
	
	// 배송지 추가
	public int addAddress(Address address) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "INSERT INTO address(id, address, address_last_date, createdate, updatedate) VALUES(?,?,NOW(),NOW(),NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, address.getId());
		stmt.setString(2, address.getAddress());

		row = stmt.executeUpdate();
		
		return row;
	}	
	// 배송지 수정
	public int modifyAddress(Address address) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE address SET address = ?, address_last_date = NOW(), updatedate = NOW() WHERE address_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, address.getAddress());
		stmt.setInt(2, address.getAddressNo());
		row = stmt.executeUpdate();
		
		return row;
	}	
	// 배송지 삭제
	public int removeAddress(int addressNo) throws Exception {
		// sql 실행시 영향받은 행의 수 
		int row = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 영향받은 행의 수 반환받아 저장
		String sql ="DELETE FROM address WHERE address_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, addressNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	// 상품 주문 시 사용된 배송지의 address_last_date 수정
	public int modifyAddressLastDate(int addressNo) throws Exception {
		// 반환할 성공여부 변수 생성
		int row = 0;
		// DB 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 결과셋 반환받아 리스트에 저장
		String sql = "UPDATE address SET address_last_date = NOW(), updatedate = NOW() WHERE address_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, addressNo);
		row = stmt.executeUpdate();
		
		return row;
	}	
}
