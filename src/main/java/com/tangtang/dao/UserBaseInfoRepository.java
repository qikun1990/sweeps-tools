package com.tangtang.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tangtang.po.UserBaseInfo;

@Repository
public interface UserBaseInfoRepository extends JpaRepository<UserBaseInfo, String> {

}
