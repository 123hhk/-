package llp.spring.service;

import com.baomidou.mybatisplus.extension.service.IService;
import llp.spring.entity.Notification;
import llp.spring.tools.Result;

public interface INotificationService extends IService<Notification> {
    Result getMyNotifications(Integer userId); // 获取我的消息列表
    Integer getUnreadCount(Integer userId);    // 获取未读数
    void markRead(Integer id);                 // 标记单条已读
    void markAllRead(Integer userId);          // 一键已读
}