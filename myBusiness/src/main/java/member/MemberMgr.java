package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import java.security.MessageDigest;

import org.apache.catalina.tribes.util.Arrays;

public class MemberMgr {
	private final static String mSalt = "대한민국";
    
	public static String encodeSha256(String source) {
	        String result = "";
	        byte[] a = source.getBytes();
	        byte[] salt = mSalt.getBytes();
	        byte[] bytes = new byte[a.length + salt.length];
	        
	        System.arraycopy(a, 0, bytes, 0, a.length);
	        System.arraycopy(salt, 0, bytes, a.length, salt.length);
	        
	        try {
	            MessageDigest md = MessageDigest.getInstance("SHA-256");
	            md.update(bytes);
	            
	            byte[] byteData = md.digest();
	            
	            StringBuffer sb = new StringBuffer();
	            for (int i = 0; i < byteData.length; i++) {
	                sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
	            }
	            
	            result = sb.toString();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        
	        return result;
	    }
	private DBConnectionMgr pool;

	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ID 중복확인
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			flag = pstmt.executeQuery().next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 우편번호 검색
	public Vector<ZipcodeBean> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + area3 + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 회원가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblMember(id,pwd,name,gender,birthday,email,zipcode"
					+ ",address,hobby,job,country)values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			/*
			 * String rawPassword = bean.getPwd(); String password =
			 * SHA256.encodeSha256(rawPassword);
			 
			pstmt.setString(2, password); */
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getZipcode());
			pstmt.setString(8, bean.getAddress());
			String hobby[] = bean.getHobby();
			char hb[] = { '0', '0', '0', '0', '0' };
			String lists[] = { "인터넷", "여행", "게임", "영화", "운동" };
			for (int i = 0; i < hobby.length; i++) {
				for (int j = 0; j < lists.length; j++) {
					if (hobby[i].equals(lists[j]))
						hb[j] = '1';
				}
			}
			pstmt.setString(9, new String(hb));
			pstmt.setString(10, bean.getJob());
			pstmt.setString(11, bean.getCountry());
			
			if (pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	// 로그인
	public boolean loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	public String getName(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String name = null;
		try {
			con = pool.getConnection();
			sql = "select name from tblMember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			 if(rs.next()) {
				 name = rs.getString("name");
			 }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return name;
	}
	/*************
	 * ch17 필요한 메소드
	 * ************/

	// 회원정보가져오기
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from tblMember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				String hobbys[] = new String[5];
				String hobby = rs.getString("hobby");// 01001
				for (int i = 0; i < hobbys.length; i++) {
					hobbys[i] = hobby.substring(i, i + 1);
					
				}
				
				bean.setHobby(hobbys);
				bean.setJob(rs.getString("job"));
				bean.setCountry(rs.getString("Country"));
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	public String getJobname(String jobcode) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String jobname = null;
		try {
			con = pool.getConnection();
			String sql = "select jobname from tbljob where jobcode = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, jobcode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				jobname = rs.getString("jobname");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return jobname;
	} 

	// 회원정보수정
	public boolean updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update tblMember set pwd=?, name=?, gender=?, birthday=?,"
					+ "email=?, zipcode=?, address=?, hobby=?, job=?, Country=? where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			char hobby[] = { '0', '0', '0', '0', '0' };
			if (bean.getHobby() != null) {
				String hobbys[] = bean.getHobby();
				String list[] = { "인터넷", "여행", "게임", "영화", "운동" };
				for (int i = 0; i < hobbys.length; i++) {
					for (int j = 0; j < list.length; j++)
						if (hobbys[i].equals(list[j]))
							hobby[j] = '1';
				}
			}
			pstmt.setString(8, new String(hobby));
			pstmt.setString(9, bean.getJob());
			pstmt.setString(10, bean.getId());
			pstmt.setString(11, bean.getCountry());
			int count = pstmt.executeUpdate();
			if (count > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}