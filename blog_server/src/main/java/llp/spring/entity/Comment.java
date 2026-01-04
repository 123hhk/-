package llp.spring.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDate;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

// 20251217新增功能 - 修改DATE为DATETIME
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * <p>
 *
 * </p>
 *
 * @author baomidou
 * @since 2025-10-31
 */
@Getter
@Setter
@Data
@TableName("t_comment")
public class Comment implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 评论id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 【新增】关联的用户id (关键修改)
     */
    @TableField("user_id")
    private Integer userId;

    /**
     * 关联的文章id
     */
    private Integer articleId;

    /**
     * 评论时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime created;

    /**
     * 评论用户登录的ip地址
     */
    private String ip;

    /**
     * 评论内容
     */
    private String content;

    /**
     * 评论状态
     */
    private String status;

    /**
     * 评论用户用户名
     */
    private String author;

    /**
     * IP属地
     */
    private String location; // 【新增】
    /**
     * 【新增】评论点赞数
     */
    private Integer likes;
}