package com.dobee.controller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.View;

import com.dobee.dao.ScheduleDao;
import com.dobee.dao.UserDao;
import com.dobee.services.ApplyService;
import com.dobee.vo.Apply;
import com.dobee.vo.ApplyCode;
import com.dobee.vo.member.Break;
import com.dobee.vo.member.ChartData;
import com.dobee.vo.member.User;
import com.dobee.vo.schedule.MainSchedule;

@RestController
@RequestMapping("ajax/apply/**")
public class AjaxController_DABC {
	
	@Autowired
	private View jsonview;
	
	@Autowired
	private SqlSession sqlsession;
	
	@Autowired
    private ApplyService applyService;
	
	
	// 개인_부재신청 부재항목 불러오기	COMPLETE o			부재신청에서는 사용 안함
	@RequestMapping("getApyCode.do")
	public View brkApyCat (Model map){
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<ApplyCode> results = userDao.getApyCode();
		map.addAttribute("apyCode", results);
		return jsonview;
	}
	
	
	// 개인_부재/연장신청 결재자 불러오기		COMPLETE o
	@RequestMapping("getApprovalList.do")
	public View getRenewedList (Model map, Integer teamCode) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<User> results = userDao.getApprovalList(teamCode);
		map.addAttribute("renewedList", results);
		
