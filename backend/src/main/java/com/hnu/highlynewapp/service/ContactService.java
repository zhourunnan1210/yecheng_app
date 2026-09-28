package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.ContactEntity;

import java.util.Map;

/**
 * 联系人
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:55
 */
public interface ContactService extends IService<ContactEntity> {
    PageUtils queryPage(Map<String, Object> params);

    Long saveAndCheckExist(ContactEntity contactEntity);

    ContactEntity getByContactId(Long contactId);
}
