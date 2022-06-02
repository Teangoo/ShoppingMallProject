package com.its.shopping.dto;

import lombok.Data;

@Data
public class CartDTO {
    private Long cart_Id;
    private Long id;
    private Long product_Id;
    private int cartProductNum;
}
