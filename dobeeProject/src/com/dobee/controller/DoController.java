package com.dobee.controller;




import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dobee.dao.NoticeDao;
import com.dobee.dao.UserDao;
import com.dobee.services.ApplyService;
import com.dobee.services.ChatService;
import com.dobee.services.DebitService;
import com.dobee.services.GoogleVisionService;
import com.dobee.services.MemberService;
import com.dobee.services.NoticeService;
import com.dobee.services.ProjectService;
import com.dobee.services.ScheduleService;
import com.dobee.vo.Apply;
import com.dobee.vo.Debit;
import com.dobee.vo.chat.ChatRoom;
import com.dobee.vo.member.BreakManageList;
import com.dobee.vo.member.TeamList;
import com.dobee.vo.member.User;
import com.dobee.vo.notice.Notice;
import com.dobee.vo.notice.NoticeFile;
import com.dobee.vo.project.Project;
import com.dobee.vo.project.Task;
import com.dobee.vo.schedule.NotSchedule;
import com.dobee.vo.schedule.Schedule;


@Controller
public class DoController {
	
	public DoController() {
		System.out.println("�ϴ� ��Ʈ�� ���� ����");
	}
	
	
    @Autowired
    private SqlSession sqlsession;
    
    @Autowired
    private ProjectService projectService;
    
    @Autowired
    private ApplyService applyService;
    
    @Autowired
    private ChatService chatService;
    
    @Autowired
    private MemberService memberService;
    
    @Autowired
    private DebitService debitService;
    
    @Autowired
    private NoticeService noticeService;
    
    @Autowired
    private ScheduleService scheduleService;
    

    //�α���
    @RequestMapping("login.do")
    public String login(){
        return "main/login";
    }
    
    
    //���Ѿ��� ������
    @RequestMapping("noAuth.do")
    public String noAuth() {
    	return "main/noAuthority";
    }
  
    //���̵�ã��
    @RequestMapping(value="findId.do",method=RequestMethod.GET)
    public String findId(String name, String phone ,  Model model){
    	String find;
    	UserDao userDao = sqlsession.getMapper(UserDao.class);
    	 find = userDao.findId(name, phone);
    	 System.out.println("���1dd:"+find);
    	 model.addAttribute("find",find);
      return "main/findId";
    }

    public String fidIdResult(){
        return null;
    }
    
    //��й�ȣã�� view��
    @RequestMapping(value="findPassWord2.do",method=RequestMethod.GET)
    public String findPassWord2(){
        return "main/findPassWord2";
    }
    //��й�ȣ ã��
    @RequestMapping(value="findPassWord2.do",method=RequestMethod.POST)
    public String findPassWord2(String mail,Model model){
    	System.out.println(mail);
    	String find;
    	UserDao userDao =sqlsession.getMapper(UserDao.class);
    	 find = userDao.findPassWord2(mail);
    	 model.addAttribute("find",find);
    	 System.out.println("���2:"+find);
    	return "main/findId";
    }
    

    //��й�ȣ�缳��
    //public String resetPwd(){
      //  return null;
    //}
    
    @RequestMapping("password.do")
    public String resetPwd(HttpServletRequest req, Model model){
    	System.out.println("DoController resetPwd() in!!");
    	System.out.println(req.getParameter("mail"));
    	UserDao userDao = sqlsession.getMapper(UserDao.class);
    	User user = userDao.getUser(req.getParameter("mail"));
    	System.out.println(user.toString());
    	model.addAttribute("user", user);
        return "main/emailPwdReset";
    }

    @RequestMapping("resetPwdResult.do")
    public String resetPwdResult(User user){
        System.out.println("DoController resetPwdResult() in!!");
        System.out.println(user.toString());
        memberService.resetPwd(user);
    	return "redirect: index.jsp";
    }


    //����������(�α�����)
    @RequestMapping("main.do")
    public String main(Principal principal , HttpServletRequest request, Model model){
    	System.out.println("��Ʈ�ѷ� main.do");
    	User user = (User) request.getSession().getAttribute("user");
    	model.addAttribute("user", user);
        return "main/main";
    }

    //������ ������ ���ȭ��
    @RequestMapping("adminWarnig.do")
    public String adminWarning() {
    	return "admin/AdminWarning";
    }
    
    
    //������ ����
    @RequestMapping("adminMain.do")
    public String adminMain(HttpServletRequest request, Model model) {
    	User user = (User) request.getSession().getAttribute("user");
    	UserDao userDao = sqlsession.getMapper(UserDao.class);
    	List<User> userInfoList = userDao.getUserInfoList();
    	model.addAttribute("user", user);
    	model.addAttribute("userList", userInfoList);
    	return "admin/AdminMain";
    }
    
    
    //������ ����ī���� ��� �̵�
    @RequestMapping(value="AdminDebit.do",method=RequestMethod.GET)
    public String adminAddDebit() {
    	return "admin/AddDebit";
    }
    

