package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.model.TownshipBean;

@Repository
public class TownshipRepository {
	public List<TownshipBean> getAllTownship() {
		List<TownshipBean> townshipList = new ArrayList<TownshipBean>();

		Connection con = DBConnection.getConnection();

		String sql = "SELECT t.*, s.name AS state_name FROM township t JOIN state s ON t.state_id = s.id;";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				TownshipBean obj = new TownshipBean();
				obj.setId(rs.getInt("id"));
				obj.setName(rs.getString("name"));
				obj.setStateId(rs.getInt("state_id"));
				obj.setStateName(rs.getString("state_name"));
				townshipList.add(obj);
			}

		} catch (SQLException e) {
			System.out.println("get all township error : " + e.getMessage());
		}

		return townshipList;
	}
}
