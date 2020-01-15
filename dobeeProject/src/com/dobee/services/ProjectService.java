package com.dobee.services;

import com.dobee.dao.ProjectDao;
import com.dobee.vo.project.CheckList;
import com.dobee.vo.project.Project;
import com.dobee.vo.project.ProjectMember;
import com.dobee.vo.project.Task;
import com.dobee.vo.project.TaskDetail;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProjectService {


    @Autowired
    private SqlSession sqlSession;


    //프로젝트메인
    public List<Project> projectList(){
    	List<Project>list = null;
    	ProjectDao projectdao = sqlSession.getMapper(ProjectDao.class);
    	list = projectdao.getPjt();    	
        return list;
    }


    //프로젝트추가
    public int addProject(Project project){
    	int result = 0;
    	ProjectDao projectdao = sqlSession.getMapper(ProjectDao.class);
    	result = projectdao.mkPjt(project);
    	return result;
    }
    
    public int addProjectMember(String pjtName, List<String> pjtMembersMail) {
    	int result = 0;
    	ProjectDao projectdao = sqlSession.getMapper(ProjectDao.class);
    	Map<String, String> map = new HashMap<String, String>();
    	map.put("pjtName", pjtName);
    	for(int i = 0; i<pjtMembersMail.size(); i++) {
    		map.put("mail", pjtMembersMail.get(i).toString());
    	}    	
    	result = projectdao.mkPjtMember(map);
    	return result;
    }


    //프로젝트삭제
    @Transactional
    public int  delProject(int pjtSeq){
    	
//    	int result = 0;
//    	ProjectDao projectdao = sqlSession.getMapper(ProjectDao.class);
//    	result = projectdao.delete(pjtSeq);
    	return 0;
    }


    //업무리스트
    public List<Task> taskList(){
        return null;
    }


    //업무추가_PM
    public void addTaskPM(){

    }


    //업무추가
    public void addTask(){

    }


    //업무수정_PM
    public void modiTaskPM(){

    }


    //업무수정
    public void modiTask(){


    }


    //업무삭제
    public void delTask(){

    }


    //상세업무조회
    public List<TaskDetail> taskDetailList(){
        return null;
    }


    // 상세업무입력
    public void addTaskDetail(){

    }


    //상세업무수정
    public void modiTaskDetail(){

    }


    //상세업무삭제
    public void delTaskDetail(){

    }


    //체크리스트추가
    public void addCheckList(){

    }


    //체크리스트삭제
    public void delCheckList(){

    }


    //체크리스트 조회
    public List<CheckList> checkLists(){
        return null;
    }


    //프로젝트 분석
    public List<Task> projectChart(){
        return null;
    }
}