package com.hnu.highlynewapp.transformation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.ExpertMapper;
import com.hnu.highlynewapp.transformation.pojo.Expert;
import com.hnu.highlynewapp.transformation.service.ExpertService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Map;

@Service("expertService")
public class ExpertServiceImpl extends ServiceImpl<ExpertMapper, Expert> implements ExpertService {
    @Autowired
    private ExpertMapper expertMapper;

    /**
     * 分页查询专家
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<Expert> page = this.page(
                new Query<Expert>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(page);
    }

    /**
     * 根据专家id查找专家的信息
     *
     * @param expertId
     * @return
     */
    @Override
    public Expert findOneByExpertId(Long expertId) {
        return expertMapper.selectById(expertId);
    }

    /**
     * 根据多个专家id删除多个专家
     *
     * @param expertIds
     * @return
     */
    @Override
    public int deleteExpertsByIds(Long[] expertIds) {
        return expertMapper.deleteBatchIds(Arrays.asList(expertIds));
    }
}
