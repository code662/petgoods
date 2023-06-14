<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.io.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";
	
	// 세션 유효성 검사 : 로그인이 되어있지 않으면 home으로 리다이렉션
	if(session.getAttribute("loginId") == null){
		response.sendRedirect(request.getContextPath()+"/home.jsp");
		return;
	}
	
	// 프로젝트안 rimg폴더의 실제 물리적 위치를 반환
	String dir = request.getServletContext().getRealPath("/rimg");

	int maxFileSize = 1024 * 1024 * 100; //100Mbyte
	
	MultipartRequest mRequest = new MultipartRequest(request, dir, maxFileSize, "utf-8", new DefaultFileRenamePolicy());

	// input type="text" 값 반환 API
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewContent = mRequest.getParameter("reviewContent");
	int orderNo = Integer.parseInt(mRequest.getParameter("orderNo"));
	int reviewNo = Integer.parseInt(mRequest.getParameter("reviewNo"));
	// 디버깅
	System.out.println(PURPLE + reviewTitle + " <--reviewTitle modifyReviewAction" + RESET);
	System.out.println(PURPLE + reviewContent + " <--reviewContent modifyReviewAction" + RESET);
	System.out.println(PURPLE + orderNo + " <--orderNo modifyReviewAction" + RESET);
	System.out.println(PURPLE + reviewNo + " <--reviewNo modifyReviewAction" + RESET);
	
	// 변수를 Review타입으로 묶어준다
	ReviewDao rd = new ReviewDao();
	Review review = new Review();
	review.setOrderNo(orderNo);
	review.setReviewTitle(reviewTitle);
	review.setReviewContent(reviewContent);
	review.setReviewNo(reviewNo);
	
	// DB안에 리뷰정보 수정
	int row = rd.modifyReview(review);
	
	// 업로드 파일이 jpg/jpeg/png 파일이 아니면 삭제한 뒤 return
	if( !(mRequest.getContentType("reviewImg").equals("image/jpg")
			||mRequest.getContentType("reviewImg").equals("image/jpeg")
			||mRequest.getContentType("reviewImg").equals("image/png"))){
		//이미 저장된 파일을 삭제 (db에는 아직 저장안됨)
		System.out.println("image 파일이 아닙니다 modifyReviewAction");
		String saveFilename = mRequest.getFilesystemName("reviewImg");
		File f = new File(dir + "\\" + saveFilename);
		if(f.exists()){ //이 파일이 존재하고 있다면 삭제실행
			f.delete();
			System.out.println(saveFilename + "파일삭제 modifyReviewAction");
		}
		response.sendRedirect(request.getContextPath()+"/modifyReview.jsp");
		return;
	}
	// 이전 리뷰이미지 파일 삭제, 새로운 리뷰이미지 파일 추가, 테이블 수정
	if(mRequest.getOriginalFileName("reviewImg")!=null){
		if( !(mRequest.getContentType("reviewImg").equals("image/jpg")
				||mRequest.getContentType("reviewImg").equals("image/jpeg")
				||mRequest.getContentType("reviewImg").equals("image/png"))){
			//이미 저장된 파일을 삭제 (db에는 아직 저장안됨)
			System.out.println("image 파일이 아닙니다 modifyReviewAction");
			String saveFilename = mRequest.getFilesystemName("reviewImg");
			File f = new File(dir + "\\" + saveFilename);
			if(f.exists()){ //이 파일이 존재하고 있다면 삭제실행
				f.delete();
				System.out.println(saveFilename + "파일삭제 modifyReviewAction");
			}
		}else{// 이미지 파일이면 이전파일(saveFilename)삭제, db수정(update)
			String type = mRequest.getContentType("reviewImg");
			String originFilename = mRequest.getOriginalFileName("reviewImg");
			String saveFilename = mRequest.getFilesystemName("reviewImg");
			
			// 변수를 ReviewImg타입으로 묶어준다 
			ReviewImg ri = new ReviewImg();
			ri.setReviewFiletype(type);
			ri.setReviewOriFilename(originFilename);
			ri.setReviewSaveFilename(saveFilename);
			ri.setReviewNo(reviewNo);
			
			//이전파일 삭제
			String preSaveFilename = rd.selectReviewImgSaveFilename(reviewNo);
			File f = new File(dir+"/"+preSaveFilename);
			if(f.exists()){
				f.delete();
			}	
			
			//수정된 파일의 정보로 db를 수정
			int reviewImgRow = rd.modifyReviewImg(ri);
		}
	}
	response.sendRedirect(request.getContextPath()+"/customer/reviewList.jsp");
%>