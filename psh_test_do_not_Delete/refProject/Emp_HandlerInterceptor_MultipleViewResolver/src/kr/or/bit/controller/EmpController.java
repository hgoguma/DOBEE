package kr.or.bit.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import kr.or.bit.dao.EmpdaoInterface;
import kr.or.bit.dto.Emp;

@Controller
public class EmpController {
   private SqlSession sqlsession;
   @Autowired   
   public void setSqlsession(SqlSession sqlsession) {
      this.sqlsession = sqlsession;
   }
   @RequestMapping("/index.do") //   /index.htm
	public String index() {
		//return "index.jsp"; Tiles ������
		 return "index";  //*.*  > {1} > home  ...  {2} > index
	}
   @RequestMapping("/login.do")
   public String login() {
      return "login";
   }
   @RequestMapping("/emplist.do") //    /customer/notice.htm
   public String notices(Model model) {
      //DAO ������ �޾ƿ���
            List<Emp> list=null;
                 EmpdaoInterface noticedao=sqlsession.getMapper(EmpdaoInterface.class);
                 list = noticedao.getEmpList();
                 System.out.println("������ �ϴ�?"+list);
            model.addAttribute("emplist", list); //view���� ���� (forward)
            
      return  "empList"; //"notice.jsp";
   }
   
   
   @RequestMapping(value="/empAdd.do",method=RequestMethod.GET)
   public String noticeReg() {
      return  "empAdd";//"noticeReg.jsp";
   }
   @RequestMapping(value="/empInsert.do",method=RequestMethod.POST)
   public String empInsert(Emp emp) throws IOException, ClassNotFoundException, SQLException {
	   System.out.println("�μ�Ʈ Ÿ���ϴ�??");
      EmpdaoInterface empdao = sqlsession.getMapper(EmpdaoInterface.class);
      empdao.insertEmp(emp);
      return "redirect:/emplist.do"; //����ִ� �ּ� ...
   }
   @RequestMapping("/empDelete.do")
   public String empDel(int empno) throws ClassNotFoundException, SQLException {
      EmpdaoInterface empdao=sqlsession.getMapper(EmpdaoInterface.class);
      empdao.deleteEmp(empno);
      return "redirect:/emplist.do";
   }

   @RequestMapping(value="/empUpdate.do", method=RequestMethod.GET)
   public String empEdit(int empno, Model model) throws ClassNotFoundException, SQLException {
      
      EmpdaoInterface empdao=sqlsession.getMapper(EmpdaoInterface.class);
      Emp emp = empdao.getEmpByEmpno(empno);
      System.out.println("���� �н� : "+emp.getFile_path());
      System.out.println("������ : "+emp.getFiles());
      model.addAttribute("emp", emp);
      return   "empEdit";//"noticeEdit.jsp";
   }
   @RequestMapping(value="/empUpdateOk.do", method=RequestMethod.POST)
   public String empEdit(Emp emp , HttpServletRequest request) throws IOException, ClassNotFoundException, SQLException {
      System.out.println("�� �̰� Ÿ���ϴ�???");
      List<CommonsMultipartFile> files = emp.getFiles();
      List<String> filenames = new ArrayList<String>(); //���ϸ����
      
      if(files != null && files.size() > 0) { //�ּ� 1���� ���ε尡 �ִٸ� 
         for(CommonsMultipartFile multifile : files) {
            String filename = multifile.getOriginalFilename();
            String path = request.getServletContext().getRealPath("/uploads");
            
            String fpath = path + "\\"+ filename; 
            
            if(!filename.equals("")) { //�� ���� ���ε�
               FileOutputStream fs = new FileOutputStream(fpath);
               fs.write(multifile.getBytes());
               fs.close();
            }
            filenames.add(filename); //���ϸ��� ���� ���� (DB insert)
         }
         
      }
            
      //DB ���ϸ� ����
      emp.setFile_path(filenames.get(0));
      
      EmpdaoInterface empdao=sqlsession.getMapper(EmpdaoInterface.class);
      empdao.editEmpOk(emp);
      return "redirect:/emplist.do";
   }
}