package product.model;

public class OrderBean {
	private int order_number;
	private String name;
	private String email;
	private String phone;
	private String address1;
	private String address2;
	private String pname;
	private int pop_out;
	private int point;
	private String requestOrder;
	private String pimage;
	private int productPrice;
	private int using_point;
	private String imp_uid;
	
	
	public String getImp_uid() {
		return imp_uid;
	}
	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}
	public int getOrder_number() {
		return order_number;
	}
	public void setOrder_number(int order_number) {
		this.order_number = order_number;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPop_out() {
		return pop_out;
	}
	public void setPop_out(int pop_out) {
		this.pop_out = pop_out;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getRequestOrder() {
		return requestOrder;
	}
	public void setRequestOrder(String requestOrder) {
		this.requestOrder = requestOrder;
	}
	public String getPimage() {
		return pimage;
	}
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getUsing_point() {
		return using_point;
	}
	public void setUsing_point(int using_point) {
		this.using_point = using_point;
	}
	
}
