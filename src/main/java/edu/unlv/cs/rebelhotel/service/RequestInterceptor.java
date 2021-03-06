package edu.unlv.cs.rebelhotel.service;

import java.util.Collection;
import java.util.List;

import javax.persistence.TypedQuery;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import edu.unlv.cs.rebelhotel.domain.Student;
import edu.unlv.cs.rebelhotel.domain.UserAccount;
import edu.unlv.cs.rebelhotel.domain.enums.UserGroup;

public class RequestInterceptor extends HandlerInterceptorAdapter {
	private Logger logger = Logger.getLogger(RequestInterceptor.class.getName());
	
	@Autowired
	UserInformation userInformation;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("preHandle - begin");
		if (userInformation.getStudent() == null) {
			if (SecurityContextHolder.getContext().getAuthentication() != null) {
				logger.info("preHandle - The session held no student");
				Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				String username;
				if (principal instanceof UserDetails) {
					username = ((UserDetails) principal).getUsername();
				}
				else {
					username = principal.toString();
				}
				Collection<GrantedAuthority> authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
				List<UserAccount> resultList = UserAccount.findUserAccountsByUserId(username).getResultList();
				UserAccount account = null;
				if(!resultList.isEmpty()){
					account = resultList.get(0);
					userInformation.setUserAccount(account);
				}
				if (authorities.contains(UserGroup.ROLE_STUDENT)) {
					// All students should have the ROLE_STUDENT role and should also have usernames consisting of 10  digit numbers
					try {
						Student student = Student.findStudentsByUserAccount(account).getSingleResult();
						userInformation.setStudent(student);
					}
					catch (org.springframework.dao.EmptyResultDataAccessException exception) {
						logger.info("preHandle - A ROLE_STUDENT UserAccount logged in, but no corresponding Student was found!");
					}
				}
			}
			else {
				logger.info("preHandle - SecurityContextHolder.getContext).getAuthentication() was null!");
			}
		}
		else {
			logger.info("preHandle - The session student was set already; nothing to do");
		}
		logger.info("preHandle - end");
		
		return true;
	}
}