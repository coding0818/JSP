package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.User4VO;

public class User4DAO extends DBHelper{

	private static User4DAO instance = new User4DAO();
	public static User4DAO getInstance() {
		return instance;
	}
	private User4DAO() {}
	
	public void insertUser4(User4VO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("insert into `user4` values (?,?,?,?,?)");
			psmt.setInt(1, vo.getSeq());
			psmt.setString(2, vo.getName());
			psmt.setInt(3, vo.getGender());
			psmt.setInt(4, vo.getAge());
			psmt.setString(5, vo.getAddr());
			
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
		    e.printStackTrace();
		}
	}
	public User4VO selectUser4(String seq) {
		User4VO vo = null;
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("select * from `user4` where `seq`=?");
			psmt.setString(1, seq);
			rs = psmt.executeQuery();
			if(rs.next()) {
				vo = new User4VO();
				vo.setSeq(rs.getString(1));
				vo.setName(rs.getString(2));
				vo.setGender(rs.getString(3));
				vo.setAge(rs.getString(4));
				vo.setAddr(rs.getString(5));
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	public List<User4VO> selectUser4s() {
		List<User4VO> users = new ArrayList<>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from `user4`");
			while(rs.next()) {
				User4VO user = new User4VO();
				user.setSeq(rs.getString(1));
				user.setName(rs.getString(2));
				user.setGender(rs.getString(3));
				user.setAge(rs.getString(4));
				user.setAddr(rs.getString(5));
				
				users.add(user);
			}
			close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return users;
	}
	public void updateUser4(User4VO vo) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("update `user4` set `name`=?, `gender`=?, `age`=?, `addr`=? where `seq`=?");
			psmt.setString(1, vo.getName());
			psmt.setInt(2, vo.getGender());
			psmt.setInt(3, vo.getAge());
			psmt.setString(4, vo.getAddr());
			psmt.setInt(5, vo.getSeq());
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
		    e.printStackTrace();
		}
	}
	public void deleteUser4(String seq) {
	
		try {
			conn = getConnection();
			psmt = conn.prepareStatement("delete from `user4` where `seq`=?");
			psmt.setString(1, seq);
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
		    e.printStackTrace();
		}
	}
}
