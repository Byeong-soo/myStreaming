package com.example.domain;

import lombok.Data;

@Data
public class BookmarkVO {
	
	private String mid; // 북마크 작성자 아이디
	private String name; // 북마크명
	private String type; // 일단 Youtube는 'Y', 아프리카TV는 'A', 트위치는 'T'로 받아올 예정
	private String url; // 북마크 url주소
	
}