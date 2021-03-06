package com.example.domain;

import java.util.Date;

import lombok.Data;

import java.util.Date;

@Data
public class MemberVO {
	private String id; // 아이디
	private String passwd; // 비밀번호
	private String name; // 이름
	private String nickname; // 별명(당장은 게시글에 사용할 예정)
	private String birthday; // 생일
	private String gender; // 성별
	private String email; // 이메일
	private String recvEmail; // 이메일 수신여부 (보류)
	private Date regDate;
	
	private ProfilepicVO profilepicVO;
}
