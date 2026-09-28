package com.hnu.highlynewapp.transformation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.transformation.pojo.Expert;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * 专家
 */
@Mapper
@Repository
public interface ExpertMapper extends BaseMapper<Expert> {
}
