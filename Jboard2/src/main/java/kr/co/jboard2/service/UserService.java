package kr.co.jboard2.service;

import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.vo.TermsVO;
import kr.co.jboard2.vo.UserVO;

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
	public TermsVO selectTerms() {
		return dao.selectTerms();
	}
	public UserVO selectUser(String uid, String pass) {
		return dao.selectUser(uid, pass);
	}
	public UserVO selectUserForFindId(String name, String email) {
		return dao.selectUserForFindId(name, email);
	}
	public UserVO selectUserForFindPw(String uid, String email) {
		return dao.selectUserForFindPw(uid, email);
	}
	public UserVO selectUserBySessId(String sessId) {
		return dao.selectUserBySessId(sessId);
	}
	public int selectCountUser(String uid) {
		return dao.selectCountUser(uid);
	}
	public int selectCountNick(String nick) {
		return dao.selectCountNick(nick);
	}
	public void selectUsers() {}
	public int selectInfo(String uid, String pass) {
		return dao.selectInfo(uid, pass);
	}
	public void updateUser(UserVO vo) {
		dao.updateUser(vo);
	}
	public int updateUserPassword(String uid, String pass) {
		return dao.updateUserPassword(uid, pass);
	}
	public void updateUserForSession(String uid, String sessId) {
		dao.updateUserForSession(uid, sessId);
	}
	public void updateUserForSessLimitDate(String sessId) {
		dao.updateUserForSessLimitDate(sessId);
	}
	public void updateUserForSessionOut(String uid) {
		dao.updateUserForSessionOut(uid);
	}
	
	public int updateUserForExit(String uid) {
		return dao.updateUserForExit(uid);
	}
	public void deleteUser() {}
	
	public int[] sendEmailCode(String receiver) {
		
		// ???????????? ??????
		int code = ThreadLocalRandom.current().nextInt(100000, 1000000);
		
		// ????????????
		String sender = "coding0818@gmail.com";
		String password = "jfetfxwjnnbltwwx";
		
		String title = "Jboard2 ???????????? ?????????.";
		String content = "<h1>??????????????? "+code+" ?????????.</h1>";
		
		// Gmail SMTP ?????? ??????
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		
		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(sender, password);
			}
		});
		
		// ?????? ??????
		Message message = new MimeMessage(session);
		int status = 0;
		
		try {
			logger.debug("?????? ?????? ??????...");
			message.setFrom(new InternetAddress(sender, "?????????", "UTF-8"));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
			message.setSubject(title);
			message.setContent(content, "text/html;charset=utf-8");
			Transport.send(message);
			
			status = 1;
			
		}catch(Exception e) {
			e.printStackTrace();
			status = 0;
			logger.debug("?????? ?????? ??????...");
		}
		logger.debug("?????? ?????? ??????...");
		
		int result[] = {status, code};
		return result;
	}

	
}
