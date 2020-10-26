package com.atguigu.scw.test;

import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.wtils.MD5Util;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/spring-beans.xml",
        "classpath:spring/spring-mybatis.xml","classpath:spring/spring-tx.xml"})

public class MapperTest {

    @Autowired
    TAdminMapper adminMapper;

    @Test
    public void test1(){
        long count = adminMapper.countByExample(null);
        System.out.println("count = " + count);
        System.out.println(MD5Util.digest("1"));
    }
}
