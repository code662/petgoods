package vo;

public class Category {
	private int categoryNo;
	private String categoryMainName;
	private String categorySubName;
	private String createdate;
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryMainName() {
		return categoryMainName;
	}
	public void setCategoryMainName(String categoryMainName) {
		this.categoryMainName = categoryMainName;
	}
	public String getCategorySubName() {
		return categorySubName;
	}
	public void setCategorySubName(String categorySubName) {
		this.categorySubName = categorySubName;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	private String updatedate;
}
