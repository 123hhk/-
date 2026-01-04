package llp.spring.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@TableName("t_notification")
public class Notification implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer senderId;      // 发送人ID
    private String senderName;     // 发送人用户名
    private Integer receiverId;    // 接收人ID
    private Integer articleId;     // 文章ID
    private String content;        // 内容
    private String type;           // 类型：COMMENT, REPLY
    private Boolean isRead;        // 是否已读

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime created;
}