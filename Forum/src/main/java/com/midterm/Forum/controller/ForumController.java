package com.midterm.Forum.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.session.Session;
import org.springframework.session.SessionRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.midterm.Forum.model.Message;
import com.midterm.Forum.model.Topic;
import com.midterm.Forum.model.User;
import com.midterm.Forum.service.ForumService;

import jakarta.servlet.http.HttpSession;

@Controller

public class ForumController {

	@Autowired
	ForumService forumService;

	@Autowired
	HttpSession httpSession;

//	@Autowired
//	private SessionRepository sessionRepository;

	@RequestMapping("/")
	public String home() {
		System.out.println("Going home...");
		return "index";
	}

	@GetMapping("/login")
	public String loginForm(Model model) {
		User user = new User();
		model.addAttribute("user", user);
		return "login";
	}

	@PostMapping("/login")
	public String loginSubmit(@ModelAttribute("user") User user, Model model) {
		User usr = forumService.checkUser(user.getUsername(), user.getPassword());
		StringBuilder message = new StringBuilder();

		if (usr != null) {
			httpSession.setAttribute("user", usr);
			message.append("Login successful!");
			return "redirect:/listTopics";
		}
		message.append("Login failed");
		model.addAttribute("message", message.toString());
		return "login";
	}

	@GetMapping("/logout")
	public String logout() {
		httpSession.invalidate();
		System.out.println(httpSession.getId());
		return "redirect:/listTopics";
	}

	@GetMapping("/listTopics")
	public String showListTopics(Model model) {
		Collection<Topic> topics = new ArrayList<>();
		forumService.getTopics().forEach(topics::add);
		model.addAttribute("topics", topics);
		return "listTopics";
	}
	
	@GetMapping("/showTopic")
	public String showTopic(@RequestParam Integer id, Model model) {
		Topic topic = forumService.findTopic(id);
		model.addAttribute("topic", topic);
		return "showTopic";
	}
	
	@GetMapping("/newTopic")
	public String newTopic(Model model) {
		return "newTopic";
	}
	
	@PostMapping("/newTopic")
	public String addNewTopic(@ModelAttribute Topic newTopic) {
		
		return "redirect:/listTopics";
	}
	
	@GetMapping("/replyTopic")
	public String replyForm(@RequestParam Integer id, Model model) {
		Topic topic = forumService.findTopic(id);
		Message mesage = topic.getNewMessage();
		model.addAttribute("message",mesage);
		return "replyTopic";
	}
	
	@PostMapping("/replyTopic")
	public String replyForm() {
		return "redirect:/showTopic";
	}
}
