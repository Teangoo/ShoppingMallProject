package com.its.shopping.repository;

import com.its.shopping.dto.CartDTO;
import com.its.shopping.dto.ProductDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class CartRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public int save(CartDTO cartDTO) {
        return sql.insert("Cart.save",cartDTO);
    }

    public List<CartDTO> findById(Long loginId) {
        return sql.selectList("Cart.findById",loginId);
    }

    public List<ProductDTO> findByProductId(Long loginId) {
        return sql.selectList("Cart.findByProductId",loginId);
    }

    public int update(Map<String, Object> updateParam) {
        return sql.update("Cart.update",updateParam);
    }

    public CartDTO findByCheck(Map<String, Long> checkParam) {
        return sql.selectOne("Cart.Check",checkParam);
    }

    public int delete(Long cart_id) {
        return sql.delete("Cart.delete",cart_id);
    }

    public List<CartDTO> orderCheck(List<Long> cart_id) {
        return sql.selectList("Cart.orderCheck",cart_id);
    }

    public void orderCartDelete(List<Long> cart_id) {
        sql.delete("Cart.orderCartDelete",cart_id);
    }
}
