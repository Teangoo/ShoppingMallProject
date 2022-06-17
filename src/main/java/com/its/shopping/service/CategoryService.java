package com.its.shopping.service;

import com.its.shopping.dto.CategoryDTO;
import com.its.shopping.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    public List<CategoryDTO> findAll() {
        return categoryRepository.findAll();
    }

    public void save(CategoryDTO categoryDTO) {
        categoryRepository.save(categoryDTO);
    }

    public int delete(Long category_id) {
        return categoryRepository.delete(category_id);
    }

    public CategoryDTO findById(Long category_id) {
        return categoryRepository.findById(category_id);
    }
}
