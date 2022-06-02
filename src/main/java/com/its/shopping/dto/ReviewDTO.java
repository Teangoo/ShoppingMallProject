package com.its.shopping.dto;

import lombok.Data;

@Data
public class ReviewDTO {
    private Long review_Id;
    private Long product_Id;
    private String memberId;
    private String reviewContent;
}
