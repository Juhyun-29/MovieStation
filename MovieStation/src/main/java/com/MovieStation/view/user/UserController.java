package com.MovieStation.view.user;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.MovieStation.biz.user.User;
import com.MovieStation.biz.user.UserMailService;
import com.MovieStation.biz.user.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class UserController {
	
	private final UserService userService;
	private final UserMailService userMailService;
	
	@PostMapping("/idCheck")
	public String getUserId(String id) {
		System.out.println("아이디 중복 확인");
		String number;
		if(userService.getUserId(id)!=null) {
			System.out.println("아이디 중복");
			number="1";
		}else {
			System.out.println("아이디 사용 가능");
			number="0";
		}
		return number;
	}
	
	@PostMapping("/nickCheck")
	public String getUserNick(String nickname) {
		System.out.println("닉네임 중복 확인");
		String number;
		if(userService.getUserNick(nickname)!=null) {
			System.out.println("닉네임 중복");
			number="1";
		}else {
			System.out.println("닉네임 사용 가능");
			number="0";
		}
		return number;
	}
	
	@PostMapping("/mailCheck")
	public String getUserMail(String mail) {
		System.out.println("메일 중복 확인");
		String number;
		if(userService.getUserMail(mail)!=null) {
			System.out.println("메일 중복");
			number="1";
		}else {
			System.out.println("메일 사용 가능");
			number="0";
		}
		return number;
	}
	
	@PostMapping("/mail")
	public String mailSend(String mail) {
		System.out.println("인증 메일 발송");
		int number=userMailService.sendMail(mail);
		String num=""+number;

		return num;
	}

	@GetMapping("/index")
	public ModelAndView index(ModelAndView mav) {
		System.out.println("메인 페이지 이동");
		mav.setViewName("index");
		return mav;
	}
	
	@GetMapping("/insertUser")
	public ModelAndView insertUser(ModelAndView mav) {
		System.out.println("insertUser 페이지 이동");
		mav.setViewName("insertUser");
		return mav;
	}
	
	@PostMapping("/insertUser")
	public ModelAndView insertUser(User user, ModelAndView mav) {
		System.out.println("insertUser 실행");
		
		
		userService.insertUser(user);
		mav.setViewName("redirect:index");
		return mav;
	}
	
	
	@GetMapping("/login")
	public ModelAndView login(ModelAndView mav) {
		System.out.println("login 페이지 이동");
		mav.setViewName("login");
		return mav;
	}
	
	@PostMapping("/login")
	public ModelAndView login(User user, HttpSession session,ModelAndView mav) {
		System.out.println("login 실행");
		
		if(userService.getUser(user)!=null) {
			System.out.println("로그인 처리");
			session.setAttribute("id", userService.getUser(user).getId());
			session.setAttribute("name", userService.getUser(user).getName());
			session.setAttribute("nickname", userService.getUser(user).getNickname());
			session.setAttribute("role", userService.getUser(user).getRole());
			mav.setViewName("redirect:index");
		}else {
			mav.addObject("msg", "비밀번호를 잘못 입력했거나 없는 아이디입니다.");
			mav.setViewName("login");
		}
		return mav;
	}
	
	@GetMapping("/logout")
	   public ModelAndView logout(HttpSession session, ModelAndView mav) {
		   System.out.println("logout 실행");
		   System.out.println("로그아웃 처리");
		   
		   session.invalidate();
		   mav.setViewName("index");
		   return mav;
	   }
	
}
