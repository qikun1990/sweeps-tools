package com.tangtang.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tangtang.po.UserAdInfo;

@Repository
public interface UserAdInfoRepository extends JpaRepository<UserAdInfo, Integer> {

}
