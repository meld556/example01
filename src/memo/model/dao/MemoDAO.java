package memo.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import _config.DB;
import memo.model.dto.MemoDTO;

public class MemoDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public ArrayList<MemoDTO> getSelectAll(String searchGubun, String searchData) {
		ArrayList<MemoDTO> list = new ArrayList<>();
		
		if(searchGubun == null || searchGubun.trim().equals("")) {
			searchGubun = "";
		}
		
		if(searchData == null || searchData.trim().equals("")) {
			searchData = "";
		} else {
			searchData = "%" + searchData + "%";
		}
		
		if(searchGubun.equals("") || searchData.equals("")) {
			searchGubun = "";
			searchData = "";
		}
		
		try {
			conn = DB.dbConn();
			//-------------------------------------------
			String basicSql = "select * from memo ";
			
			if(searchGubun.equals("") || searchData.equals("")) {
				
			} else if(searchGubun.equals("name")) {
				basicSql += "where name like ?";
			} else if(searchGubun.equals("memo")) {
				basicSql += "where memo like ?";
			} else if(searchGubun.equals("name_memo")) {
				basicSql += "where name like ? or memo like ?";
			}
			
			basicSql += "order by no desc";
			
			pstmt = conn.prepareStatement(basicSql);
			
			if(searchGubun.equals("") || searchData.equals("")) {
			} else if(searchGubun.equals("name")) {
				pstmt.setString(1, searchData);
			} else if(searchGubun.equals("memo")) {
				pstmt.setString(1, searchData);
			} else if(searchGubun.equals("name_memo")) {
				pstmt.setString(1, searchData);
				pstmt.setString(2, searchData);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemoDTO dto = new MemoDTO();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setMemo(rs.getString("memo"));
				dto.setRegiDate(rs.getDate("regiDate"));
				
				list.add(dto);
			}
			//-------------------------------------------
		} catch(Exception e) {
			System.out.println("getSelectAll 처리중 오류");
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return list;
	}
	
	public MemoDTO getSelectOne(MemoDTO paramDto) {
		MemoDTO dto = new MemoDTO();
		try {
			conn = DB.dbConn();
			//-------------------------------------------
			String sql = "select * from memo where no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNo());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setMemo(rs.getString("memo"));
				dto.setRegiDate(rs.getDate("regiDate"));
			}
			//-------------------------------------------
		 } catch(Exception e) {
			System.out.println("getSelectOne 처리중 오류");
		 } finally {
			DB.dbConnClose(rs, pstmt, conn);
		 }
		return dto;
	}
	
	public int setInsert(MemoDTO paramDto) {
		int result = 0;
		try {
			conn = DB.dbConn();
			//-------------------------------------------
			String sql = "insert into memo values (seq_memo.nextval, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getName());
			pstmt.setString(2, paramDto.getMemo());
			result = pstmt.executeUpdate();
			//-------------------------------------------
		 } catch(Exception e) {
			System.out.println("insert 처리중 오류");
		 } finally {
			DB.dbConnClose(rs, pstmt, conn);
		 }
		
		return result;
	}
	
	public int setDelete(MemoDTO paramDto) {
		int result = 0;
		try {
			 conn = DB.dbConn();
			 //-------------------------------------------
				String sql = "delete from memo where no = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, paramDto.getNo());
				result = pstmt.executeUpdate();
			 //-------------------------------------------
		 } catch(Exception e) {
			 
		 } finally {
			 DB.dbConnClose(rs, pstmt, conn);
		 }
		
		return result;
	}
	
}
