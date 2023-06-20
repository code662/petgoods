<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");

	// 프로젝트안에 있는 upload 폴더의 실제 물리적 위치
	String dir = request.getServletContext().getRealPath("/pimg");
	System.out.println(dir + " <-- dir");
	
	// 파일 최대 크기 = 10Mbyte
	int max = 1024 * 1024 * 10;
	
	// request객체를 MutipartReqest의 API를 사용할 수 있도록 랩핑
	MultipartRequest mRequest  = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());
	
	// 
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
		response.sendRedirect(request.getContextPath() + "/product/addProduct.jsp");
		return;
	}
	
	// MultipartRequest API를 사용하여 스트림내에서 값을 반환
	// input type="text" 값반환 API
	int categoryNo = Integer.parseInt(mRequest.getParameter("categoryNo"));
	String productName = mRequest.getParameter("productName");
	int productStock = Integer.parseInt(mRequest.getParameter("productStock"));
	int productPrice = Integer.parseInt(mRequest.getParameter("productPrice"));
	String prdouctStatus = mRequest.getParameter("prdouctStatus");
	String productInfo = mRequest.getParameter("productInfo");
	// 디버깅
	System.out.println(categoryNo + " <-- addProductAction categoryNo");
	System.out.println(productName + " <-- addProductAction productName");
	System.out.println(productStock + " <-- addProductAction productStock");
	System.out.println(productPrice + " <-- addProductAction productPrice");
	System.out.println(prdouctStatus + " <-- addProductAction prdouctStatus");
	System.out.println(productInfo + " <-- addProductAction productInfo");
	
	// 
	Product product = new Product();
	product.setCategoryNo(categoryNo);
	product.setProductName(productName);
	product.setProductStock(productStock);
	product.setProductPrice(productPrice);
	product.setProductStatus(prdouctStatus);
	product.setProductInfo(productInfo);
	
	
	// 
	// 
	String productFiletype = mRequest.getContentType("productImg");
	String productOriFilename = mRequest.getOriginalFileName("productImg");
	String productSaveFilename = mRequest.getFilesystemName("productImg");
	// 디버깅
	System.out.println(productFiletype + " <-- addProductAction productFiletype");
	System.out.println(productOriFilename + " <-- addProductAction productOriFilename");
	System.out.println(productSaveFilename + " <-- addProductAction productSaveFilename");
	// 
	// 
	ProductDao pDao = new ProductDao();
	int productNo = pDao.addProduct(product);
	
	ProductImg productImg = new ProductImg();
	productImg.setProductNo(productNo);
	productImg.setProductFiletype(productFiletype);
	productImg.setProductOriFilename(productOriFilename);
	productImg.setProductSaveFilename(productSaveFilename);
	
	int row = pDao.addProductImg(productImg);

	//
	response.sendRedirect(request.getContextPath()+"/product/productList.jsp");
%>