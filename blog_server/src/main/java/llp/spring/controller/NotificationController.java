package llp.spring.controller;

import llp.spring.entity.User;
import llp.spring.service.INotificationService;
import llp.spring.service.IUserService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/notification")
public class NotificationController {

    @Autowired
    private INotificationService notificationService;
    @Autowired
    private IUserService userService;

    // 获取当前登录用户ID的辅助方法
    private Integer getCurrentUserId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            User user = userService.selectByUsername(username);
            return user != null ? user.getId() : null;
        }
        return null;
    }

    // 获取未读数量
    @GetMapping("/unreadCount")
    public Result getUnreadCount() {
        Integer userId = getCurrentUserId();
        Result result = new Result();
        if (userId != null) {
            Integer count = notificationService.getUnreadCount(userId);
            result.getMap().put("count", count);
            result.setSuccess(true);
        }
        return result;
    }

    // 获取消息列表
    @GetMapping("/list")
    public Result getList() {
        Integer userId = getCurrentUserId();
        if (userId == null) return new Result(false, "未登录");
        return notificationService.getMyNotifications(userId);
    }

    // 标记所有已读
    @PostMapping("/markAllRead")
    public Result markAllRead() {
        Integer userId = getCurrentUserId();
        if (userId != null) {
            notificationService.markAllRead(userId);
        }
        return new Result(true, "操作成功");
    }
}