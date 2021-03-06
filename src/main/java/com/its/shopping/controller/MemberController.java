package com.its.shopping.controller;

import com.its.shopping.dto.MemberDTO;
import com.its.shopping.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @GetMapping("/save")
    public String saveForm(){
        return "/member/save";
    }

    @PostMapping("duplicate-check")
    public @ResponseBody String duplicateCheck(@RequestParam("memberId") String memberId){
        MemberDTO memberDTO = memberService.duplicateCheck(memberId);
        if (memberDTO == null){
            return "ok";
        }else {
            return "no";
        }
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        int saveResult = memberService.save(memberDTO);
        if(saveResult>0){
            return "redirect:/member/login";
        }else{
            return "/member/login-fail";
        }
    }

    @GetMapping("/login")
    public String loginForm(){
        return "/member/login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO memberDTO, HttpSession session){
        MemberDTO loginResult = memberService.login(memberDTO);
        if(loginResult != null){
            session.setAttribute("loginId",loginResult.getId());
            session.setAttribute("loginMemberId",loginResult.getMemberId());
            return "/product/list";
        }else{
            return "redirect:/member/login";
        }
    }

    @PostMapping("/loginCheck")
    public @ResponseBody String loginCheck(@RequestParam String memberId , @RequestParam String memberPassword){
        Map<String, String> loginCheck = new HashMap<>();
        loginCheck.put("memberId",memberId);
        loginCheck.put("memberPassword",memberPassword);
        MemberDTO loginResult = memberService.loginCheck(loginCheck);
        if(loginResult != null){
            return "ok";
        }else{
            return "no";
        }
    }
    @GetMapping("logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "/index";
    }

    @GetMapping("/update")
    public String updateForm(HttpSession session , Model model){
        MemberDTO memberDTO = memberService.duplicateCheck((String) session.getAttribute("loginMemberId"));
        model.addAttribute("updateMember",memberDTO );
        return "/member/update";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute MemberDTO memberDTO) throws IOException {
        memberService.update(memberDTO);
        return "/index";
    }

    @GetMapping  ("/delete")
    public String delete(@RequestParam("id") Long id, HttpSession session){
        memberService.delete(id);
        session.invalidate();
        return "redirect:/";
    }

}
