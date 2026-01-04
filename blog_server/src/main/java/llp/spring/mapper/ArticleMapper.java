package llp.spring.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import llp.spring.entity.vo.ArticleVO;
import llp.spring.entity.Article;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ArticleMapper extends BaseMapper<Article> {
    // 使用 LEFT JOIN 替代原来的逗号连接，更加安全
    @Select("SELECT t_article.id, t_article.title, t_article.created, t_article.categories, t_statistic.hits " +
            " FROM t_article LEFT JOIN t_statistic ON t_article.id = t_statistic.article_id " +
            " ${ew.customSqlSegment} ")
    IPage<ArticleVO> getAPageOfArticleVO(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    // 具体的sql见xml包中的ArticleMapper.xml
    public List<Article> getAPage(
            @Param("offset")long offset,
            @Param("size")long size);

    @Select("SELECT a.id, a.title, a.content, a.created, a.categories, a.thumbnail, u.username AS authorName, s.hits " +
            "FROM t_article a " +
            "LEFT JOIN t_statistic s ON a.id = s.article_id " +
            "LEFT JOIN t_user u ON a.user_id = u.id " +
            "${ew.customSqlSegment}")
    IPage<ArticleVO> articleSearch(IPage<ArticleVO> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    // 【修改】关联查询作者名
    @Select("SELECT t_article.*, t_user.username AS authorName " +
            "FROM t_article " +
            "LEFT JOIN t_user ON t_article.user_id = t_user.id " +
            "${ew.customSqlSegment}")
    IPage<Article> getAPageOfArticle(IPage<Article> page, @Param("ew") QueryWrapper<ArticleVO> wrapper);

    // ...
}