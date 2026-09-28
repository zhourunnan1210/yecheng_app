package com.hnu.highlynewapp.service;

import com.hnu.highlynewapp.entity.PolicyEntity;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @author zhourunnan
 * @Date 2021/9/26 13:20
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
public class PolicyServiceTest {

    @Autowired
    PolicyService policyService;

    @Test
    public void testListByCategory() {
        List<PolicyEntity> policyEntities = policyService.listByCategory("高企认定指南");
        System.out.println(policyEntities);

    }
}
