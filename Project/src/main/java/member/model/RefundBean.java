package member.model;

public class RefundBean {
	private int refund_number;
	private String member_id;
	private String pname;
	private String pop_out;
	private String reason;
	private int state;
	
	public int getRefund_number() {
		return refund_number;
	}
	public void setRefund_number(int refund_number) {
		this.refund_number = refund_number;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPop_out() {
		return pop_out;
	}
	public void setPop_out(String pop_out) {
		this.pop_out = pop_out;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
}
