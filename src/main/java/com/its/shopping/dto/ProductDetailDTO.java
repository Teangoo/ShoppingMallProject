package com.its.shopping.dto;

import lombok.Data;

@Data
public class ProductDetailDTO {
    private Long detail_Id;
    private Long product_Id;
    private String detailExplanation;
}