    //������ ����ī�� ��� ����̵� �� �ҷ�����
    @RequestMapping(value="ListDebit.do",method=RequestMethod.GET)
    public ModelAndView adminListDebit() {
    	ModelAndView mav = new ModelAndView();
    	ArrayList debitList = debitService.listDebit();
    	mav.addObject("debitList", debitList);
    	mav.setViewName("admin/ListDebit");
    	return mav;
    }
    
    
    //������ ����ī�� ��� ���
    @RequestMapping(value="AdminDebit.do",method=RequestMethod.POST)
    public String adminAddDebitOK(Debit debit) {
    	System.out.println("��Ʈ�� AdminDebit.do ���� �Ѵ�.");
    	boolean check = debitService.addDebit(debit);
    	
    	System.out.println("������� ������ ���� :" + check);
    	if(check) {
    		System.out.println("��Ʈ�Ѵ�  : ����ī�� ��� ����");
    	}else {
    		System.out.println("��Ʈ�Ѵ� : ����ī�� ��� ����");
    		return null;
    		//��� �����ϸ� �ƹ��ϵ� ���Ͼ
    	}
    	//��� �����ϸ� ī�� ��� ������� �̵�
    	return "redirect:ListDebit.do";
    }
    
    
    //ȸ�� �������
    //@RequestMapping(value = "", method = RequestMethod.POST)
    public String addSchedule(){
        return null;
    }


    //����������
    @RequestMapping(value = "mypage.do", method = RequestMethod.GET)
    public String mypage(Principal principal, Model model){
    	//ȸ�� ���� ��������
    	String mail = principal.getName();
    	User user = memberService.getUserInfo(mail);
    	model.addAttribute("user", user);
        return "myPage/myPage";
    }
    
    
    //�������׸���Ʈ
    @RequestMapping("noticeList.do")
    public String noticeList(Notice notice,Model model){
		List<Notice>list=null;
		NoticeDao noticedao=sqlsession.getMapper(NoticeDao.class);
		list=noticedao.noticeList(notice);
		System.out.println(list);
		model.addAttribute("list",list);
    
        return "notice/noticeList";
    }


    //�������׻󼼺��� value="noticeWrite.do",method=RequestMethod.POST
    @RequestMapping(value="noticeDetail.do", method=RequestMethod.GET)
    public String noticeDetail(@RequestParam(value="notSeq") int notSeq, Model model){
        Notice notice = null; 
        NoticeFile nf = null;
        NotSchedule ns = null;
        Schedule sc = null;
        
        int noticeCount = 0;
                        
        //��ȸ�� �ø���
        noticeCount = noticeService.updateNoticeCount(notSeq);
        
        //DB���� �� ��������
        notice = noticeService.getNotice(notSeq);
        model.addAttribute("notice", notice);
        
        //DB���� ���� ��������
        nf = noticeService.getNoticeFile(notSeq);
        if(nf !=null) {
            model.addAttribute("nf", nf);
        } else {
        	model.addAttribute("nf", null);
        }

        //DB���� �������� ���� ��������
        ns = noticeService.getNotSchedule(notSeq);
        
        if(ns !=null) {
        	model.addAttribute("ns", ns);
            sc = scheduleService.getSchedule(ns.getSchSeq());
            model.addAttribute("sc", sc);
        } else {
        	model.addAttribute("ns", null);
        	model.addAttribute("sc", null);
        }
        
       
        return "notice/noticeDetail";
    }
    
    //�������� ���� �ٿ�ε� noticeDownload.do
    @RequestMapping(value="noticeDownload.do")
    public void noticeDownload(@RequestParam(value="p") String p, @RequestParam(value="f") String f, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		/*
		 * //�ѱ� ó�� ���� ���� String sEncoding = new
		 * String(filename.getBytes("euc-kr"),"8859_1");
		 * response.setHeader("Content-Disposition","attachment;filename= " +
		 * sEncoding);
		 * //response.setHeader("Content-Disposition","attachment;filename= " + filename
		 * +";");
		 */
		// �ѱ� ���ϸ� ó�� (Filtter ó�� Ȯ��) -> ��� ...
		// �ѱ� ���� ���� ���� �ذ��ϱ�
		// String fname = new String(f.getBytes("ISO8859_1"),"UTF-8");
		String fname = new String(f.getBytes("euc-kr"), "8859_1");
		// �ٿ�ε� �⺻ ���� (�������� read ���� �ʰ� ... �ٿ� )
		// ��û - ���� ���� ��������� ������ ���� �ٿ�ε�
		// response.setHeader("Content-Disposition", "attachment;filename=" +
		// new String(fname.getBytes(),"ISO8859_1"));
		response.setHeader("Content-Disposition", "attachment;filename=" + fname + ";");
		// ���ϸ� ����
		// ���� ��������
		String fullpath = request.getServletContext().getRealPath(p + "/" + f);
		FileInputStream fin = new FileInputStream(fullpath);
		// ��� ���� ��� :response.getOutputStream()
		ServletOutputStream sout = response.getOutputStream();
		byte[] buf = new byte[1024]; // ��ü�� ������ �ʰ� 1204byte�� �о
		int size = 0;
		while ((size = fin.read(buf, 0, buf.length)) != -1) // buffer �� 1024byte
		// ���
		{ // ������ �����ִ� byte ��� �״��� ������ Ż��
			sout.write(buf, 0, size); // 1kbyte�� ���
		}
		fin.close();
		sout.close();
	}
    


