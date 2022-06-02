package com.its.shopping.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class ProductDTO {
    private Long product_Id;
    private Long category_Id;
    private String productName;
    private int productPrice;
    private int productQuantity;
    private MultipartFile productFile;
    private String productFileName;
}
