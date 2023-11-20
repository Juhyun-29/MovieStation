package com.MovieStation.biz.user;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface UserMapper {
	
	@Select("SELECT * FROM MOVIEMEMBER WHERE ID=#{id}")
	String getUserId(String id);
	
	@Select("SELECT * FROM MOVIEMEMBER WHERE NICKNAME=#{nickname}")
	String getUserNick(String nickname);
	
	@Select("SELECT * FROM MOVIEMEMBER WHERE MAIL=#{mail}")
	String getUserMail(String mail);

	@Insert("INSERT INTO MOVIEMEMBER(ID, PASSWORD, NAME, NICKNAME, BIRTHDAY, GENDER, MAIL) VALUES(#{id}, #{password}, #{name}, #{nickname}, #{birthday}, #{gender}, #{mail})")
	void insertUser(User user);

	@Update("UPDATE MOVIEMEMBER SET PASSWORD=#{password}, NICKNAME=#{nickname}, MAIL=#{mail} WHERE ID=#{id}")
	void updateUser(User user);

	@Delete("DELETE MOVIEMEMBER WHERE ID=#{id} AND PASSWORD=#{password}")
	void deleteUser(User user);

	@Select("SELECT * FROM MOVIEMEMBER WHERE ID=#{id} AND PASSWORD=#{password}")
	User getUser(User user);

}