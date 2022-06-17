package com.its.shopping.repository;

import com.its.shopping.dto.CategoryDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CategoryRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public List<CategoryDTO> findAll() {
        return sql.selectList("Category.findAll");
    }

    public void save(CategoryDTO categoryDTO) {
        sql.insert("Category.save",categoryDTO);
    }

    public int delete(Long category_id) {
        return sql.delete("Category.delete",category_id);
    }

    public CategoryDTO findById(Long category_id) {
        return sql.selectOne("Category.findById",category_id);
    }
}
