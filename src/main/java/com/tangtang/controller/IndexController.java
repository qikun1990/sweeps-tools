package com.tangtang.controller;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.tangtang.dao.UserAdInfoRepository;
import com.tangtang.dao.UserBaseInfoRepository;
import com.tangtang.po.UserAdInfo;
import com.tangtang.po.UserBaseInfo;

@Controller
public class IndexController {

	@Autowired
	private UserAdInfoRepository userAdInfoRepository;

	@Autowired
	private UserBaseInfoRepository userBaseInfoRepository;

	@RequestMapping(value = "/userbaseinfo", method = RequestMethod.POST)
	@ResponseBody
	public String userBaseInfo(@RequestBody JSONObject jsonParms) {
		System.out.println("userbaseinfo: " + jsonParms.toJSONString());
		try {
			UserBaseInfo userBaseInfo = new UserBaseInfo();
			// 数据转换
			userBaseInfo = cvtJson2UserBaseInfo(jsonParms);
			// 保存数据
			userBaseInfoRepository.save(userBaseInfo);
		} catch (Exception e) {
			System.out.println("用户Base信息保存出现异常，异常信息如下：");
			e.printStackTrace();
			return "error";
		}
		return "success";
	}

	@RequestMapping(value = "/useradinfo", method = RequestMethod.POST)
	@ResponseBody
	public String userAdInfo(@RequestBody JSONObject jsonParms) {
		System.out.println("useradinfo: " + jsonParms.toJSONString());
		try {
			UserAdInfo userAdInfo = new UserAdInfo();
			// 数据转换
			userAdInfo = cvtJson2UserAdInfo(jsonParms);
			// 保存数据
			userAdInfoRepository.save(userAdInfo);
			// 转化回传
			postback(userAdInfo.getSubid());

		} catch (Exception e) {
			System.out.println("用户AD信息保存&转化回传出现异常，异常信息如下：");
			e.printStackTrace();
			return "error";
		}
		return "success";
	}

	private void postback(String subid) {
		try {
			HttpClient client = HttpClients.createDefault();
			String url = "https://www.nycseller.com/1143046/postback?sub_id=" + subid;
			System.out.println("postback2Keitaro: url=" + url);
			HttpGet get = new HttpGet(url);
			HttpResponse res = client.execute(get);
			String response = EntityUtils.toString(res.getEntity());
			System.out.println("postback2Keitaro done " + response);
		} catch (Exception e) {
			System.out.println("转化回传给Keitaro时出现异常：");
			e.printStackTrace();
		}
	}

	private static UserBaseInfo cvtJson2UserBaseInfo(JSONObject jsonParms) {
		UserBaseInfo userBaseInfo = new UserBaseInfo();
		try {
			userBaseInfo = JSONObject.parseObject(jsonParms.toJSONString(), UserBaseInfo.class);
			return userBaseInfo;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userBaseInfo;
	}

	private static UserAdInfo cvtJson2UserAdInfo(JSONObject jsonParms) {
		UserAdInfo userAdInfo = new UserAdInfo();
		try {
			userAdInfo = JSONObject.parseObject(jsonParms.toJSONString(), UserAdInfo.class);
			return userAdInfo;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userAdInfo;
	}

}
