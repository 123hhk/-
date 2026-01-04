// 20251217新增功能 - 个人中心与浏览足迹
package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.OpLog;
import llp.spring.mapper.OpLogMapper;
import llp.spring.service.IOpLogService;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class OpLogServiceImpl extends ServiceImpl<OpLogMapper, OpLog> implements IOpLogService {

    @Override
    public void record(Integer userId, String type, String content, Integer targetId) {
        OpLog log = new OpLog();
        log.setUserId(userId);
        log.setType(type);
        log.setContent(content);
        log.setTargetId(targetId);
        log.setCreated(LocalDateTime.now());
        this.baseMapper.insert(log);
    }

    @Override
    public List<OpLog> getUserLogs(Integer userId) {
        QueryWrapper<OpLog> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId);
        wrapper.orderByDesc("created"); // 按时间倒序
        wrapper.last("LIMIT 20");       // 只查最近20条
        return this.baseMapper.selectList(wrapper);
    }
}