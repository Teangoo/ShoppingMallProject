package com.its.shopping.service;

import com.its.shopping.dto.CartDTO;
import com.its.shopping.dto.ProductDTO;
import com.its.shopping.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class CartService {
    @Autowired
    private CartRepository cartRepository;
    public int save(Long product_id, int productPrice,String productName, Long loginId) {
        CartDTO cartDTO = new CartDTO();
        cartDTO.setProduct_Id(product_id);
        cartDTO.setId(loginId);
        cartDTO.setPrice(productPrice);
        cartDTO.setProductName(productName);
        return cartRepository.save(cartDTO);
    }

    public List<CartDTO> findById(Long loginId) {
        return cartRepository.findById(loginId);
    }

    public List<ProductDTO> findByProductId(Long loginId) {
        return cartRepository.findByProductId(loginId);
    }

    public int update(int cartProductNum, Long cart_id,int productPrice,Long loginId) {
        Map<String,Object> updateParam = new HashMap<>();
        updateParam.put("cart_Id",cart_id);
        updateParam.put("cartProductNum",cartProductNum);
        updateParam.put("loginId",loginId);
        updateParam.put("price",productPrice);
        return cartRepository.update(updateParam);
    }


    public CartDTO findByCheck(Long product_id, Long loginId) {
        Map<String,Long> CheckParam = new HashMap<>();
        CheckParam.put("loginId",loginId);
        CheckParam.put("product_Id",product_id);
        return cartRepository.findByCheck(CheckParam);
    }

    public int delete(Long cart_id) {
        return cartRepository.delete(cart_id);
    }

    public List<CartDTO> orderCheck(List<Long> cart_id) {

        return cartRepository.orderCheck(cart_id);
    }

    public void orderCartDelete(List<Long> cart_id) {
        cartRepository.orderCartDelete(cart_id);
    }
}
