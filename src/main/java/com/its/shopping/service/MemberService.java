package com.its.shopping.service;

import com.its.shopping.dto.MemberDTO;
import com.its.shopping.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@Service
public class MemberService {
    @Autowired
    private MemberRepository memberRepository;

    public MemberDTO duplicateCheck(String memberId) {
        return memberRepository.duplicateCheck(memberId);
    }

    public int save(MemberDTO memberDTO) throws IOException {
        MultipartFile memberProfile = memberDTO.getMemberProfile();
        String memberProfileName = memberProfile.getOriginalFilename();
        memberProfileName = System.currentTimeMillis() + "-" + memberProfileName;
        memberDTO.setMemberProfileName(memberProfileName);
        String savePath = "/Users/taeyeonlee/member_img//" + memberProfileName;
        if (!memberProfile.isEmpty()) {
            memberProfile.transferTo(new File(savePath));
        }
        return memberRepository.save(memberDTO);
    }
}
