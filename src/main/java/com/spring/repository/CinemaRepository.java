package com.spring.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Repository;

import com.spring.model.CinemaBean;

@Repository
public class CinemaRepository {
	public List<CinemaBean> getAllCinema() {
		List<CinemaBean> cinemaList = new ArrayList<CinemaBean>();

		Connection con = DBConnection.getConnection();

		String sql = "SELECT c.*, t.name AS township_name, s.name AS state_name " + "FROM cinema c "
				+ "JOIN township t ON c.township_id = t.id " + "JOIN state s ON t.state_id = s.id " + "ORDER BY c.id;";

		try {
			PreparedStatement ps = con.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				CinemaBean obj = new CinemaBean();
				obj.setId(rs.getInt("id"));
				obj.setName(rs.getString("name"));
				obj.setTownshipId(rs.getInt("township_id"));
				obj.setTownshipName(rs.getString("township_name"));
				obj.setStateName(rs.getString("state_name"));
				obj.setTotalSeats(rs.getInt("total_seats"));
				obj.setRowCount(rs.getInt("row_count"));
				obj.setColCount(rs.getInt("col_count"));
				obj.setLat(rs.getString("lat"));
				obj.setLon(rs.getString("long"));
				obj.setStatus(rs.getInt("status"));
				cinemaList.add(obj);
			}

		} catch (SQLException e) {
			System.out.println("get cinema error : " + e.getMessage());
		}

		return cinemaList;
	}

	public CinemaBean getCinemaById(int cinemaId) {
		CinemaBean obj = new CinemaBean();

		Connection con = DBConnection.getConnection();
		String sql = "SELECT c.*, t.name AS township_name, s.id AS state_id, s.name AS state_name " + "FROM cinema c "
				+ "JOIN township t ON c.township_id = t.id " + "JOIN state s ON t.state_id = s.id " + "WHERE c.id = ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, cinemaId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				obj.setId(rs.getInt("id"));
				obj.setName(rs.getString("name"));
				obj.setTownshipId(rs.getInt("township_id"));
				obj.setTownshipName(rs.getString("township_name"));
				obj.setStateId(rs.getInt("state_id"));
				obj.setStateName(rs.getString("state_name"));
				obj.setTotalSeats(rs.getInt("total_seats"));
				obj.setRowCount(rs.getInt("row_count"));
				obj.setColCount(rs.getInt("col_count"));
				obj.setLat(rs.getString("lat"));
				obj.setLon(rs.getString("long"));
				obj.setStatus(rs.getInt("status"));
			}

		} catch (SQLException e) {
			System.out.println("get cinema by id error : " + e.getMessage());
		}

		return obj;
	}

	public int addNewCinema(CinemaBean cinemaObj) {
		int i = -1;

		Connection con = DBConnection.getConnection();

		String sql = "INSERT INTO `cinema`(`name`, `township_id`, `total_seats`, "
				+ "`row_count`, `col_count`, `lat`, `long`, `status`) " + "VALUES (?,?,?,?,?,?,?,?)";

		try {
			PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, cinemaObj.getName());
			ps.setInt(2, cinemaObj.getTownshipId());
			ps.setInt(3, cinemaObj.getTotalSeats());
			ps.setInt(4, cinemaObj.getRowCount());
			ps.setInt(5, cinemaObj.getColCount());
			ps.setString(6, cinemaObj.getLat());
			ps.setString(7, cinemaObj.getLon());
			ps.setInt(8, cinemaObj.getStatus());
			i = ps.executeUpdate();

			if (i > 0) {
				try (ResultSet rs = ps.getGeneratedKeys()) {
					if (rs.next()) {
						int generatedId = rs.getInt(1);
						System.out.println("Inserted cinema with ID: " + generatedId);
						return generatedId;
					}
				}
			} else {
				System.out.println("No cinema inserted.");
			}
		} catch (SQLException e) {
			System.out.println("add cinema error : " + e.getMessage());
		}

		return i;
	}

	public int updateCinema(CinemaBean cinemaObj) {
		int i = -1;

		Connection con = DBConnection.getConnection();

		String sql = "UPDATE `cinema` SET `name` = ?, `township_id` = ?, `total_seats` = ?, "
				+ "`row_count` = ?, `col_count` = ?, `lat` = ?, `long` = ?, `status` = ? " + "WHERE `id` = ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, cinemaObj.getName());
			ps.setInt(2, cinemaObj.getTownshipId());
			ps.setInt(3, cinemaObj.getTotalSeats());
			ps.setInt(4, cinemaObj.getRowCount());
			ps.setInt(5, cinemaObj.getColCount());
			ps.setString(6, cinemaObj.getLat());
			ps.setString(7, cinemaObj.getLon());
			ps.setInt(8, cinemaObj.getStatus());
			ps.setInt(9, cinemaObj.getId());
			i = ps.executeUpdate();

			/*
			 * if (i > 0) { try (ResultSet rs = ps.getGeneratedKeys()) { if (rs.next()) {
			 * int generatedId = rs.getInt(1); System.out.println("Updated cinema with ID: "
			 * + generatedId); return generatedId; } } } else {
			 * System.out.println("No cinema inserted."); }
			 */
		} catch (SQLException e) {
			System.out.println("update cinema error : " + e.getMessage());
		}

		return i;
	}

	public void updateCinemaShowtimes(int cinemaId, List<Integer> showtimeIds) {
		Connection con = DBConnection.getConnection();

		// SQL for inserting new showtimes that don't already exist
		String insertSql = "INSERT INTO cinema_showtime (cinema_id, showtime_id) "
				+ "SELECT ?, ? WHERE NOT EXISTS (SELECT 1 FROM cinema_showtime WHERE cinema_id = ? AND showtime_id = ?)";

		// SQL for deleting showtimes that are not in the provided list
		String deleteSql = "DELETE FROM cinema_showtime WHERE cinema_id = ? AND showtime_id NOT IN (?)";

		try {
			// Convert the showtimeIds list to a comma-separated string for the SQL query
			String showtimeIdsStr = showtimeIds.stream().map(String::valueOf).collect(Collectors.joining(","));

			// Delete showtimes that are not in the provided list
			PreparedStatement deletePs = con.prepareStatement(deleteSql);
			deletePs.setInt(1, cinemaId); // Set cinemaId
			deletePs.setString(2, showtimeIdsStr); // Set the comma-separated list of showtimeIds
			deletePs.executeUpdate(); // Execute delete query

			// Insert new showtimes that don't already exist
			PreparedStatement insertPs = con.prepareStatement(insertSql);
			for (int showtimeId : showtimeIds) {
				insertPs.setInt(1, cinemaId);
				insertPs.setInt(2, showtimeId);
				insertPs.setInt(3, cinemaId); // Set cinemaId for the check
				insertPs.setInt(4, showtimeId); // Set showtimeId for the check
				insertPs.addBatch(); // Add to batch
			}
			insertPs.executeBatch(); // Execute batch insert

		} catch (SQLException e) {
			System.out.println("Error updating cinema showtimes: " + e.getMessage());
		}
	}
	
	public int hardDeleteCinema(int cinemaId) {
		int i = 0;

		Connection con = DBConnection.getConnection();
		String sql = "DELETE FROM `cinema` WHERE id = ?";

		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, cinemaId);
			i = ps.executeUpdate();
		} catch (SQLException e) {
			System.out.println("delete cinema error : " + e.getMessage());
		}

		return i;
	}

}
