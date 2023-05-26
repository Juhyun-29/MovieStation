package com.MovieStation.biz.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
	private String id;
	private String password;
	private String name;
	private String nickname;
	private String birthday;
	private String gender;
	private String mail;
	private String role;
}
