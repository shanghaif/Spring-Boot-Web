package com.maryun.lb.controller.jyb.secondMotion;


import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UrlDecode;

/**
 * @author: Libra(Hyt)
 * Date: 2017年4月26日 下午3:47:30
 * Version: 1.1
 * @Description:  二级平台运营管理Controller 
 */
@RestController
@RequestMapping(value = "/jyb/secondMotion")
public class SecondMotionController extends BaseController{

	
	/**
	 * 二级运营人员管理页面跳转	(列表)	
	 * @return
	 */
	@RequestMapping(value = "/toList")
	@ResponseBody
	public ModelAndView toList(){
		return new ModelAndView("lb/jyb/secondMotion/motion_list");
	}
	
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() {
		PageData pad = this.getPageData();
		PageData pd = UrlDecode.urlDecode(pad);
		try {
			PageData userPd=this.postForPageData(systemServer+"jyb/motion/pageSearch", pd);
			if(this.resSuccCode.equals(userPd.getString("state"))){
				return userPd.getString("content");
			}else{
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	/**
	 * 二级运营人员管理页面跳转 (新增)	
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	@ResponseBody
	public ModelAndView toAdd(){
		return new ModelAndView("lb/jyb/secondMotion/motion_add");
	}
	
	/**
	 * 保存用户
	 */
	@RequestMapping(value = "/saveAdd")
	public ModelAndView saveAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("HE_AREA", pd.getString("HE_AREA"));
		//pd=this.postForPageData(systemServer+"user/saveAdd", pd);
		
		this.savePage(pd);
		pd.put("USER_ID", this.get32UUID()); // ID
		pd.put("LAST_LOGIN", ""); // 最后登录时间
		pd.put("IP", ""); // IP
		pd.put("STATUS", "0"); // 状态
		pd.put("SKIN", "default"); // 默认皮肤
		
		
		String passwd =DigestUtils.md5DigestAsHex(String.join(",",pd.getString("USER_ID"), pd.getString("PASSWORD")).getBytes());
		pd.put("PASSWORD", passwd);
		PageData userPd=this.postForPageData(systemServer+"jyb/motion/saveAdd", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			mv.addObject(userPd.getString("content"));
		}
		mv.setViewName("lb/jyb/secondMotion/motion_list");
		return mv;
	}
	
	/**
	 * 二级运营人员管理页面跳转	(编辑)
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		@SuppressWarnings("rawtypes")
		PageData userPd=this.postForPageData(systemServer+"jyb/motion/toEdit", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			userPd=JSON.parseObject(userPd.getString("content"),PageData.class);
		}else{
			userPd=null;
		}
		mv.setViewName("lb/jyb/secondMotion/motion_edit");
		mv.addObject("pd",userPd);
		return mv;
	}
	
	
	
	/**
	 * 修改用户
	 */
	@RequestMapping(value = "/saveEdit")
	public ModelAndView saveEdit() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.viewAndPd("lb/jyb/secondMotion/motion_list", systemServer+"jyb/motion/saveEdit", pd);
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() {
		PageData pd = this.getPageData();
		
		PageData userPd=this.postForPageData(systemServer+"jyb/motion/delete", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			return userPd.get("content");
		}else{
			return null;
		}
	}

	/**
	 * 修改用户
	 */
	@RequestMapping(value = "/showRP")
	public ModelAndView showRP() throws Exception {
		PageData pd  = this.getPageData();
		return this.viewAndPd("system/jyb/motion/user_rpList", systemServer+"jyb/motion/showRP", pd);
	}
	
	
}
