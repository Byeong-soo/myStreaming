package com.example.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.domain.TwitchStreamerVO;
import com.example.service.TwitchStreamerService;

@RestController
@RequestMapping("/Streamer/*")
public class StreamerRestController {
	
	@Autowired
	private TwitchStreamerService twitchStreamerService;
	
	

	
	@PostMapping(value = "/add", 
			produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<Map<String, Object>> addStreamer(@RequestBody TwitchStreamerVO twitchStreamerVO) {
		String msg = "";
		Map<String, Object> map = new HashMap<String, Object>();
		int count = twitchStreamerService.getCountbyName(twitchStreamerVO.getName());
		if(count == 0) {
			twitchStreamerService.addStramer(twitchStreamerVO);
		}
		else {
			msg ="등록된 스트리머";
			map.put("msg", msg);
			return new ResponseEntity<Map<String, Object>> (map, HttpStatus.OK);
		}
		
		msg = "스트리머 등록";
		map.put("msg", msg);
	
		
	
		return new ResponseEntity<Map<String, Object>> (map, HttpStatus.OK);
	}
	
	@GetMapping(value = "/{name}",
			produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public ResponseEntity<Map<String, Object>> searchStreamer(@PathVariable String name) {
		System.out.println("스트리머db 접근");
		String msg = "";
		
		List<String> streamerList = twitchStreamerService.searchStreamer(name);
		System.out.println(streamerList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("streamerList", streamerList);
		
		
		
		return new ResponseEntity<Map<String, Object>> (map, HttpStatus.OK);
	}
}