		return jsonview;
	}
	
	
	// Ajax 개인_부재일정 신청 - 캘린더 Event 불러오기		0118	COMPLETE o
	@RequestMapping("AbsAll.do")
	public View AbsAll (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<Apply> results = userDao.AbsAll(auth.getName());
		map.addAttribute("AbsAll", results);
		
		return jsonview;
	}
	
	
	// Ajax 개인_부재일정 신청 - 캘린더 Event 불러오기		0118	COMPLETE
	@RequestMapping("Calender.do")
	public View CalenderEvent (Model map) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<Apply> results = userDao.Calendar();
		map.addAttribute("Calendar", results);
		
		return jsonview;
	}
	
	
	// Ajax 개인_연장근무 신청 - 캘린더 Event 불러오기		0118	COMPLETE o
	@RequestMapping("ExtAll.do")
	public View ExtAll (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<Apply> results = userDao.ExtAll(auth.getName());
		map.addAttribute("ExtAll", results);
		
		return jsonview;
	}
	
	
	// 개인_근무내역 확인 차트 데이터 불러오기			0129 COMPLETE o
	@RequestMapping("getChartData.do")
	public View getChartData (Model map, Authentication auth, String ym) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<ChartData> results = userDao.getChartData(auth.getName(), ym);
		map.addAttribute("CD", results);
		
		return jsonview;	
	}
	
	
	// 개인_남은/사용 연차 불러오기				COMPLETE o
	@RequestMapping("getVacationInBM.do")
	public View getVacationInBM (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<Break> results = userDao.getVacationInBM(auth.getName());
		map.addAttribute("totalVacation", results);
		
		return jsonview;
	}
	
	
	// 개인_근무내역 확인 년 월 불러오기			0129 COMPLETE o
	@RequestMapping("overTimeYearMonthList.do")
	public View overTimeYearMonthList (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<Integer> results = userDao.overTimeYearMonthList(auth.getName());
		map.addAttribute("OTYMList", results);
		
		return jsonview;
	}
	
	
	// 개인_월 근무 시간 가져오기			COMPLETE o
	@RequestMapping("getWorkHour.do")
	public View getWorkHour (Model map, Authentication auth, String ym) {	
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<Integer> results = userDao.getWorkHour(auth.getName(), ym);
		map.addAttribute("workHour", results);
		
		return jsonview;
	}

	
	////////// 메인 캘린더 캘린더에 뿌리기 //////////
		
	// 공지,업무,프로젝트 일정 캘린더 병합		0131	게다죽		COMPELTE o
	@RequestMapping(value="ntpToCal.do", method=RequestMethod.GET)
	public View prjectToCalendar (Model map, Authentication auth) {
		ScheduleDao sDao = sqlsession.getMapper(ScheduleDao.class);
		List<MainSchedule> result = sDao.ntpToCalendar(auth.getName());
		map.addAttribute("NTPTC", result);
		
		return jsonview;
	}
	
	

	////////// 매니저 ///////////////////////////
    
	// Ajax 매니저_부재일정확인 - Option - 부재항목 loading		0115 o			팀별 확인 - 세션에서 팀 코드 출력해서 조회하는걸로
	@RequestMapping("breakEntryListMgr.do")
	public View breakEntryListMgr (Model map) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<ApplyCode> result = userDao.breakEntryListMgr();
		map.addAttribute("breakEntryListMgr", result);
		
		return jsonview;
	}
	
	
	
	
	/*	
	 어려워서 안함.
	////////// 프로젝트 현황 차트 맹글기 ///////////////
	
	// 프로젝트 현황 차트 생성 			0201	게다죽		~ING			pjtseq param 추가
	@RequestMapping(value="projChartData.do", method=RequestMethod.GET)
	public View projChartData (Model map) {
		ProjectDao pDao = sqlsession.getMapper(ProjectDao.class);
		List<Task> result = pDao.getProjChartData();
		
		map.addAttribute("PCD", result);
		
		return jsonview;
	}





	// Ajax 개인_부재일정확인 - Option - 년도 loading		0113	COMPLETE
	@RequestMapping("breakYearList.do")
	public View breakYearList (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<Integer> results = userDao.breakYearList(auth.getName());
		map.addAttribute("breakYearList", results);
		
		return jsonview;
	}
	
	
	// Ajax 개인_부재일정확인 - 년도별 List 출력		0113		~ing
	@RequestMapping("getBreakListByYear.do")
	public View getBreakListByYear (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<BreakManageList> results = userDao.getBreakListByYear(auth.getName());
		map.addAttribute("byYear", results);
		
		return jsonview;
	}
	
	
    // Ajax 개인_부재일정확인 - Option - 월 loading		0113	COMPLETE
	@RequestMapping("breakYearMonthList.do")
	public View breakYearMonthList (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<Integer> results = userDao.breakYearMonthList(auth.getName());
		map.addAttribute("breakYearMonthList", results);
		
		return jsonview;
	}
	
	
	// Ajax 개인_부재일정확인 - 년-월별 List 출력		0113		~ing
	@RequestMapping("getBreakYearMonthList.do")
	public View getBreakYearMonthList (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<BreakManageList> results = userDao.getBreakListByYMonth(auth.getName());
		map.addAttribute("byYMonth", results);
		
		return jsonview;
	}
	

    // Ajax 개인_부재일정확인 - Option - 부재항목 loading		0113		COMPLETE
	@RequestMapping("breakEntryList.do")
    public View breakEntryList (Model map, Authentication auth) {
    	UserDao userDao = sqlsession.getMapper(UserDao.class);
    	List<ApplyCode> results= userDao.breakEntryList(auth.getName());
    	map.addAttribute("breakEntryList", results);
    	
    	return jsonview;
    }
	
	
	// Ajax 개인_부재일정확인 - 부재항목 별 List 출력		0113			~ing
	@RequestMapping("getBreakListByEntry.do")
	public View getBreakListByEntry (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<BreakManageList> results = userDao.getBreakListByEntry(auth.getName());
		map.addAttribute("byEntry", results);
		
		return jsonview;
	}
	

    // Ajax 개인_부재일정확인 - Option - 승인여부 loading		0113		COMPLETE
	@RequestMapping("breakIsAuthList.do")
    public View breakIsAuthList (Model map, Authentication auth) {
    	UserDao userDao = sqlsession.getMapper(UserDao.class);
    	List<String> results= userDao.breakIsAuthList(auth.getName());
    	map.addAttribute("breakIsAuthList", results);
    	
    	return jsonview;
    }
	
	
	// Ajax 개인_부재일정확인 - 승인여부 별  List 출력		0113			~ing
	@RequestMapping("getBreakListByIsAuth.do")
	public View getBreakListByIsAuth (Model map, Authentication auth) {
		UserDao userDao = sqlsession.getMapper(UserDao.class);
		List<BreakManageList> results = userDao.getBreakListByIsAuth(auth.getName());
		map.addAttribute("byIsAuth", results);
		
		return jsonview;
	}

	*/
	
	
}