    //�������ױ۾��� view ������
    @RequestMapping(value="noticeWrite.do",method=RequestMethod.GET)
    public String noticeWrite(){
        return "notice/noticeWrite";
    }
    
    //�������ױ۾��� ó�� 
    @RequestMapping(value="noticeWrite.do",method=RequestMethod.POST)
    public String noticeWrite(Notice n, NoticeFile nf, Schedule sc, NotSchedule ns, HttpServletRequest request) throws IOException {
    	
    	System.out.println("���� ��� ����?"+nf);
    	System.out.println("����������"+nf.getFile());
    	
    	//�������� �� DB �ֱ�
    	int notSeq = noticeService.noticeWrite(n); //���� ���� ������ notice�� seq�� ������
    	
    	//���� ���ε� ���ϸ�
    	CommonsMultipartFile file = nf.getFile();
    	String filename = file.getOriginalFilename(); //���� ���ϸ�
    	System.out.println("���� ���ε� ���ϸ� ���� ��?"+nf);
    	System.out.println("���� �̸�?"+filename);
    	//�������� ������ ���ε��� ���
    	if(!( filename == null || filename.trim().equals("") )) {
        	String path = request.getServletContext().getRealPath("/upload");
        	String fpath = path + "\\" + filename;
        		
        	//���� ���� �۾�
        	FileOutputStream fs = new FileOutputStream(fpath); // ������ �ű�ٰ� ���� ������
        	fs.write(file.getBytes());
        	fs.close();
        		
        	//DB�� ���� �̸� ����
        	nf.setOrgName(filename);
        	UUID randomIdMulti = UUID.randomUUID();
        	String saveName = filename+"_"+randomIdMulti;
        	System.out.println("����� ���� �̸�?"+saveName);
        	nf.setSaveName(saveName);
        
        	//�������� �۹�ȣ ����
        	nf.setNotSeq(notSeq);
        	
        	int result = noticeService.noticeFileWrite(nf);
        	if(result > 0) {
        		System.out.println("�������� ���� ���ε� �Ϸ�");
        	}
    	}
    	
    	//�������� ������ �Է��� ���
    	if(!(sc.getStartTime() == null && sc.getEndTime() == null)) {
    		
    		int result = scheduleService.addSchedule(sc); 
    		
    		if(result > 0) { //DB�� �� �����
    			System.out.println("������ ��� �Ϸ�");
    			int schSeq = result;
    			ns.setSchSeq(schSeq);
    			//�������� ���� ���
    			
    			ns.setNotSeq(notSeq); //�������� �� ��ȣ ����
    			int result2 = noticeService.addNotSchedule(ns);
    			
    			if(result2 > 0) {
    				System.out.println("�������� ���� ��� �Ϸ�");
    			}
    			
    		}
    	}    	
    	return "redirect:noticeList.do"; //����ִ� �ּ� ...
    }


    //�������׼����ϱ� view
    @RequestMapping(value="noticeModify.do",method=RequestMethod.GET)
    public String noticeModify(@RequestParam(value="notSeq") int notSeq, Model model){
    	Notice notice = null; 
        NoticeFile nf = null;
        NotSchedule ns = null;
        Schedule sc = null;
        
        //DB���� �� ��������
        notice = noticeService.getNotice(notSeq);
        model.addAttribute("notice", notice);
        
        //DB���� ���� ��������
        nf = noticeService.getNoticeFile(notSeq);
        if(nf !=null) {
            model.addAttribute("nf", nf);
        } else {
        	model.addAttribute("nf", null);
        }

        //DB���� �������� ���� ��������
        ns = noticeService.getNotSchedule(notSeq);

        if(ns !=null) {
        	model.addAttribute("ns", ns);
            sc = scheduleService.getSchedule(ns.getSchSeq());
            model.addAttribute("sc", sc);
        } else {
        	model.addAttribute("ns", null);
        	model.addAttribute("sc", null);
        }
        
    	return "notice/noticeModify";
    }
    
