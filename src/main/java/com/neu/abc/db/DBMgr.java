/**
 * 
 */
package com.neu.abc.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.neu.abc.exceptions.DataAccessException;

/**
 * @author Firec
 *
 */
public class DBMgr {
	private DataSource ds;
	private static final Logger logger = Logger.getLogger(DBMgr.class);

	public void setDs(DataSource ds) {
		this.ds = ds;
	}
	
	public List<String> queryForOneRow(String sql, List<String> params, int colNum)throws DataAccessException{
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		List<String> resultList = new ArrayList<String>();
		try {
			con = ds.getConnection();
			pst = con.prepareStatement(sql);

			for (int i =0; i < params.size(); i++) {
				pst.setString(i+1, params.get(i));
			}
			rs = pst.executeQuery();
			if (rs.next()) {
				for (int i = 1; i <= colNum; i++) {
					resultList.add(rs.getString(i));
				}
			}
		} catch (SQLException ex) {
			logger.error("SQL Error:" + sql, ex);
			throw new DataAccessException(ex);
		} finally {
			close(con, pst, rs);
		}
		return resultList;
	}
	
	public List<String> queryForOneCol(String sql, List<String> params)throws DataAccessException{
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		List<String> resultList = new ArrayList<String>();
		try {
			con = ds.getConnection();
			pst = con.prepareStatement(sql);

			for (int i =0; i < params.size(); i++) {
				pst.setString(i+1, params.get(i));
			}
			rs = pst.executeQuery();
			while (rs.next()) {
				resultList.add(rs.getString(1));
			}
		} catch (SQLException ex) {
			logger.error("SQL Error:" + sql, ex);
			throw new DataAccessException(ex);
		} finally {
			close(con, pst, rs);
		}
		return resultList;
	}

	public List<List<String>> executeQuerySQL(String sql, List<String> params, int colNum)
	throws DataAccessException{
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		List<List<String>> resultList = new ArrayList<List<String>>();
		try {
			con = ds.getConnection();
			pst = con.prepareStatement(sql);

			for (int i = 0; i < params.size(); i++) {
				pst.setString(i+1, params.get(i));
			}
			rs = pst.executeQuery();
			while (rs.next()) {
				List<String> data = new ArrayList<String>();
				for (int i = 1; i <= colNum; i++) {
					data.add(rs.getString(i));
				}
				resultList.add(data);
			}
		} catch (SQLException ex) {
			logger.error("SQL Error:" + sql, ex);
			throw new DataAccessException(ex);
		} finally {
			close(con, pst, rs);
		}
		return resultList;
	}
	
	public boolean executeUpdateSQL(String sql, List<String> params)throws DataAccessException {
		Connection con = null;
		PreparedStatement pst = null;
		try {
			con = ds.getConnection();
			pst = con.prepareStatement(sql);
			for (int i = 0; i < params.size(); i++) {
				pst.setString(i+1, params.get(i));
			}
			pst.executeUpdate();
			return true;
		} catch (SQLException ex) {
			logger.error("SQL Error:" + sql, ex);
			throw new DataAccessException(ex);
		} finally {
			close(con, pst, null);
		}
	}
	
	public boolean executeBatch(List<String> sqls)throws DataAccessException {
		Connection con = null;
		Statement st = null;
		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			st = con.createStatement();
			for(int i=0;i<sqls.size();i++){
				st.addBatch(sqls.get(i));
			}
			st.executeBatch();
			return true;
		} catch (SQLException ex) {
			logger.error("SQL Error:" + sqls, ex);
			throw new DataAccessException(ex);
		} finally {
			if(st!=null){
				try{
				st.close();
				}catch(Exception e){
					logger.error("SQL Error: Close Batch Statement." , e);
					throw new DataAccessException(e);
				}
			}
			close(con, null, null);
		}
	}

	private void close(Connection con, PreparedStatement pst, ResultSet rs) throws DataAccessException{
		try {
			if (rs != null) {
				rs.close();
			}
			if (pst != null) {
				pst.close();
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception ex) {
					logger.error("Failed to close connection - DBMgr", ex);
				}
			}
		} catch (Exception e1) {
			logger.error("Failed to close connection - DBMgr", e1);
		}

	}

	public void testDB() {
		Connection con = null;
		try {
			con = ds.getConnection();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select a from neu.dual");
			while (rs.next()) {
				System.out.println("personName: " + rs.getString(1));
			}
			rs.close();
			st.close();
		} catch (SQLException ex) {
			Logger.getLogger(DBMgr.class).error("E", ex);
		} finally {
			if (con != null)
				try {
					con.close();
				} catch (Exception ignore) {
				}
		}
	}
}
