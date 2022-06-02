package com.its.shopping.repository;

import com.its.shopping.dto.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

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

    public MemberDTO login(MemberDTO memberDTO) {
        return sql.selectOne("Member.login",memberDTO);
    }

    public MemberDTO loginCheck(Map<String, String> loginCheck) {
        return sql.selectOne("Member.loginCheck",loginCheck);
    }
}
