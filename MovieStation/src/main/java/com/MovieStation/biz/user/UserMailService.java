package com.MovieStation.biz.user;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserMailService {
	
	// JavaMailSender 호출
	private final JavaMailSender javaMailSender;
	// 보내는 메일 주소 설정
	private static final String senderEmail="2023moviestation@gmail.com";
	// 인증번호 변수 선언
	private static int number;
	
	// 인증번호 생성
	public static void createNumber(){
		number = (int)(Math.random() * (90000)) + 100000;
		// (int) Math.random() * (최댓값-최소값+1) + 최소값
	}
	
	// 메일 생성
	public MimeMessage CreateMail(String mail) {
		// 인증번호 생성
		createNumber();
		// 메일 내용 생성
		MimeMessage message=javaMailSender.createMimeMessage();
		
		try {
			message.setFrom(senderEmail); // 보내는 사람
			message.setRecipients(MimeMessage.RecipientType.TO, mail); // 받는 사람
			message.setSubject("이메일 인증"); // 메일 제목
			String body = "";
			body += "<h3>" + "요청하신 인증 번호입니다." + "</h3>";
            body += "<h1>" + number + "</h1>";
            body += "<h3>" + "감사합니다." + "</h3>";
            message.setText(body, "UTF-8", "html"); // 보내는 텍스트 설정(내용, charset, 형식)
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return message;
	}
	
	// 메일 전송
	public int sendMail(String mail) {
		MimeMessage message=CreateMail(mail); // 생성된 메일
		javaMailSender.send(message); // 메일 전송
		return number;
	}
}
