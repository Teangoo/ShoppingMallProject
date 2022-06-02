package com.its.shopping.repository;

import com.its.shopping.dto.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepository {
    @Autowired
    private SqlSessionTemplate sql;


    public MemberDTO duplicateCheck(String memberId) {
        return sql.selectOne("Member.duplicateCheck",memberId);
    }

    public int save(MemberDTO memberDTO) {
        return sql.insert("Member.save",memberDTO);
    }
}
