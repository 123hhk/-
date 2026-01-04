// 20251217新增功能 - 个人中心与浏览足迹
package llp.spring.service;

import com.baomidou.mybatisplus.extension.service.IService;
import llp.spring.entity.OpLog;
import java.util.List;

public interface IOpLogService extends IService<OpLog> {
    // 记录日志
    void record(Integer userId, String type, String content, Integer targetId);
    // 获取某用户的最新日志 (限制条数)
    List<OpLog> getUserLogs(Integer userId);
}