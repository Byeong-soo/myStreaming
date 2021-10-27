package com.example.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String id; // 아이디
	private String passwd; // 비밀번호
	private String name; // 이름
	private String nickname; // 별명(당장은 게시글에 사용할 예정)
	private String birthday; // 생일
	private String gender; // 성별
	private String email; // 이메일
	// String recv_email; // 이메일 수신여부 (딱히 필요성을 못느껴서 일단 보류)
}
