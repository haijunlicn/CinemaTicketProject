package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.model.StateBean;

@Repository
public class StateRepository {
	public List<StateBean> getAllState() {
		List<StateBean> stateList = new ArrayList<StateBean>();

		Connection con = DBConnection.getConnection();

		String sql = "SELECT * FROM `state`";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				StateBean obj = new StateBean();
				obj.setId(rs.getInt("id"));
				obj.setName(rs.getString("name"));
				stateList.add(obj);
			}

		} catch (SQLException e) {
			System.out.println("get all state error : " + e.getMessage());
		}

		return stateList;
	}
}
