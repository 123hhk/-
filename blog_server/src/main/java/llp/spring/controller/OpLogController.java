// 20251217新增功能 - 个人中心与浏览足迹
package llp.spring.controller;

import llp.spring.entity.OpLog;
import llp.spring.service.IOpLogService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/oplog")
public class OpLogController {

    @Autowired
    private IOpLogService opLogService;

    // 获取当前用户的日志
    @GetMapping("/getMyLogs")
    public Result getMyLogs(Integer userId) {
        Result result = new Result();
        try {
            List<OpLog> logs = opLogService.getUserLogs(userId);
            result.getMap().put("logs", logs);
        } catch (Exception e) {
            result.setErrorMessage("获取日志失败");
            e.printStackTrace();
        }
        return result;
    }
}