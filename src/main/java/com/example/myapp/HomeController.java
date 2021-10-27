package com.example.myapp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping(value = { "/", "/index" }) // GET요청을 받을때(서블릿과 유사)
	public String home() {

		System.out.println("home() 호출됨"); // 컨트롤러를 거치는지 확인을 위해 추가

		return "home"; // redirect 필요시 [return "redirect:/index";]
	} // home
	
}
