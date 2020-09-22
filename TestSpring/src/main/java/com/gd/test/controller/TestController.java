package com.gd.test.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.test.Sha256;
import com.gd.test.service.IPagingService;
import com.gd.test.service.ITestService;

@Controller
public class TestController {
	@Autowired  
	public ITestService iTestService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value="/main")
	public ModelAndView main(ModelAndView mav) {
		mav.setViewName("main/main");
		return mav;
	}
	
	@RequestMapping(value="/head")
	public ModelAndView head(ModelAndView mav) {
		mav.setViewName("main/head");
		return mav;
	}
	
	@RequestMapping(value="/login")
	public ModelAndView login(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		mav.setViewName("main/login");
		return mav;
	}//login
	
	@RequestMapping(value="/join")
	public ModelAndView join(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		mav.setViewName("main/join");
		return mav;
	}//join
	
	@RequestMapping(value="/logout")
	public ModelAndView logout(HttpSession session, ModelAndView mav) throws Throwable {
		
		session.invalidate();
		mav.setViewName("main/login");
		return mav;
	}//logout
	
	@RequestMapping(value = "/loginAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String loginAjax(HttpSession session, @RequestParam HashMap<String,String> params) throws Throwable {
		Object mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			//비밀번호 암호화 
			String pswd = params.get("pswd");
			pswd = Sha256.encrypt(pswd);
			params.put("pswd", pswd);
			
			//이메일, 비밀번호 확인 
			  //이메일 
			int cnt = iTestService.checkEmailCnt(params);
			
			if(cnt > 0) {
				
				int cnt2 = iTestService.checkPswdCnt(params);
				
				if(cnt2 > 0) {
					//일치하면 success
					//이메일이 없거나 비밀번호가 불일치하면 fail
					//세션 정보 액션폼에 담아서 메인에 할당
					HashMap<String,String> data = iTestService.getMemberData(params);
					
					session.setAttribute("sMemberNo", data.get("MEMBER_NO"));
					session.setAttribute("sMemberNm", data.get("MEMBER_NM"));
					//AOP 설정 (main 들어가는건 login 해야만)
					//(login,join은 login 안해야만)


					modelMap.put("result", "success");
				} else {
					modelMap.put("result", "fail");
				}
				
			} else {
				modelMap.put("result", "fail");
			}
			
			
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result","exception");
		}
		
		return ((ObjectMapper) mapper).writeValueAsString(modelMap);
	}//loginAjax
	
	@RequestMapping(value = "/emailCheckAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String emailCheckAjax(HttpSession session, @RequestParam HashMap<String,String> params) throws Throwable {
		Object mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			
			int cnt = iTestService.checkEmailCnt(params);
			
			if(cnt > 0) {

				modelMap.put("result", "fail");
				
			} else {
				modelMap.put("result", "success");
			}
			
			
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result","exception");
		}
		
		return ((ObjectMapper) mapper).writeValueAsString(modelMap);
	}//emailCheckAjax
	
	@RequestMapping(value = "/joinAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String joinAjax(HttpSession session, @RequestParam HashMap<String,String> params) throws Throwable {
		Object mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			//비밀번호 암호화 
			String pswd = params.get("pswd");
			pswd = Sha256.encrypt(pswd);
			params.put("pswd", pswd);
			
			iTestService.insertNew(params);
			modelMap.put("result", "success");
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result","exception");
		}
		
		return ((ObjectMapper) mapper).writeValueAsString(modelMap);
	}//joinAjax
	
	@RequestMapping(value = "/mainbListAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String mainbListAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		Object mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			int cnt = iTestService.getmainbCnt(params);
			int viewCnt = 10;
			int pageCnt = 5;
			
			//page
			HashMap<String,Integer> pb = iPagingService.getpages(Integer.parseInt(params.get("page")), cnt, viewCnt, pageCnt);
			
			modelMap.put("pb",pb);
			modelMap.put("cnt",cnt);
			
			params.put("startCnt", Integer.toString(pb.get("startcount")));
			params.put("endCnt", Integer.toString(pb.get("endcount")));
			
			List<HashMap<String,String>> list = iTestService.getmainbList(params);
			
			modelMap.put("list", list);
			modelMap.put("result", "success");
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result","exception");
		}
		
		return ((ObjectMapper) mapper).writeValueAsString(modelMap);
	}//mainbListAjax
	
	
	
	@RequestMapping(value = "/replywriteAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String replywriteAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		Object mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			//댓글내용 DB입력 
			iTestService.writereply(params);
			modelMap.put("result", "success");
			
		} catch(Throwable e) {
			modelMap.put("result","exception");
		}
		
		return ((ObjectMapper) mapper).writeValueAsString(modelMap);
	}//replywriteAjax
	
	@RequestMapping(value="/mainRead")
	public ModelAndView mainRead(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		
		if(params.containsKey("boardNo")) {
			int cnt2 = iTestService.viewUpdate(params);
			HashMap<String,String> data = iTestService.getOne(params);
			
			mav.addObject("data",data);
			mav.setViewName("main/mainRead");
		} else {
			mav.setViewName("main/main");
		}
		
		return mav;
	}//mainRead
	
	@RequestMapping(value="/mainWrite")
	public ModelAndView mainWrite(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		mav.setViewName("main/mainWrite");
		return mav;
	}//mainWrite
	
	@RequestMapping(value = "/replyAjax", method = RequestMethod.POST, produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String replyAjax(@RequestParam HashMap<String,String> params) throws Throwable {
		Object mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			
			//리플개수 (페이징위해)
			int cnt = iTestService.getreplyCnt(params);
			int viewCnt = 100;
			int pageCnt = 5;
			
			//page
			HashMap<String,Integer> pb = iPagingService.getpages(Integer.parseInt(params.get("replypage")), cnt, viewCnt, pageCnt);
			
			modelMap.put("pb",pb);
			
			params.put("startCnt", Integer.toString(pb.get("startcount")));
			params.put("endCnt", Integer.toString(pb.get("endcount")));
			
			//리플 해시맵 
			List<HashMap<String,String>> list = iTestService.getreplyList(params);
			
			modelMap.put("cnt", cnt);
			modelMap.put("list", list);
			
			//리플 유저
			List<String> user = new ArrayList<String>();
			
			for(int i = list.size() - 1;i>=0;i--) {
				boolean check = true;
				if(String.valueOf(list.get(i).get("MEMBER_NO")) == String.valueOf(list.get(0).get("WRITER_NO"))) {
					user.add("user writer");
				}else {
					for(int j=list.size()-1;j>i;j--) {
						if(String.valueOf(list.get(i).get("MEMBER_NO")) == String.valueOf(list.get(j).get("MEMBER_NO"))) {
							check = false;
							user.add("user "+(j+1));
						}
					}
					if(check) {
						user.add("user "+(i+1));
					}
				}
				
			}//user 전체 포문 
			
			modelMap.put("user", user);
			
			modelMap.put("result", "success");
			
		} catch(Throwable e) {
			e.printStackTrace();
			modelMap.put("result","exception");
		}
		
		return ((ObjectMapper) mapper).writeValueAsString(modelMap);
	}//replyAjax
		
	
	@RequestMapping(value="/test01") //임폴트 
	//ModelAndView: 데이터를 담는 (Model) 역할과 View의 정보를 담고있음
	//인자로 모델앤뷰 마브 
	//Spring에서 기본적으로 제공하는 형태의 경우 인자를 자동으로 채워줌 
	public ModelAndView test01(ModelAndView mav) {  //임폴트
		
		//addObject(키, 값) : 키와 값을 View에 전달
		//Object = 문자열, 리스트, 클래스, 뭐든 다 보낼 수 있음
		mav.addObject("msg", "Hi~!");
		
		List<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
		
		for(int i=10; i>0;i--) {
			HashMap<String,String> data = new HashMap<String,String>();
			
			data.put("no", Integer.toString(i));
			data.put("title", "Test" + i);
			list.add(data);
		}
		
		mav.addObject("list",list);
		
		//setViewName(경로) : View의 위치정보 
		//viewResolver
		//앞: /WEB-INF/views/
		//뒤: .jsp
		//결과: /WEB-INF/views/test/test01.jsp
		mav.setViewName("test/test01");
		
		return mav;
	}
	
	
	@RequestMapping(value="/test02")
	public ModelAndView test02(ModelAndView mav) {
		
		mav.setViewName("test/test02");
		
		return mav;
	}
	
	//Request: 넘어오는 데이터
	//Response: 넘겨줄 데이터 
	//Request -> 현재 ->Response
	@RequestMapping(value="/test03")
	public ModelAndView test03(HttpServletRequest req,
								@RequestParam HashMap<String, String> params,
								@RequestParam List<Integer> b,
								@RequestParam(value="b") List<Integer> check,
								ModelAndView mav) {
		
		int num = Integer.parseInt((String) req.getParameter("num"));//가져오고 
		
		String gugu = "";
		
		for(int i=1;i<10;i++) {
			gugu += num + " * " + i + " = " + (num*i) + "<br/>";
		}
		
		System.out.println(params.get("num"));
		System.out.println(params.get("a"));
		System.out.println(b);
		System.out.println(check);
		
		for(int a : check) {
			System.out.println(a);
		}
		
		mav.addObject("gugu",gugu);
		
		iTestService.test();
		
		mav.setViewName("test/test03");
		
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
