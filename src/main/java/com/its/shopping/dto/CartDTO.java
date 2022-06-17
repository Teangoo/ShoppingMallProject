package com.its.shopping.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class CartDTO {
    private Long cart_Id;
    private Long id;
    private Long product_Id;
    private String productName;
    private int cartProductNum;
    private int price;
    private Timestamp cartDateTime;
}
