package com.hnu.highlynewapp.transformation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.vo.FindEvaluationCaseVo;
import com.hnu.highlynewapp.utils.PageUtils;

import java.util.Map;

/**
 * 评估案例扩展
 */
public interface EvaluationCaseVoService extends IService<FindEvaluationCaseVo> {
    PageUtils queryPage(Map<String, Object> params);
}
