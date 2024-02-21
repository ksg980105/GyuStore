package member.model;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class MemberBean {
	@NotEmpty(message = "아이디를 입력하세요")
	@Size(max = 10, message = "10글자이하로 입력하세요")
	private String member_id;
	@NotEmpty(message = "닉네임을 입력하세요")
	@Size(max = 6, message = "6글자이하로 입력하세요")
	private String nickname;
	@NotEmpty(message = "이름을 입력하세요")
	@Size(max = 5, message = "5글자이하로 입력하세요")
	private String name;
	@NotEmpty(message = "비밀번호를 입력하세요")
	private String password;
	@NotEmpty(message = "비밀번호확인을 입력하세요")
	private String repassword;
	@NotEmpty(message = "전화번호를 입력하세요")
	@Pattern(regexp = "^[0-9]+$", message = "숫자만 입력가능")
	private String phone;
	@NotEmpty(message = "이메일을 입력하세요")
	private String email;
	@NotEmpty(message = "주소를 입력하세요")
	private String address1;
	@NotEmpty(message = "상세주소를 입력하세요")
	private String address2;
	
	
	public String getRepassword() {
		return repassword;
	}
	public void setRepassword(String repassword) {
		this.repassword = repassword;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	
}