    //�������׼����ϱ� ó��
    @RequestMapping(value="noticeModify.do",method=RequestMethod.POST)
    public String noticeModify(@RequestParam(value="notSeq") String notSeq, Notice n, NoticeFile nf, Schedule sc, NotSchedule ns, HttpServletRequest request) throws IOException {
    	System.out.println("���� Ÿ��?");
    	System.out.println("���� ������?"+nf);
    	//���� ���� >> ���� & ���� ����
    	
    	int noticeModify = noticeService.noticeModify(n);
    	
    	CommonsMultipartFile file = nf.getFile();
    	String filename = file.getOriginalFilename(); //���� ���ϸ�
    	System.out.println("�����̸�?"+filename);
    	
    	//���� �־����� �������� Ȯ�� �� ������ update, ������ insert
    	String fileExists = request.getParameter("fileExists");
    	String notScheduleExists = request.getParameter("notScheduleExists");
    	String fileNameExists = request.getParameter("fileNameExists");
    	
    	System.out.println("���� �ױ� �� ����?"+fileNameExists);
    	//�������� ���� ���ε� �ϱ�
    	if(!( filename == null || filename.trim().equals("") )) {
    		String path = request.getServletContext().getRealPath("/upload");
        	String fpath = path + "\\" + filename;
        		
        	//���� ���� �۾�
        	FileOutputStream fs = new FileOutputStream(fpath); // ������ �ű�ٰ� ���� ������
        	fs.write(file.getBytes());
        	fs.close();
        		
        	//DB�� ���� �̸� ����
        	nf.setOrgName(filename);
        	UUID randomIdMulti = UUID.randomUUID();
        	String saveName = filename+"_"+randomIdMulti;
        	//System.out.println("����� ���� �̸�?"+saveName);
        	nf.setSaveName(saveName);
        
        	//�������� �۹�ȣ ����
        	nf.setNotSeq(n.getNotSeq());
        	
    		if(fileExists.equals("true")) { //���� ������ ���ε��ߴ� ��� -> update�ϱ�
            	int result = noticeService.noticeFileModify(nf);
            	if(result > 0) {
            		System.out.println("�������� ���� update �Ϸ�");
            	}
        	} else { //���� ������ ���ε� �� ��� -> insert �ϱ�
        		System.out.println("���� ���� ���ε� �ϴ�?");
        		int result = noticeService.noticeFileWrite(nf);
            	if(result > 0) {
            		System.out.println("�������� ���� insert �Ϸ�");
            	}
        		
        	}
    	} else { //���� ���ε带 ���� �ʴ� ���
    		System.out.println("���� ���ε� ���ҰŴ�?");
    		
    		
    	}
    	
    	//�������� ������ �Է��� ���
    	if(!(sc.getStartTime() == null && sc.getEndTime() == null)) {
    		if(notScheduleExists.equals("true")) { //���� ������ �ִ� ��� -> update
    			//������ update
    			int result = scheduleService.scheduleModify(sc);
    			//���� ���� update
    			if( result > 0 ) {
    				System.out.println("������ update �Ϸ�");
    				int result2 = noticeService.notScheduleModify(ns);
    				
    				if(result2 > 0) {
        				System.out.println("�������� ���� update �Ϸ�");
        			}
    			}
    			
    		} else { //���� ������ �߰��� ��� -> insert
    			int result = scheduleService.addSchedule(sc); 
        		if(result > 0) { //DB�� �� �����
        			System.out.println("������ insert �Ϸ�");
        			int schSeq = result;
        			ns.setSchSeq(schSeq);
        			//�������� ���� ���
        			ns.setNotSeq(n.getNotSeq()); //�������� �� ��ȣ ����
        			int result2 = noticeService.addNotSchedule(ns);
        			
        			if(result2 > 0) {
        				System.out.println("�������� ���� insert ��� �Ϸ�");
        			}
        		}
    		}
    	}
		return "redirect:noticeDetail.do?notSeq="+n.getNotSeq();
    }
    /*
    
    //�������׼����ϱ� ó��
    @RequestMapping(value="noticeModify.do",method=RequestMethod.POST)
    public String noticeModify(@RequestParam(value="notSeq") String notSeq, Notice n, NoticeFile nf, Schedule sc, NotSchedule ns, HttpServletRequest request) throws IOException {
    	System.out.println("���� Ÿ��?");
    	//���� ���� >> ���� & ���� ����
    	int noticeModify = noticeService.noticeModify(n);
    	
    	CommonsMultipartFile file = nf.getFile();
    	String filename = file.getOriginalFilename(); //���� ���ϸ�
    	System.out.println("�����̸�?"+filename);
    	
    	//���� �־����� �������� Ȯ�� �� ������ update, ������ insert
    	String fileExists = request.getParameter("fileExists");
    	String notScheduleExists = request.getParameter("notScheduleExists");
    	String fileNameExists = request.getParameter("fileNameExists");
    	
    	System.out.println("���� �ױ� �� ����?"+fileNameExists);
    	//�������� ���� ���ε� �ϱ�
    	if(!( filename == null || filename.trim().equals("") )) {
    		String path = request.getServletContext().getRealPath("/upload");
        	String fpath = path + "\\" + filename;
        		
        	//���� ���� �۾�
        	FileOutputStream fs = new FileOutputStream(fpath); // ������ �ű�ٰ� ���� ������
        	fs.write(file.getBytes());
        	fs.close();
        		
        	//DB�� ���� �̸� ����
        	nf.setOrgName(filename);
        	UUID randomIdMulti = UUID.randomUUID();
        	String saveName = filename+"_"+randomIdMulti;
        	//System.out.println("����� ���� �̸�?"+saveName);
        	nf.setSaveName(saveName);
        
        	//�������� �۹�ȣ ����
        	nf.setNotSeq(n.getNotSeq());
        	
    		if(fileExists.equals("true")) { //���� ������ ���ε��ߴ� ��� -> update�ϱ�
            	int result = noticeService.noticeFileModify(nf);
            	if(result > 0) {
            		System.out.println("�������� ���� update �Ϸ�");
            	}
        	} else { //���� ������ ���ε� �� ��� -> insert �ϱ�
        		System.out.println("���� ���� ���ε� �ϴ�?");
        		int result = noticeService.noticeFileWrite(nf);
            	if(result > 0) {
            		System.out.println("�������� ���� insert �Ϸ�");
            	}
        		
        	}
    	} else { //���� ���ε带 ���� �ʴ� ���
    		System.out.println("���� ���ε� ���ҰŴ�?");
    		
    		
    	}
    	
    	//�������� ������ �Է��� ���
    	if(!(sc.getStartTime() == null && sc.getEndTime() == null)) {
    		if(notScheduleExists.equals("true")) { //���� ������ �ִ� ��� -> update
    			//������ update
    			int result = scheduleService.scheduleModify(sc);
    			//���� ���� update
    			if( result > 0 ) {
    				System.out.println("������ update �Ϸ�");
    				int result2 = noticeService.notScheduleModify(ns);
    				
    				if(result2 > 0) {
        				System.out.println("�������� ���� update �Ϸ�");
        			}
    			}
    			
    		} else { //���� ������ �߰��� ��� -> insert
    			int result = scheduleService.addSchedule(sc); 
        		if(result > 0) { //DB�� �� �����
        			System.out.println("������ insert �Ϸ�");
        			int schSeq = result;
        			ns.setSchSeq(schSeq);
        			//�������� ���� ���
        			ns.setNotSeq(n.getNotSeq()); //�������� �� ��ȣ ����
        			int result2 = noticeService.addNotSchedule(ns);
        			
        			if(result2 > 0) {
        				System.out.println("�������� ���� insert ��� �Ϸ�");
        			}
        		}
    		}
    	}    
		return "redirect:noticeDetail.do?notSeq="+n.getNotSeq(); // "redirect:noticeDetail.do?notSeq="+n.getNotSeq();����ִ� �ּ� ...
    }
    */


