package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import member.MemberVO;
import util.JDBCUtil;

public class BoardDAO {
	Connection conn;
	PreparedStatement pstmt;

	final String sql_selectAll = "SELECT * FROM BOARD ORDER BY BID DESC LIMIT 0,?"; 
	// 더보기 구현 , 더보기를 몇 번 누르냐의 땨라 다름 
	final String sql_selectAll_R = "SELECT * FROM REPLY WHERE BID = ? ORDER BY RID DESC";

	final String sql_insert = "INSERT INTO BOARD(MID,MSG) VALUES(?,?)";
	final String sql_delete = "DELETE FROM BOARD WHERE BID = ?";
	final String sql_update = "UPDATE BOARD SET FAVCNT = FAVCNT +1 WHERE BID = ?";

	final String sql_insert_R="INSERT INTO REPLY(MID,BID,RMSG) VALUES(?,?,?)";
	final String sql_delete_R="DELETE FROM REPLY WHERE RID = ?";
	final String sql_deleteAll_R="DELETE FROM REPLY WHERE BID = ?";

	public boolean update(BoardVO bvo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_update);
			pstmt.setInt(1, bvo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}

	public boolean deleteR(ReplyVO rvo) { // 댓글 삭제
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_delete_R);
			pstmt.setInt(1, rvo.getRid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}

	public boolean deleteB(BoardVO bvo) { // 게시글 삭제 (게시글이 삭제 되면 댓글도 다 삭제)
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_delete); // 게시글 삭제
			pstmt.setInt(1, bvo.getBid());
			pstmt.executeUpdate();

			pstmt=conn.prepareStatement(sql_deleteAll_R); // 삭제한 게시글에 모든 댓글 삭제
			pstmt.setInt(1, bvo.getBid());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}

	public boolean insertB(BoardVO bvo) { // 게시글 추가
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_insert);
			pstmt.setString(1, bvo.getMid());
			pstmt.setString(2, bvo.getMsg());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}

	public boolean insertR(ReplyVO rvo) { // 댓글 추가
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_insert_R);
			pstmt.setString(1, rvo.getMid());
			pstmt.setInt(2, rvo.getBid());
			pstmt.setString(3, rvo.getRmsg());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}

	public ArrayList<BoardSet> selectAll(BoardVO bvo){ // 첫 화면에 모든 게시글을 보여줘야 하는 용도
		// 지금 당장 안 쓰더라도 유지보스를 위해 인자값 설정
		ArrayList<BoardSet> datas = new ArrayList<BoardSet>();
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_selectAll);
			pstmt.setInt(1, bvo.getCnt());
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardSet bs = new BoardSet();

				BoardVO boardVO = new BoardVO(); // BoardSet의 멤버변수 1
				boardVO.setBid(rs.getInt("BID"));
				boardVO.setFavcnt(rs.getInt("FAVCNT")); // 작성일 11:23:00 -> 11시23분에 작성됨으로 모델이 뷰를 도와줄수있음
				boardVO.setMid(rs.getString("MID"));
				boardVO.setMsg(rs.getString("MSG"));
				boardVO.setRcnt(rs.getInt("RCNT")); // rList.size(); 를 사용가능 그러므로 디비비용절감을 생각했다!
				bs.setBoardVO(boardVO);

				ArrayList<ReplyVO> rList = new ArrayList<ReplyVO>(); // BoardSet의 멤버변수 2
				pstmt=conn.prepareStatement(sql_selectAll_R); // 모든 댓글 sql 불러오기
				pstmt.setInt(1, rs.getInt("BID")); // 현재 BID
				ResultSet rs2=pstmt.executeQuery();

				while(rs2.next()) { // 반복문을 이용해 모든 댓글 저장
					ReplyVO replyVO = new ReplyVO();
					replyVO.setBid(rs2.getInt("BID"));
					replyVO.setMid(rs2.getString("MID"));
					replyVO.setRid(rs2.getInt("RID"));
					replyVO.setRmsg(rs2.getString("RMSG"));

					rList.add(replyVO);
				}
				bs.setrList(rList);

				datas.add(bs);

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}

		return datas;
	}
}
