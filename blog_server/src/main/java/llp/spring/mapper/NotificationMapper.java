package llp.spring.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import llp.spring.entity.Notification;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface NotificationMapper extends BaseMapper<Notification> {

    // 统计某用户的未读消息数
    @Select("SELECT COUNT(*) FROM t_notification WHERE receiver_id = #{userId} AND is_read = 0")
    Integer countUnread(Integer userId);

    // 一键已读
    @Update("UPDATE t_notification SET is_read = 1 WHERE receiver_id = #{userId}")
    void markAllAsRead(Integer userId);
}