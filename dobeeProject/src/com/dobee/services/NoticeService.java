package com.dobee.services;



import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dobee.dao.NoticeDao;
import com.dobee.vo.notice.Notice;
import com.dobee.vo.notice.NoticeFile;
import com.dobee.vo.schedule.NotSchedule;
import com.dobee.vo.schedule.Schedule;

@Service
public class NoticeService {


	 @Autowired
	    private SqlSession sqlsession;
	    
	    public void setSqlsession(SqlSession sqlsession) {
	    	this.sqlsession = sqlsession;
	    }


    //공지사항리스트
    public List<Notice> noticeList(){
        return null;
    }


    //공지사항 글 작성
    public int noticeWrite(Notice n){
    	int result = 0;
    	NoticeDao noticedao =sqlsession.getMapper(NoticeDao.class);
    	result = noticedao.noticeWrite(n);
    	
    	if(result > 0) { //DB에 insert 성공하면
    		result = n.getNotSeq();
    		System.out.println("값 가져오니????"+result);
    	} else { //DB에 insert 실패
    		result = 0; 
    	}
    	
    	return result;

    }
    
  //공지사항 글 작성시 파일 업로드
    public int noticeFileWrite(NoticeFile nf){
    	int result = 0;
    	NoticeDao noticedao =sqlsession.getMapper(NoticeDao.class);
    	result = noticedao.noticeFileWrite(nf);
    	
    	
    	return result;

    }


    //공지사항수정
    public void noticeModi(){

    }


    //공지사항삭제
    public void noticeDel(){

    }


    //공지사항 상세보기
    public Notice getNotice(){
        return null;
    }


    //
}
