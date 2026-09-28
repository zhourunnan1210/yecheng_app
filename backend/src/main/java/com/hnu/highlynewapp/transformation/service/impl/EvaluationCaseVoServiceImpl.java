package com.hnu.highlynewapp.transformation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.EvaluationCaseVoMapper;
import com.hnu.highlynewapp.transformation.service.EvaluationCaseVoService;
import com.hnu.highlynewapp.transformation.vo.FindEvaluationCaseVo;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service("evaluationCaseVo")
public class EvaluationCaseVoServiceImpl extends ServiceImpl<EvaluationCaseVoMapper, FindEvaluationCaseVo> implements EvaluationCaseVoService {
    @Autowired
    private EvaluationCaseVoMapper evaluationCaseVoMapper;

    /**
     * 查询分页
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<FindEvaluationCaseVo> page = this.page(
                new Query<FindEvaluationCaseVo>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(evaluationCaseVoMapper.findAllPages(page));
    }
}
