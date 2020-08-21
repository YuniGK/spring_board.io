package vo;

public class MemberVo {

	int m_idx;
	String m_id, m_name, m_pwd, m_zipcode, m_addr, m_ip, m_regdate, m_grader;
	
	public MemberVo() {
	}

	//insert	
	public MemberVo(String m_id, String m_name, String m_pwd, String m_zipcode, String m_addr, String m_ip,
			String m_grader) {
		super();
		this.m_id = m_id;
		this.m_name = m_name;
		this.m_pwd = m_pwd;
		this.m_zipcode = m_zipcode;
		this.m_addr = m_addr;
		this.m_ip = m_ip;
		this.m_grader = m_grader;
	}

	//update --최초가입일자를 기록해야하는 부분으로 날짜는 변경되지 않는다.
	public MemberVo(int m_idx, String m_id, String m_name, String m_pwd, String m_zipcode, String m_addr, String m_ip, String m_grader) {
		super();
		this.m_idx = m_idx;
		this.m_id = m_id;
		this.m_name = m_name;
		this.m_pwd = m_pwd;
		this.m_zipcode = m_zipcode;
		this.m_addr = m_addr;
		this.m_ip = m_ip;
		this.m_grader = m_grader;
	}

	public int getM_idx() {
		return m_idx;
	}

	public void setM_idx(int m_idx) {
		this.m_idx = m_idx;
	}
	
	public String getM_id() {
		return m_id;
	}
	
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	
	public String getM_name() {
		return m_name;
	}
	
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	
	public String getM_pwd() {
		return m_pwd;
	}
	
	public void setM_pwd(String m_pwd) {
		this.m_pwd = m_pwd;
	}
	
	public String getM_zipcode() {
		return m_zipcode;
	}
	
	public void setM_zipcode(String m_zipcode) {
		this.m_zipcode = m_zipcode;
	}
	
	public String getM_addr() {
		return m_addr;
	}
	
	public void setM_addr(String m_addr) {
		this.m_addr = m_addr;
	}
	
	public String getM_ip() {
		return m_ip;
	}
	public void setM_ip(String m_ip) {
		this.m_ip = m_ip;
	}
	
	public String getM_regdate() {
		return m_regdate;
	}
	
	public void setM_regdate(String m_regdate) {
		this.m_regdate = m_regdate;
	}
	
	public String getM_grader() {
		return m_grader;
	}
	
	public void setM_grader(String m_grader) {
		this.m_grader = m_grader;
	}
	
}
