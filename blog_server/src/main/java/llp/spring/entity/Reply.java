// 20251217新增功能

package llp.spring.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;

// 20251217新增功能 - 修改DATE为DATETIME
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;

@Data
@TableName("t_reply")
public class Reply implements Serializable {
    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String content;
    private String author;

    // 20251217新增功能 - 修改DATE为DATETIME
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime created; // 改为 LocalDateTime

    private Integer commentId; // 父评论ID
    private String targetAuthor; // 被回复的人

    // 【新增】目标用户ID (对应数据库新增字段)
    @TableField("to_uid")
    private Integer toUid;

    // 【新增】目标用户名 (数据库不存在该字段，仅用于展示)
    @TableField(exist = false)
    private String targetName;

    // 【新增】发送者用户名 (如果之前没有的话)
    @TableField(exist = false)
    private String username;

    // 【新增】发送者头像
    @TableField(exist = false)
    private String avatar;


    // 【新增】关联的用户id (关键修改)
    @TableField("user_id")
    private Integer userId;

    // 在类中添加这两个字段
    /**
     * 回复人IP
     */
    private String ip; // 【新增】

    /**
     * IP属地
     */
    private String location; // 【新增】
}