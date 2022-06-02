package com.its.shopping.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class ProductDetailFileDTO {
    private Long detail_File_Id;
    private Long product_Id;
    private Long detail_Id;
    private MultipartFile detailFile;
    private String detailFileName;
}
