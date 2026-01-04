package llp.spring.mapper;

import llp.spring.entity.Comment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.vo.UserCommentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CommentMapper extends BaseMapper<Comment> {

    // 1. 根据文章ID查评论 (前台用)
    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC")
    List<Comment> selectByArticleId(Integer articleId);

    // 2. 根据文章ID分页查评论 (前台用)
    @Select("SELECT * FROM t_comment WHERE article_id = #{articleId} ORDER BY id DESC limit #{offset} , #{size}")
    List<Comment> getAPageCommentByArticleId(
            @Param("articleId") Integer articleId,
            @Param("offset") Integer offset,
            @Param("size") Integer size
    );

    /***
    // 3. 【核心修复】管理员查询所有评论 + 回复
    // 修复重点：将查询结果别名改为 'articleId'，与前端 ManageComment.vue 需要的字段一致
    @Select("SELECT * FROM (" +
            // --- 查评论 ---
            "  SELECT c.id, c.content, c.author, c.created, 'COMMENT' as type, " +
            "  c.article_id as articleId, " +  // 【修改】这里别名改为 articleId
            "  c.article_id as refId, " +      // (可选)保留 refId 兼容性
            "  (SELECT title FROM t_article WHERE id = c.article_id) as targetName " +
            "  FROM t_comment c " +
            " UNION ALL " +
            // --- 查回复 ---
            "  SELECT r.id, r.content, r.author, r.created, 'REPLY' as type, " +
            "  p.article_id as articleId, " +  // 【修改】这里别名改为 articleId
            "  r.comment_id as refId, " +      // (可选)refId 存 commentId
            "  (SELECT title FROM t_article WHERE id = p.article_id) as targetName " +
            "  FROM t_reply r " +
            "  LEFT JOIN t_comment p ON r.comment_id = p.id " +
            ") as tmp " +
            "ORDER BY created DESC " +
            "LIMIT #{offset}, #{size}")
    List<UserCommentVO> getAdminComments(@Param("offset") int offset, @Param("size") int size);

    // 4. 统计总数
    @Select("SELECT (SELECT COUNT(*) FROM t_comment) + (SELECT COUNT(*) FROM t_reply)")
    Integer countAllCommentsAndReplies();

    ***/
    // 5. 个人中心/管理后台 - 根据作者查询 (修复后)
    // 关键修复：添加 'article_id as articleId' 和 关联查询回复所属的文章ID

    @Select("SELECT id, content, author, created, 'COMMENT' as type, " +
            "article_id as articleId, " + // 【修复】添加 articleId
            "article_id as refId, " +
            "(SELECT title FROM t_article WHERE id = t_comment.article_id) as targetName " +
            "FROM t_comment WHERE author = #{author} " +
            "UNION ALL " +
            "SELECT r.id, r.content, r.author, r.created, 'REPLY' as type, " +
            "c.article_id as articleId, " + // 【修复】通过父评论找到文章ID
            "r.comment_id as refId, " +
            "c.content as targetName " + // 回复的目标名称显示为父评论内容
            "FROM t_reply r " +
            "LEFT JOIN t_comment c ON r.comment_id = c.id " + // 【修复】关联父评论表
            "WHERE r.author = #{author} " +
            "ORDER BY created DESC")
    List<UserCommentVO> selectCommentsByAuthor(@Param("author") String author);

    // 1. 【合并查询】支持按 author 筛选的动态 SQL
    @Select("<script>" +
            "SELECT * FROM (" +
            // --- 查评论 ---
            "  SELECT c.id, c.content, c.author, c.created, 'COMMENT' as type, " +
            "  c.article_id as articleId, c.article_id as refId, " +
            "  (SELECT title FROM t_article WHERE id = c.article_id) as targetName " +
            "  FROM t_comment c " +
            "  <where>" +
            "    <if test='author != null and author != \"\"'> c.author = #{author} </if>" +
            "  </where>" +
            " UNION ALL " +
            // --- 查回复 ---
            "  SELECT r.id, r.content, r.author, r.created, 'REPLY' as type, " +
            "  p.article_id as articleId, r.comment_id as refId, " +
            "  (SELECT title FROM t_article WHERE id = p.article_id) as targetName " +
            "  FROM t_reply r " +
            "  LEFT JOIN t_comment p ON r.comment_id = p.id " +
            "  <where>" +
            "    <if test='author != null and author != \"\"'> r.author = #{author} </if>" +
            "  </where>" +
            ") as tmp " +
            "ORDER BY created DESC " +
            "LIMIT #{offset}, #{size}" +
            "</script>")
    List<UserCommentVO> getAdminComments(@Param("offset") int offset,
                                         @Param("size") int size,
                                         @Param("author") String author); // 【新增参数】


    // 2. 【合并统计】统计总数也需要支持筛选，否则分页计算会错
    @Select("<script>" +
            "SELECT " +
            "(SELECT COUNT(*) FROM t_comment <where><if test='author!=null and author!=\"\"'>author=#{author}</if></where>) + " +
            "(SELECT COUNT(*) FROM t_reply <where><if test='author!=null and author!=\"\"'>author=#{author}</if></where>)" +
            "</script>")
    Integer countAdminComments(@Param("author") String author);


}