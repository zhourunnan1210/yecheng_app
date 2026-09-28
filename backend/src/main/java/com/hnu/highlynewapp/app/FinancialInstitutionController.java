package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.config.WatermarkConfig;
import com.hnu.highlynewapp.entity.FinancialInstitutionEntity;
import com.hnu.highlynewapp.entity.InvestingNeedEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.FinancialInstitutionService;
import com.hnu.highlynewapp.service.InvestingNeedService;
import com.hnu.highlynewapp.utils.ImgSteganoUtil;
import com.hnu.highlynewapp.utils.OssUtil;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.utils.ValidationUtils;
import com.hnu.highlynewapp.vo.PublishFinancialInstitutionVo;
import io.swagger.annotations.*;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author LengKuBaiCai
 * @Date
 */
@Api(tags = "金融机构api管理")
@RequestMapping("/financialInstitution")
@RestController
public class FinancialInstitutionController {
    @Value("${oss.bucket-domain:}")
    private String ossBucketDomain;
    @Autowired
    private FinancialInstitutionService financialInstitutionService;

    @Autowired
    private InvestingNeedService investingNeedService;

    @Autowired
    private WatermarkConfig watermarkConfig;

    /**
     * 申请金融机构表认证
     */
    /*@ApiOperation("申请金融机构表认证")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "数据不合法", response = Map.class),
            @ApiResponse(code = 10000, message = "服务器异常，请联系管理员"),
            @ApiResponse(code = 0, message = "success")
    })
    @PostMapping("/request")
    public R publish(@Validated @RequestBody PublishFinancialInstitutionVo publishFinancialInstitutionVo, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(bindingResult);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            int result = financialInstitutionService.request(publishFinancialInstitutionVo);
            if (result == 0)
                return R.error(BizCodeEnum.SERVER_EXCEPTION.getCode(), BizCodeEnum.SERVER_EXCEPTION.getMessage());
            else
                return R.ok();
        }
    }*/

    /*@ApiOperation("申请金融机构表认证")
    @ApiResponses({
            @ApiResponse(code = 10002, message = "文件上传失败"),
            @ApiResponse(code = 9999, message = "数据不合法"),
            @ApiResponse(code = 10000, message = "服务器异常，请联系管理员"),
            @ApiResponse(code = 0, message = "success")
    })
    @PostMapping("/request")
    public R publish(@Validated @ModelAttribute PublishFinancialInstitutionVo publishFinancialInstitutionVo, @RequestPart MultipartFile financialInstitutionImage, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(bindingResult);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            int result = financialInstitutionService.request(publishFinancialInstitutionVo, financialInstitutionImage);
            if (result == BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode())
                return R.error(BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode(), BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getMessage());
            else if (result == BizCodeEnum.INPUT_INVALID.getCode())
                return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage());
            else if (result == 0)
                return R.error(BizCodeEnum.SERVER_EXCEPTION.getCode(), BizCodeEnum.SERVER_EXCEPTION.getMessage());
            else
                return R.ok();
        }
    }*/
    @ApiOperation("申请金融机构表认证")
    @ApiResponses({
            @ApiResponse(code = 10002, message = "文件上传失败"),
            @ApiResponse(code = 9999, message = "数据不合法"),
            @ApiResponse(code = 10000, message = "服务器异常，请联系管理员"),
            @ApiResponse(code = 0, message = "success")
    })
    @PostMapping("/request")
    public R publish(@Validated @ModelAttribute PublishFinancialInstitutionVo publishFinancialInstitutionVo,
                     BindingResult bindingResult,
                     @ApiParam(value = "待隐写的图片文件", required = true) @RequestPart("multipartFile") MultipartFile multipartFile,
                     @ApiParam(value = "回调地址", required = false) @RequestPart(value = "callbackUrl", required = false) String callbackUrl,
                     HttpServletRequest request) {
        if (bindingResult.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(bindingResult);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        }
        // 如果没有提供回调URL，构建默认回调URL
        if (callbackUrl == null || callbackUrl.trim().isEmpty()) {
            String scheme = request.getScheme();
            String serverName;
            try {
                // 获取本机实际IP地址而不是localhost
                serverName = InetAddress.getLocalHost().getHostAddress();
            } catch (UnknownHostException e) {
                // 如果获取IP失败，回退到使用request.getServerName()
                serverName = request.getServerName();
            }
            int serverPort = request.getServerPort();
            String contextPath = request.getContextPath();

            String baseUrl = scheme + "://" + serverName;
            if ((scheme.equals("http") && serverPort != 80) || (scheme.equals("https") && serverPort != 443)) {
                baseUrl += ":" + serverPort;
            }
            baseUrl += contextPath;

            callbackUrl = baseUrl + "/stegano/callback/encode/result";
        }

        Map<String, String> result = financialInstitutionService.request(publishFinancialInstitutionVo, multipartFile, callbackUrl);
        if (result.containsKey("500")) {
            return R.error(500, result.get("500"));
        }
        return R.ok().put(result);
    }

