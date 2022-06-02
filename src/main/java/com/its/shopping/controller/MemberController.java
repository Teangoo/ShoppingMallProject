package com.its.shopping.controller;

import com.its.shopping.dto.MemberDTO;
import com.its.shopping.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

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
}
