<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.io.*" %>
<%
	// Ansi코드 //콘솔창에서 글자배경색지정
	final String RESET = "\u001B[0m";	
	final String PURPLE = "\u001B[45m";

	// 프로젝트안 rimg폴더의 실제 물리적 위치를 반환
	String dir = request.getServletContext().getRealPath("/rimg");
	
	int maxFileSize = 1024 * 1024 * 100; //100Mbyte
	
	MultipartRequest mRequest = new MultipartRequest(request, dir, maxFileSize, "utf-8", new DefaultFileRenamePolicy());
	
	// 업로드 파일이 jpg/jpeg/png 파일이 아니면 삭제한 뒤 return
	String msg = null;
	if( !mRequest.getContentType("reviewImg").equals("image/jpg")
			&&!mRequest.getContentType("reviewImg").equals("image/jpeg")
			&&!mRequest.getContentType("reviewImg").equals("image/png")){
		//이미 저장된 파일을 삭제 (db에는 아직 저장안됨)
		System.out.println("image 파일이 아닙니다 addReviewAction");
		String saveFilename = mRequest.getFilesystemName("reviewImg");
		File f = new File(dir + "/" + saveFilename);
		if(f.exists()){ //이 파일이 존재하고 있다면 삭제실행
			f.delete();
			System.out.println(saveFilename + "파일삭제 addReviewAction");
		}
		msg = URLEncoder.encode("image 파일이 아닙니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/addReview.jsp?msg="+msg+"&orderNo="+mRequest.getParameter("orderNo"));
		return;
	}
	
	// input type="text" 값 반환 API
	String reviewTitle = mRequest.getParameter("reviewTitle");
	String reviewContent = mRequest.getParameter("reviewContent");
	int orderNo = Integer.parseInt(mRequest.getParameter("orderNo"));
	// 디버깅
	System.out.println(PURPLE + reviewTitle + " <--reviewTitle addReviewAction" + RESET);
	System.out.println(PURPLE + reviewContent + " <--reviewContent addReviewAction" + RESET);
	System.out.println(PURPLE + orderNo + " <--orderNo addReviewAction" + RESET);
	
	// 변수를 Review타입으로 묶어준다
	Review review = new Review();
	review.setReviewTitle(reviewTitle);
	review.setReviewContent(reviewContent);
	review.setOrderNo(orderNo);
	
	
	// input type="file" 값(파일 메타 정보) 반환 API(원본파일이름, 저장된파일이름, 컨텐츠타입)
	String type = mRequest.getContentType("reviewImg");
	String originFilename = mRequest.getOriginalFileName("reviewImg");
	String saveFilename = mRequest.getFilesystemName("reviewImg");
	// 디버깅
	System.out.println(PURPLE + type + " <--type addReviewAction" + RESET);
	System.out.println(PURPLE + originFilename + " <--originFilename addReviewAction" + RESET);
	System.out.println(PURPLE + saveFilename + " <--saveFilename addReviewAction" + RESET);
			
	// review 테이블에 추가 (DB에 추가)
	ReviewDao rd = new ReviewDao();
	int reviewNo = rd.addReview(review);
	
	// review_img 테이블에 추가 (DB에 추가)
	ReviewImg rimg = new ReviewImg();
	rimg.setReviewFiletype(type);
	rimg.setReviewOriFilename(originFilename);
	rimg.setReviewSaveFilename(saveFilename);
	rimg.setReviewNo(reviewNo);
	int row = rd.addReviewImg(rimg); 
	
	if(row == 1){
		msg = URLEncoder.encode("리뷰가 등록되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/myOrderList.jsp?msg="+msg);
		return;
	}else{
		msg = URLEncoder.encode("리뷰등록에 실패하였습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/customer/myOrderList.jsp?msg="+msg);
	}
%>