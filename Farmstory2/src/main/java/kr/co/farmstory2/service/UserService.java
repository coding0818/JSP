package kr.co.farmstory2.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.dao.UserDAO;
import kr.co.farmstory2.vo.TermsVO;
import kr.co.farmstory2.vo.UserVO;

public enum UserService {

	INSTANCE;
	private UserDAO dao;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private UserService() {
		dao = new UserDAO();
	}
	
	public void insertUser(UserVO user) {
		dao.insertUser(user);
	}
	
	public UserVO selectUser(String uid, String pass) {
		return dao.selectUser(uid, pass);
	}
	
	public UserVO selectUserBySessId(String sessId) {
		return dao.selectUserBySessId(sessId);
	}
	
	public TermsVO selectTerms() {
		return dao.selectTerms();
	}
	
	public void updateUserForSession(String uid, String sessId) {
		dao.updateUserForSession(uid, sessId);
	}
	
	public void updateUserForSessLimitDate(String sessId) {
		dao.updateUserForSessLimitDate(sessId);
	}
}
