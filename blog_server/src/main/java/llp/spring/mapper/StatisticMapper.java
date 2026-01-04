package llp.spring.mapper;

import llp.spring.entity.Statistic;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author baomidou
 * @since 2025-10-31
 */
@Mapper
public interface StatisticMapper extends BaseMapper<Statistic> {
    @Select("SELECT * FROM t_statistic WHERE article_id=#{articleId}")
    public Statistic selectByArticleId(Integer articleId);
}