    /**
     * 根据注册id获取对应的金融机构认证信息表
     */
    @ApiOperation("根据注册ID获取对应的金融机构认证信息表")
    @GetMapping("/getByFinancialInstitutionId/{financial_institution_id}")
    public R getById(@PathVariable("financial_institution_id") Long financial_institution_id) {
        List<FinancialInstitutionEntity> list = financialInstitutionService.getListById(financial_institution_id);
        if (list == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", list);
    }

    /**
     * 根据企业ID获取对应的投资需求列表
     */
    @ApiOperation("根据企业ID获取对应的金融机构认证信息列表")
    @GetMapping("/getInvestListByFinancialInstitutionId/{financial_institution_id}")
    public R getByFinancialInstitutionId(@PathVariable("financial_institution_id") long financial_institution_id) {
        List<InvestingNeedEntity> list = investingNeedService.getByFinancialInstitutionId(financial_institution_id);
        if (list == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", list);
    }

    /**
     * 根据公司名字模糊查询公司列表
     *
     * @return
     */
    @ApiOperation("根据公司名字模糊查询公司列表")
    @GetMapping("/getFinancialInstitutionListByFinancialInstitutionName/{financial_institution_name}")
    public R getInvestListByFinancialInstitutionName(@PathVariable("financial_institution_name") String financial_institution_name) {
        List<FinancialInstitutionEntity> list = financialInstitutionService.getByFinancialInstitutionName(financial_institution_name);
        //new QueryWrapper<TalentNeedEntity>().eq("business_id", role_id).orderByDesc("publish_time")
        return R.ok().put("data", list);
    }

    /**
     * 修改金融机构认证表
     */
    @ApiOperation("修改金融机构认证表")
    @GetMapping("/updateFinancialInstitution")
    public R updateFinancialInstitution(@Validated @RequestBody FinancialInstitutionEntity financialInstitutionEntity) {
        int flag = financialInstitutionService.updateFinancialInstitution(financialInstitutionEntity);
        return R.ok().put("data", flag);
    }

    /**
     * 根据注册id获取对应的金融机构认证的审核情况
     */
    @ApiOperation("根据注册id获取对应的金融机构认证的审核情况")
    @GetMapping("/getResultByFinancialInstitutionId/{financial_institution_id}")
    public R getResultByFinancialInstitutionId(@PathVariable("financial_institution_id") Long financial_institution_id) {
        String result = financialInstitutionService.getResultByFinancialInstitutionId(financial_institution_id);
        return R.ok().put("data", result);
    }

    /**
     * 根据公司名字询公司信用材料
     *
     * @return
     */
    @ApiOperation("根据公司名字查询公司列表")
    @GetMapping("/getCreditMaterialsByFinancialInstitutionName/{financial_institution_name}")
    public R getCreditMaterialsByFinancialInstitutionName(@PathVariable("financial_institution_name") String financial_institution_name) {
        List<FinancialInstitutionEntity> list = financialInstitutionService.getCreditMaterialsByFinancialInstitutionName(financial_institution_name);
        for (FinancialInstitutionEntity entity : list) {
            // 拦截过期 OSS 机构图片，替换为默认图
            if (entity.getFinancialInstitutionImage() == null
                    || entity.getFinancialInstitutionImage().contains(ossBucketDomain)
                    || entity.getFinancialInstitutionImage().trim().isEmpty()) {
                entity.setFinancialInstitutionImage("/static/defaultImage/1.png");
            }
            // 拦截过期 OSS 信用材料图片
            if (entity.getCreditMaterials() != null
                    && (entity.getCreditMaterials().contains(ossBucketDomain)
                        || entity.getCreditMaterials().trim().isEmpty())) {
                entity.setCreditMaterials(null);
            }
        }
        return R.ok().put("data", list);
    }
}
