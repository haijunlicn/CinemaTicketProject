package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.spring.model.AccountBean;

@Repository
public class AccountRepository {

	public AccountBean loginAccount(AccountBean user) {
		AccountBean obj = null;

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM `account` WHERE email = ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user.getEmail());
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				obj = new AccountBean();
				obj.setId(rs.getInt("id"));
				obj.setName(rs.getString("name"));
				obj.setEmail(rs.getString("email"));
				obj.setPassword(rs.getString("password"));
				obj.setRoleId(rs.getInt("role_id"));
				obj.setAssignedCinemaId(rs.getInt("assigned_cinema_id"));
				obj.setStatus(rs.getInt("status"));
			}

		} catch (SQLException e) {
			System.out.println("admin login error : " + e.getMessage());
		}

		return obj;
	}

	public boolean checkEmailDuplicate(String email) {
		boolean result = false;

		Connection con = DBConnection.getConnection();
		String sql = "SELECT * FROM `account` WHERE email = ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				result = true;
			}

		} catch (SQLException e) {
			System.out.println("check email dup error : " + e.getMessage());
		}

		return result;
	}
}
