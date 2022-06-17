package com.its.shopping.controller;

import com.its.shopping.dto.CategoryDTO;
import com.its.shopping.dto.MemberDTO;
import com.its.shopping.service.CategoryService;
import com.its.shopping.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private MemberService memberService;
    @Autowired
    private CategoryService categoryService;

    @GetMapping("/admin")
    public String admin() {
        return "/admin/admin";
    }

    @GetMapping("/memberList")
    public @ResponseBody List<MemberDTO> memberList(){
        List<MemberDTO> memberDTOList = memberService.findAll();
        return memberDTOList;
    }

    @PostMapping("/delete")
    public ResponseEntity delete(@RequestParam("id") Long id){
        int result = memberService.delete(id);
        return new ResponseEntity(result, HttpStatus.OK);
    }

    @GetMapping("/categoryList")
    public @ResponseBody List<CategoryDTO> categoryList(){
        List<CategoryDTO> categoryDTOList = categoryService.findAll();
        return categoryDTOList;
    }

    @PostMapping("/categorySave")
    public @ResponseBody List<CategoryDTO> save(@ModelAttribute CategoryDTO categoryDTO){
        categoryService.save(categoryDTO);
        List<CategoryDTO> categoryDTOList = categoryService.findAll();
        return categoryDTOList;
    }

    @PostMapping("/CGDelete")
    public ResponseEntity CGDelete(@RequestParam("category_id") Long category_id){
        int result = categoryService.delete(category_id);
        return new ResponseEntity(result,HttpStatus.OK);
    }

}