    // ����_����������û GET 0110           �Դ���
    @RequestMapping(value="breakApply.do", method=RequestMethod.GET)
    public String absApply(){
        return "attend/breakApply";
    }
    
   
    
    
    // ����_�������� ����/���� GET                0120    COMPLETE
    @RequestMapping(value="editApply.do", method=RequestMethod.GET)
    public String getEditApply (Model model, Apply apply, Authentication auth, Integer aplSeq) {
        apply.setAplSeq(aplSeq);
        apply.setDrafter(auth.getName());
        BreakManageList results = applyService.getBMLforEdit(apply);
        model.addAttribute("editApplyList", results);
        
        return "attend/breakApplyEdit";
    }
    
    
    // ����_�������� ���� POST      0121 COMPLETE
    @RequestMapping(value="postEditApply.do", method = RequestMethod.POST)
    public String postEditApply (BreakManageList bml, Integer aplSeq, Authentication auth) {
        bml.setDrafter(auth.getName());
        bml.setAplSeq(aplSeq);
        int results = applyService.postEditApply(bml);
        
        return "redirect: editApply.do";
    }
    
    
    // ����_�������� ���� POST          0120    COMPLETE
    @RequestMapping(value="deleteApply.do", method=RequestMethod.GET)
    public String postDeleteApply (Integer aplSeq) {
        applyService.deleteApply(aplSeq);
        
        return "reidrect: attend/breakManage";    
    }


    // ����ٹ� ��û GET          0110 �Դ���
    @RequestMapping(value = "extendApply.do", method=RequestMethod.GET)
    public String overTiemApply(){
        
        return "attend/extendApply";
    }
    
    
    


