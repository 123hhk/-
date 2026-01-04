// 20251217新增功能 - 个人中心与浏览足迹
package llp.spring.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.OpLog;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OpLogMapper extends BaseMapper<OpLog> {
}