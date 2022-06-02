package com.its.shopping.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class MemberDTO {
    private Long id;
    private String memberId;
    private String memberPassword;
    private String memberName;
    private String memberMobile;
    private MultipartFile memberProfile;
    private String memberProfileName;
    private String memberAddress;
}
