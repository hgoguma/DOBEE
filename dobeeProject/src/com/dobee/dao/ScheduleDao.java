package com.dobee.dao;

import java.util.List;

import com.dobee.vo.schedule.MainSchedule;
import com.dobee.vo.schedule.Schedule;

public interface ScheduleDao {

    //일정 등록 -- 01.21 알파카 수정
    public int addSchedule(Schedule sc);
    
    //일정 가져오기  -- 01.21 알파카 수정
    public Schedule getSchedule(int schSeq);
    
    //일정 수정하기 -- 01.22 알파카
    public int scheduleModify(Schedule sc);
    
    // 공지사항 일정 캘린더 병합		0130	게다죽		~ing
    public List<MainSchedule> noticeToCalendar();
    
}
