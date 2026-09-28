package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.ConsultationEntity;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.vo.ConsultationResVo;
import com.hnu.highlynewapp.vo.PublishConsultationVo;
import com.hnu.highlynewapp.vo.ReplyVo;

import java.util.List;
import java.util.Map;

/**
 * 咨询
 *
 * @author zhourunnan
 * @email 13513595808@163.com
 * @date 2021-04-08 20:12:22
 */
public interface ConsultationService extends IService<ConsultationEntity> {

    PageUtils queryPage(Map<String, Object> params);

    void publish(PublishConsultationVo vo);

    List<ConsultationResVo> listCombine(String type);

    List<ConsultationResVo> listByUserId(Long userId);

    void reply(ReplyVo vo);
}

