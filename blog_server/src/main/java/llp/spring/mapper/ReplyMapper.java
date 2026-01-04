package llp.spring.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.Reply;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ReplyMapper extends BaseMapper<Reply> {

    // 【核心修改】关联查询：同时查出 发送者信息(u1) 和 目标用户信息(u2)
    @Select("SELECT r.*, " +
            "u1.username AS username, u1.avatar AS avatar, " +
            "u2.username AS targetName " +
            "FROM t_reply r " +
            "LEFT JOIN t_user u1 ON r.user_id = u1.id " +
            "LEFT JOIN t_user u2 ON r.to_uid = u2.id " +
            "WHERE r.comment_id = #{commentId} " +
            "ORDER BY r.created ASC " +
            "LIMIT #{offset}, #{size}")
    List<Reply> getRepliesByCommentId(@Param("commentId") Integer commentId,
                                      @Param("offset") int offset,
                                      @Param("size") int size);
    // 统计某评论下的子评论数量
    @Select("SELECT COUNT(*) FROM t_reply WHERE comment_id = #{commentId}")
    Integer countByCommentId(@Param("commentId") Integer commentId);
}