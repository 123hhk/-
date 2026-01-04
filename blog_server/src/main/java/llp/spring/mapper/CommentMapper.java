package llp.spring.mapper;

import llp.spring.entity.Comment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.vo.UserCommentVO;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface CommentMapper extends BaseMapper<Comment> {

    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC")
    List<Comment> selectByArticleId(Integer articleId);

    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC limit #{offset} , #{size}")
    List<Comment> getAPageCommentByArticleId(@Param("articleId") Integer articleId, @Param("offset") Integer offset, @Param("size") Integer size);

    // 管理员查询相关
    @Select("<script>" +
            "SELECT * FROM (" +
            "  SELECT c.id, c.content, c.author, c.created, 'COMMENT' as type, " +
            "  c.article_id as articleId, c.article_id as refId, " +
            "  (SELECT title FROM t_article WHERE id = c.article_id) as targetName " +
            "  FROM t_comment c " +
            "  <where><if test='author != null and author != \"\"'> c.author = #{author} </if></where>" +
            " UNION ALL " +
            "  SELECT r.id, r.content, r.author, r.created, 'REPLY' as type, " +
            "  p.article_id as articleId, r.comment_id as refId, " +
            "  (SELECT title FROM t_article WHERE id = p.article_id) as targetName " +
            "  FROM t_reply r " +
            "  LEFT JOIN t_comment p ON r.comment_id = p.id " +
            "  <where><if test='author != null and author != \"\"'> r.author = #{author} </if></where>" +
            ") as tmp ORDER BY created DESC LIMIT #{offset}, #{size}" +
            "</script>")
    List<UserCommentVO> getAdminComments(@Param("offset") int offset, @Param("size") int size, @Param("author") String author);

    @Select("<script>" +
            "SELECT (SELECT COUNT(*) FROM t_comment <where><if test='author!=null and author!=\"\"'>author=#{author}</if></where>) + " +
            "(SELECT COUNT(*) FROM t_reply <where><if test='author!=null and author!=\"\"'>author=#{author}</if></where>)" +
            "</script>")
    Integer countAdminComments(@Param("author") String author);

    @Select("SELECT id, content, author, created, 'COMMENT' as type, article_id as articleId, article_id as refId, (SELECT title FROM t_article WHERE id = t_comment.article_id) as targetName FROM t_comment WHERE author = #{author} " +
            "UNION ALL SELECT r.id, r.content, r.author, r.created, 'REPLY' as type, c.article_id as articleId, r.comment_id as refId, c.content as targetName FROM t_reply r LEFT JOIN t_comment c ON r.comment_id = c.id WHERE r.author = #{author} ORDER BY created DESC")
    List<UserCommentVO> selectCommentsByAuthor(@Param("author") String author);

    // === 点赞相关方法 (确保都在) ===
    @Update("UPDATE t_comment SET likes = likes + 1 WHERE id = #{commentId}")
    void increaseLikes(Integer commentId);

    @Update("UPDATE t_comment SET likes = IF(likes>0, likes - 1, 0) WHERE id = #{commentId}")
    void decreaseLikes(Integer commentId);

    @Select("SELECT COUNT(*) FROM t_comment_like WHERE user_id = #{userId} AND comment_id = #{commentId}")
    Integer countCommentLike(@Param("userId") Integer userId, @Param("commentId") Integer commentId);

    @Insert("INSERT INTO t_comment_like (user_id, comment_id) VALUES (#{userId}, #{commentId})")
    void insertCommentLike(@Param("userId") Integer userId, @Param("commentId") Integer commentId);

    @Delete("DELETE FROM t_comment_like WHERE user_id = #{userId} AND comment_id = #{commentId}")
    void deleteCommentLike(@Param("userId") Integer userId, @Param("commentId") Integer commentId);
}