package com.example.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Integer num; // 게시글 번호
	private String mid; // 작성자 아이디
	private String subject; // 게시글 제목
	private String content; // 게시글 내용
	private Integer readcount; // 게시글 조회수
	private Date regDate; // 게시글 작성날짜
	
	// 댓글용
	private Integer reRef;
	private Integer reLev;
	private Integer reSeq;
	
}
