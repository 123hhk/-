package llp.spring.mapper;

import llp.spring.entity.Statistic;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.*;

@Mapper
public interface StatisticMapper extends BaseMapper<Statistic> {

    @Select("SELECT * FROM t_statistic WHERE article_id=#{articleId}")
    public Statistic selectByArticleId(Integer articleId);

    // 统计总点击量
    @Select("SELECT IFNULL(SUM(hits), 0) FROM t_statistic")
    Long getTotalHits();

    // 统计总评论数
    @Select("SELECT IFNULL(SUM(comments_num), 0) FROM t_statistic")
    Long getTotalComments();

    // === 点赞相关 ===

    // 1. 点赞数 +1
    @Update("UPDATE t_statistic SET likes = likes + 1 WHERE article_id = #{articleId}")
    void increaseLikes(Integer articleId);

    // 2. 点赞数 -1 (防止减成负数)
    @Update("UPDATE t_statistic SET likes = IF(likes>0, likes - 1, 0) WHERE article_id = #{articleId}")
    void decreaseLikes(Integer articleId);

    // 3. 查询是否点过赞
    @Select("SELECT COUNT(*) FROM t_article_like WHERE user_id = #{userId} AND article_id = #{articleId}")
    Integer countArticleLike(@Param("userId") Integer userId, @Param("articleId") Integer articleId);

    // 4. 插入点赞记录
    @Insert("INSERT INTO t_article_like (user_id, article_id) VALUES (#{userId}, #{articleId})")
    void insertArticleLike(@Param("userId") Integer userId, @Param("articleId") Integer articleId);

    // 5. 删除点赞记录 (取消点赞)
    @Delete("DELETE FROM t_article_like WHERE user_id = #{userId} AND article_id = #{articleId}")
    void deleteArticleLike(@Param("userId") Integer userId, @Param("articleId") Integer articleId);
}