    // ����_������������ GET            0112 �Դ���        COMPLETE 0116
    @RequestMapping(value="breakManage.do", method=RequestMethod.GET)
    public String absMg(Model model, Authentication auth){
        List<BreakManageList> results = applyService.absMg(auth.getName());
        model.addAttribute("brkList", results);
        
        return "attend/breakManage";
    }
    

    // ����_�ٹ���������/Ȯ�� GET         0121 �Դ���        ~ing....???                 &&&&&&&&&&&&&&&& ��Ʈ ��°��? ���� �𸣰�
    @RequestMapping(value="workManage.do", method=RequestMethod.GET)
    public String getExtList(Model model, Authentication auth){
        List<Apply> results = applyService.getExtList(auth.getName());
        model.addAttribute("extList", results);

        return "attend/workManage";
    }
    
    
    // ����_����ٹ� ��û ���� Page GET       0121 �Դ���        COMPLETE
    @RequestMapping(value="editExtApply.do", method=RequestMethod.GET)
    public String getEditExtList (Model model, Apply apply, Authentication auth, Integer aplSeq) {
        apply.setAplSeq(aplSeq);
        apply.setDrafter(auth.getName());
        Apply results = applyService.getELforEdit(apply);
        model.addAttribute("ELforEdit", results);
        
        return "attend/extApplyEdit";
    }
    
    
    // ����_����ٹ� ��û ���� Page POST      0121 �Դ���        COMPLETE
    @RequestMapping(value="postEditExtApply.do", method = RequestMethod.POST)
    public String postEditExtList (Apply apply, Integer aplSeq, Authentication auth) {
        apply.setAplSeq(aplSeq);
        apply.setDrafter(auth.getName());
        int result = applyService.postEditExtApply(apply);
        
        return "redirect: workManage.do";
    }
    
    
    // ����_����ٹ� ��û ���� POST       0121 �Դ���        COMPLETE
    @RequestMapping(value="deleteExtApply.do", method=RequestMethod.GET)
    public String postDeleteExtList (Integer aplSeq) {
        int result = applyService.postDeleteExtList(aplSeq);
        
        return "redirect: workManage.do";
    }


    // �Ŵ���_������� - isAuth update GET     0114 �Դ���            // ���߿� ���� �ڵ�� ���� validation ������� �ϰ�
    @RequestMapping(value="absManage.do", method=RequestMethod.GET)
    public String absSign(Model model){                         
        List<BreakManageList> results = applyService.breakListMgr();
        model.addAttribute("brkListMgr", results);
        
        return "attend/breakManagement_Mgr";
    }


    // �Ŵ���_������� - isAuth update POST        0115 �Դ���
    @RequestMapping(value="absManage.do", method=RequestMethod.POST)
    public String absReqHandle(Apply apply) {
        System.out.println("�̰� ���� : " + apply.toString());
        applyService.absReqHandle(apply);
        
        return "redirect: absManage.do";
    }
    

    // �Ŵ���_����ٹ����� ����Ʈ - isAuth update GET           0115 �Դ���
    @RequestMapping(value="extManage.do", method=RequestMethod.GET)
    public String extSign(Model model){
        List<BreakManageList> results = applyService.extListMgr();
        model.addAttribute("extListMgr", results);
        
        return "attend/extendManagement_Mgr";
    }
    
    
    // �Ŵ���_����ٹ����� ����Ʈ - isAuth update POST          0115 �Դ���
    @RequestMapping(value="extManage.do", method=RequestMethod.POST)
    public String extReqHandle(Apply apply){
        applyService.extReqHandle(apply);
        
        return "redirect: extManage.do";
    }


    //ī����� ����Ʈ
    public String debitList(){
        return null;
    }


    //ī����� ī���߰�
    public String addDebit(){
        return null;
    }

    
    //��������û ��� ȭ�� �̵�
    @RequestMapping("receiptRegit.do")
    public String receiptReg(){
    	System.out.println("receiptRegit.do.do ��û����");
        return "payment/receiptRegit";
    }


    //��������û ��������������  google Vision API ��û
    @RequestMapping("goVision.do")
    public String goGoogleApi(){
    	System.out.println("goGoogleApi �Լ���û");
    	GoogleVisionService vision = new GoogleVisionService();
    	
    	System.out.println(" vision ���񽺴� ���");
    	
    	
    	
        return null;
    }
    
    
    
    
    
    
    //��������û vision ���� ���� �о�� text�������� �ϰ� ���� Ȯ��
    public String receiptConfirm(){
        return null;
    }


    //���ó��
    public String paymentSignList(){
        return null;
    }


    //���ó������
    public String paymentSignApprov(){
        return null;
    }


