package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.Notification;
import llp.spring.mapper.NotificationMapper;
import llp.spring.service.INotificationService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NotificationServiceImpl extends ServiceImpl<NotificationMapper, Notification> implements INotificationService {

    @Autowired
    private NotificationMapper notificationMapper;

    @Override
    public Result getMyNotifications(Integer userId) {
        QueryWrapper<Notification> wrapper = new QueryWrapper<>();
        wrapper.eq("receiver_id", userId).orderByDesc("created"); // 按时间倒序
        List<Notification> list = notificationMapper.selectList(wrapper);
        Result result = new Result();
        result.getMap().put("list", list);
        result.setSuccess(true);
        return result;
    }

    @Override
    public Integer getUnreadCount(Integer userId) {
        return notificationMapper.countUnread(userId);
    }

    @Override
    public void markRead(Integer id) {
        Notification notification = new Notification();
        notification.setId(id);
        notification.setIsRead(true);
        notificationMapper.updateById(notification);
    }

    @Override
    public void markAllRead(Integer userId) {
        notificationMapper.markAllAsRead(userId);
    }
}