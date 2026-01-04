package llp.spring.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.Category;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CategoryMapper extends BaseMapper<Category> {
}