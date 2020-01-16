package com.dobee.controller;

import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dobee.services.DebitService;
import com.dobee.vo.CostList;

@Controller
public class DebitController {
	
	@Autowired
	DebitService debitService;
	
	
	//영수증 등록_ 디비에 최종적으로 영수증신청등록하기
    @RequestMapping(value="addFinalReceipt.do", method=RequestMethod.POST)
    public String addReceip(
    		@RequestParam(value="useAt") String useAt, 
    		@RequestParam(value="useDate") Date useDate,
    		@RequestParam(value="cost") int cost,
    		@RequestParam(value="regitReceiptDate") Date regitReceiptDate,
    		@RequestParam(value="detail") String detail,
    		@RequestParam(value="costCode") int costCode,
    		@RequestParam(value="cardNum") String cardNum,
    		@RequestParam(value="mail") String mail) {
    	System.out.println("비용신청 컨트롤단 요청받음! ");
    	System.out.println("useat : "+ useAt);
    	System.out.println("regitReceiptDate : "+ regitReceiptDate);
    	System.out.println("useDate : "+ useDate);
    	System.out.println("cost : "+ cost);
    	System.out.println("detail : "+ detail);
    	System.out.println("costCode: "+ costCode);
    	System.out.println("cardNum : "+ cardNum);
    	System.out.println("mail : "+ mail);
    	System.out.println("컨트롤단 타냐");
    
    	CostList costList = new CostList();
    	costList.setCardNum(cardNum);
    	costList.setCost(cost);
    	costList.setCostCode(costCode);
    	costList.setDetail(detail);
    	costList.setMail(mail);
    	costList.setRegitReceiptDate(regitReceiptDate);
    	costList.setUseAt(useAt);
    	costList.setUseDate(useDate);
    	System.out.println("이거 보이냐 " + costList.toString());
    	int result = debitService.applyDebit(costList);
    	
    	if(result != -1) {
    		System.out.println("컨트롤단 : 비용신청 성공");
    	}else {
    		System.out.println("컨트롤단 : 비용신청 실패");
    		return null;
    	}
    	return "redirect:viewDebitList.do";
    }
    
    
    //비용신청 현황 뷰단 가기
    @RequestMapping("viewDebitList.do")
    public String viewDebit() {
    	return "payment/debitList";
    }
	
	
}