    //������Ʈ����
    @RequestMapping("pjtMain.do")
    public String projectList(Model model, HttpServletRequest request){
    	User user = (User) request.getSession().getAttribute("user");
    	List<Project>list = null;
    	//���� �ڵ忡 ���� �Ѹ��� �� �ٸ��� �ϱ�
    	if(user.getAuthCode() == 3) { // PM ȸ���� ���
    		list = projectService.getAllPjtList();
    	} else { //�Ϲ� ȸ���� ���
    		list = projectService.projectList(user.getMail()); //Ư�� ȸ���� ���� ������Ʈ ����Ʈ ��������
    	}
    	model.addAttribute("list",list);
   
        return "project/pjtMain_new";
    }


    //ĭ�ݺ��� ���� �ҷ�����
    @RequestMapping("pjtKanban.do")
    public String kanban(@RequestParam(value="pjtSeq") String pjtSeq, Model model, HttpServletRequest request){
    	
    	System.out.println("Docontorller kanban()");
    	int seq = Integer.parseInt(pjtSeq);
    	Project project = projectService.getProject(seq);
    	List<Task> taskList = projectService.taskList(seq);
    	List<User> pjtMember = projectService.getPjtMember(seq);
    	User user = (User) request.getSession().getAttribute("user");
    	
    	//List<Project>list = projectService.projectList(user.getMail()); //�� ȸ���� ���� ������Ʈ �� ���� �������� ������Ʈ ��������
    	
    	

    	model.addAttribute("user",user);
    	
    	JSONArray jsonArray = new JSONArray();
    	jsonArray.addAll(taskList);
    	model.addAttribute("project", project);
    	model.addAttribute("taskList", jsonArray);
    	model.addAttribute("pjtMember", pjtMember);
    	
        return "project/pjtKanban_new_mine";
        
        
    }
    
    //������Ʈ ��Ȳ �ҷ����� pjtDashBoard.do
    @RequestMapping("pjtDashBoard.do")
    public String pjtDashBoard(Model model, HttpServletRequest request) {
    	User user = (User) request.getSession().getAttribute("user");
    	List<Project>list = null;
    	list = projectService.projectList(user.getMail()); //Ư�� ȸ���� ���� ������Ʈ ����Ʈ ��������
    	model.addAttribute("list",list);
    	return "project/pjt_dashboard";
    }

    //��������
    @RequestMapping("addPMTask.do")
    public String addPMTask(Task task){
    	String[] str = task.getMail().split(",");
    	String mail = str[0];
    	task.setMail(mail);
    	int result = projectService.addPMTask(task);
    	return "redirect: pjtKanban.do?pjtSeq="+task.getPjtSeq();
    }


    //�������� -- 01.28 ����ī ����
    @RequestMapping("taskEdit.do")
    public String taskEdit(Task task){
    	System.out.println("DoController taskEdit() in!!");
        System.out.println("���� ���� ��!!!!"+task.toString());
    	int result = 0;
    	String view = "";
        result = projectService.editTask(task);
        if(result > 0) {
        	view = "redirect: pjtKanban.do?pjtSeq="+task.getPjtSeq();
        } else {
        	view = "pjtMain.do";
        }
    	return view;
    }


    //�����������Է�
    public String addTask(){
        return null;
    }


    //�󼼾�����ȸ
    public String taskDetail(){
        return null;
    }


    //�󼼾��� �Է�
    public String addTaskDetail(){
        return null;
    }


    //�󼼾�������
    public String modiTaskDetail(){
        return null;
    }


    //�󼼾��� ����
    public String delTaskDetail(){
        return null;
    }


    //üũ����Ʈ��ȸ
    public String checkList(){
        return null;
    }


    //üũ����Ʈ �Է�
    public String addCheckList(){
        return null;
    }


    //üũ����Ʈ ������
    public String modiCheckList(){
        return null;
    }


    //üũ����Ʈ����
    public String delCheckList(){
        return null;
    }


    //������Ʈ Ķ����
    public String projectCalendar(){
        return null;
    }


    //������Ʈ �м�
    public String projectChart(){
        return null;
    }


