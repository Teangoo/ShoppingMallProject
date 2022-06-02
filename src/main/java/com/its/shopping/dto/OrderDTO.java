package com.its.shopping.dto;

import lombok.Data;

@Data
public class OrderDTO {
    private Long order_Id;
    private Long product_Id;
    private Long id;
    private int orderNumber;
    private int orderPrice;
}
