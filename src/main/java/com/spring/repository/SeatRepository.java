package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.model.SeatBean;

@Repository
public class SeatRepository {

	public List<SeatBean> getSeatsByCinemaId(int cinemaId) {
		List<SeatBean> seatList = new ArrayList<SeatBean>();

		Connection con = DBConnection.getConnection();

		String sql = "SELECT * FROM `seat` WHERE cinema_id = ? and status = ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, cinemaId);
			ps.setInt(2, 1);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				SeatBean obj = new SeatBean();
				obj.setId(rs.getInt("id"));
				obj.setCinemaId(rs.getInt("cinema_id"));
				obj.setSeatNum(rs.getString("seat_num"));
				obj.setRow(rs.getInt("row"));
				obj.setCol(rs.getInt("col"));
				obj.setSeatTypeId(rs.getString("seat_type_id"));
				obj.setPrice(rs.getDouble("price"));
				obj.setCurrencyType(rs.getString("currency_type"));
				obj.setStatus(rs.getInt("status"));
				seatList.add(obj);
			}

		} catch (SQLException e) {
			System.out.println("getSeatsByCinemaId error : " + e.getMessage());
		}

		return seatList;
	}

}