    //ä�� ����
    @RequestMapping("chat.do")
    public String chatMain(Model model, Principal principal) {
    	
    	String mail = principal.getName();
    	User user = memberService.getUser(mail);
    	//ȸ�� ���� �����ϱ�
    	model.addAttribute("user", user);
    	
    	//�� ȸ���� ���� ä�ù� ��� ��������
    	
    	List<ChatRoom> groupChatRoomList = chatService.getGroupChatRoomList(mail);
    	List<String> roomNameList = new ArrayList<String>();
    	
    	for(int i = 0; i < groupChatRoomList.size(); i++) {
    		roomNameList.add(groupChatRoomList.get(i).getChatRoomName());
    	}

    	model.addAttribute("roomNameList", roomNameList);
    	
    	//��� ��� ��������
    	List<User> userList = memberService.getUserList();
    	model.addAttribute("userList", userList);
    	
    	//�⺻ ������ ä������ ����
    	model.addAttribute("chatType", "SELF");
    	
    	return "chat/chatMain3";
    }
    
    
    //�׷� ä�� ����
    @RequestMapping(value = "chatGroup.do", method = RequestMethod.GET)
    public String chatGroup(@RequestParam(value="roomName") String roomName, Model model, Principal principal) {
    	String mail = principal.getName();
    	User user = memberService.getUser(mail);
    	//ȸ�� ���� �����ϱ�
    	model.addAttribute("user", user);    	
    	//�� ȸ���� ���� ä�ù� ��� ��������
    	List<ChatRoom> chatRoomList = chatService.getGroupChatRoomList(mail);
    	List<String> roomNameList = new ArrayList<String>();
    	
    	for(int i = 0; i < chatRoomList.size(); i++) {
    		roomNameList.add(chatRoomList.get(i).getChatRoomName());
    	}

    	model.addAttribute("roomNameList", roomNameList);
    	
    	
    	//��� ��� ��������
    	List<User> userList = memberService.getUserList();
    	model.addAttribute("userList", userList);
    	
    	//�ش� �׷� ä�ù����� ����
    	model.addAttribute("roomName", roomName);
    	model.addAttribute("chatType", "GROUP");
    	
    	return "chat/chatMain_group";
    }
    
    //DM ä�� ����
    @RequestMapping(value = "chatDm.do", method = RequestMethod.GET)
    public String chatDm(@RequestParam(value="dmName") String dmName, @RequestParam(value="dmMail") String dmMail, Model model, Principal principal) {
    	String mail = principal.getName();
    	User user = memberService.getUser(mail);
    	//ȸ�� ���� �����ϱ�
    	model.addAttribute("user", user);    	
    	//�� ȸ���� ���� ä�ù� ��� ��������
    	List<ChatRoom> chatRoomList = chatService.getGroupChatRoomList(mail);
    	List<String> roomNameList = new ArrayList<String>();
    	
    	for(int i = 0; i < chatRoomList.size(); i++) {
    		roomNameList.add(chatRoomList.get(i).getChatRoomName());
    	}

    	model.addAttribute("roomNameList", roomNameList);
    	
    	
    	//��� ��� ��������
    	List<User> userList = memberService.getUserList();
    	model.addAttribute("userList", userList);
    	
    	//�ش� DM ä�ù����� ����
    	model.addAttribute("dmName", dmName);
    	model.addAttribute("dmMail", dmMail);
    	model.addAttribute("chatType", "DM");
    	
    	return "chat/chatMain_DM";
    }
    
  
    
  
    
    
    //������_����߰� ������
   @RequestMapping(value = "addUser.do", method = RequestMethod.GET )
   public String addUser() {
	   System.out.println("Docontroller addUser() get in");
	   return "admin/AddMember";
   }
    
    
    //������_����߰� ����
   @RequestMapping(value = "addUser.do", method = RequestMethod.POST)
   public String addUser(User user, HttpServletRequest request) throws IOException {
	    
	   
	   
    	//���� ���ε� ���ϸ�
    	CommonsMultipartFile file = user.getFile();
    	String filename = file.getOriginalFilename(); //���� ���ϸ�
    	
        String path = request.getServletContext().getRealPath("/upload");
        String fpath = path + "\\" + filename;
        		
        //���� ���� �۾�
    	FileOutputStream fs = new FileOutputStream(fpath); // ������ �ű�ٰ� ���� ������
    	fs.write(file.getBytes());
    	fs.close();
        		
        //DB�� ���� �̸� ����
    	user.setMyPic(filename);
        	
        int result = memberService.addUser(user);
        if(result > 0) {
    		System.out.println("��� �߰� �Ϸ�");
        }
   		
    	return "redirect: adminMain.do";
    }
   	
   
   //������_��� ���� ���� view
   @RequestMapping(value = "modifyUser.do", method = RequestMethod.GET)
   public String modifyUser(@RequestParam(value="mail") String mail, Model model) {
	   //���� ���ؼ� ���� ���Ϸ� ���� ���� �����ͼ� �Ѹ���
	   User user = memberService.getUserInfo(mail);
	   model.addAttribute("user", user);
	   return "admin/ModifyMember";
   }
  
   @RequestMapping(value="teamManagement.do", method= RequestMethod.GET)
   public String teamManagement(Model model) {
	   UserDao userDao = sqlsession.getMapper(UserDao.class);
	   List<TeamList> teamList = userDao.getTeamList();
	   model.addAttribute("teamList", teamList);
	   return "admin/TeamManagement";
   }
   
   
    //��� ��Ʈ ��� ����
	@RequestMapping(value="paymentChart.do", method=RequestMethod.GET)
	public String paymentChart() {
		return "payment/payChart";
	}
    
    
}