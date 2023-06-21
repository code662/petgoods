<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	// utf-8 인코딩 설정
	request.setCharacterEncoding("utf-8");

	// 프로젝트안에 있는 pimg 폴더의 실제 물리적 위치
	String dir = request.getServletContext().getRealPath("/pimg");
	System.out.println(dir + " <-- dir");
	
	// 파일 최대 크기 = 10Mbyte
	int max = 1024 * 1024 * 10;
	
	// request객체를 MutipartReqest의 API를 사용할 수 있도록 랩핑
	MultipartRequest mRequest  = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	// 요청값 유효성 검사
	if(mRequest.getParameter("productNo") == null					// 파라미터 값이 null이거나 공백이면
		|| mRequest.getParameter("categoryNo") == null
		|| mRequest.getParameter("productName") == null
		|| mRequest.getParameter("productStock") == null
		|| mRequest.getParameter("productPrice") == null
		|| mRequest.getParameter("prdouctStatus") == null
		|| mRequest.getParameter("productInfo") == null
		|| mRequest.getParameter("productNo").equals("")
		|| mRequest.getParameter("categoryNo").equals("")
		|| mRequest.getParameter("productName").equals("")
		|| mRequest.getParameter("productStock").equals("")
		|| mRequest.getParameter("productPrice").equals("")
		|| mRequest.getParameter("prdouctStatus").equals("")
		|| mRequest.getParameter("productInfo").equals("")) {
		// 파일이 저장되었다면 삭제하고
		String saveFilename = mRequest.getFilesystemName("productImg");
		File f = new File(dir+"/"+saveFilename);
		if(f.exists()) {
			f.delete();
			System.out.println(saveFilename + "파일삭제");
		}
		// modifyProduct로 가라
		response.sendRedirect(request.getContextPath() + "/product/modifyProduct.jsp?productNo="+mRequest.getParameter("productNo"));
		return;
	}
	// 요청값 변수 저장
	int productNo = Integer.parseInt(mRequest.getParameter("productNo"));
	int categoryNo = Integer.parseInt(mRequest.getParameter("categoryNo"));
	String productName = mRequest.getParameter("productName");
	int productStock = Integer.parseInt(mRequest.getParameter("productStock"));
	int productPrice = Integer.parseInt(mRequest.getParameter("productPrice"));
	String productStatus = mRequest.getParameter("prdouctStatus");
	String productInfo = mRequest.getParameter("productInfo");
	
	ProductDao pDao = new ProductDao();
	// 상품 객체 생성후 파라미터 값 저장 후 DB 수정
	Product product = new Product();
	product.setProductNo(productNo);
	product.setCategoryNo(categoryNo);
	product.setProductName(productName);
	product.setProductStock(productStock);
	product.setProductPrice(productPrice);
	product.setProductStatus(productStatus);
	product.setProductInfo(productInfo);
	pDao.modifyProduct(product);
	
	System.out.println(mRequest.getOriginalFileName("productImg"));
	// 새로운 이미지를 업로드 했을 때 상품 이미지 DB 수정
	if(mRequest.getOriginalFileName("productImg") != null){
		// 파일 타입 검사
		if(!mRequest.getContentType("productImg").equals("image/png") 
			&& !mRequest.getContentType("productImg").equals("image/jpg")
			&& !mRequest.getContentType("productImg").equals("image/jpeg")) {
			// 이미 저장된 파일을 삭제
			System.out.println("이미지 파일이 아닙니다.");
			String saveFilename = mRequest.getFilesystemName("productImg");
			File f = new File(dir+"/"+saveFilename);
			if(f.exists()) {
				f.delete();
				System.out.println(saveFilename + "파일삭제");
			}
			response.sendRedirect(request.getContextPath() + "/product/modifyProduct.jsp?productNo="+mRequest.getParameter("productNo"));
			return;
		} else {
			// 상품 이미지 파라미터 값 변수에 저장
			String productFiletype = mRequest.getContentType("productImg");
			String productOriFilename = mRequest.getOriginalFileName("productImg");
			String productSaveFilename = mRequest.getFilesystemName("productImg");
			
			// 상품 이미지 정보 객체에 저장
			ProductImg pImg = new ProductImg();
			pImg.setProductNo(productNo);
			pImg.setProductFiletype(productFiletype);
			pImg.setProductOriFilename(productOriFilename);
			pImg.setProductSaveFilename(productSaveFilename);
			
			// 이전 파일 삭제
			String preSaveFilename = pDao.productImgName(productNo);
			System.out.println(preSaveFilename);
			System.out.println(dir+"/"+preSaveFilename);
			File f = new File(dir+"/"+preSaveFilename);
			if(f.exists()) {
				f.delete();
			}
			// 새로운 상품 이미지 정보로 DB 수정
			int row = pDao.modifyProductImg(pImg);
		}
	}
	
	response.sendRedirect(request.getContextPath() + "/product/productOne.jsp?productNo="+productNo);
%>