package llp.spring.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import llp.spring.entity.vo.ArticleVO;
import llp.spring.entity.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import java.util.Map;
import java.util.List;

@Mapper
public interface ArticleMapper extends BaseMapper<Article> {

    // 获取文章VO分页（通常用于排行榜等纯展示列表）
    @Select("SELECT t_article.id, t_article.title, t_article.created, t_article.categories, t_statistic.hits " +
            " FROM t_article LEFT JOIN t_statistic ON t_article.id = t_statistic.article_id " +
            " ${ew.customSqlSegment} ")
    IPage<ArticleVO> getAPageOfArticleVO(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    // XML定义的传统分页（对应 ArticleMapper.xml）
    public List<Article> getAPage(
            @Param("offset")long offset,
            @Param("size")long size);


    // === 【新增】按分类统计文章数量 ===
    @Select("SELECT categories AS name, COUNT(*) AS value FROM t_article GROUP BY categories")
    List<Map<String, Object>> getArticleCountByCategory();

    // === 【新增】获取所有文章的标签（用于后端统计词频）===
    @Select("SELECT tags FROM t_article")
    List<String> getAllTags();
    // === 【搜索/筛选接口】 ===
    // 修复点：
    // 1. 增加了 a.content (解决 substring null 报错)
    // 2. 增加了 a.thumbnail (解决无图)
    // 3. 增加了 u.username AS authorName (解决无作者)
    @Select("SELECT a.id, a.title, a.content, a.created, a.categories, a.thumbnail, u.username AS authorName, s.hits " +
            "FROM t_article a " +
            "LEFT JOIN t_statistic s ON a.id = s.article_id " +
            "LEFT JOIN t_user u ON a.user_id = u.id " +
            "${ew.customSqlSegment}")
    IPage<ArticleVO> articleSearch(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);
    // === 【首页列表接口】 ===
    // 修复点：
    // 1. 显式列出所有字段，避免 * 号导致 thumbnail/tags 映射失败
    // 2. 关联查询作者名
    @Select("SELECT t_article.id, t_article.user_id, t_article.title, t_article.content, " +
            "t_article.created, t_article.modified, t_article.categories, t_article.tags, " +
            "t_article.thumbnail, t_article.allow_comment, " +
            "t_user.username AS authorName, " +
            "IFNULL(s.likes, 0) AS likes " + // 查询点赞数
            "FROM t_article " +
            "LEFT JOIN t_user ON t_article.user_id = t_user.id " +
            "LEFT JOIN t_statistic s ON t_article.id = s.article_id " + // 关联统计表
            "${ew.customSqlSegment}")
    IPage<Article> getAPageOfArticle(IPage<Article> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);
    // === 【新增】获取点赞排行榜 (前10名) ===
    // 关联 t_statistic 表，按 s.likes 倒序排列
    @Select("SELECT a.id, a.title, s.likes " +
            "FROM t_article a " +
            "LEFT JOIN t_statistic s ON a.id = s.article_id " +
            "ORDER BY s.likes DESC LIMIT 10")
    List<ArticleVO> getLikeRanking();
}