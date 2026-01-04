package llp.spring.entity;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.IdType;

import java.io.Serializable;
import java.util.Date;

// 20251217新增功能 - 修改DATE为DATETIME
import java.time.LocalDateTime; // 导入 LocalDateTime
import com.fasterxml.jackson.annotation.JsonFormat;

import com.baomidou.mybatisplus.annotation.TableField;

@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("t_article")    // 对应的数据库表名
public class Article implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)   // id字段为自动增长
    private Integer id;            // 文章id

    // 【新增】对应数据库的 user_id 字段
    @TableField("user_id")
    private Integer userId;

    private String title;          // 文章标题
    private String content;        // 文章内容
    private String categories;     // 文章分类
    private String tags;           // 文章标签
    private Boolean allowComment;  // 是否允许评论，默认为true
    private String thumbnail;      // 文章缩略图


    // 20251217新增功能 - 修改DATE为DATETIME
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8") // 格式化精确到秒
    private LocalDateTime created; // 改为 LocalDateTime

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime modified; // 改为 LocalDateTime

    // ...

    // ... inside Article class

    // 【新增】作者名（数据库中不存在该字段，需关联查询）
    @TableField(exist = false)
    private String authorName;

    private String author;

    // 【新增】发布地点
    private String location;
    // === 【新增】点赞数（非数据库字段，用于接收连表查询结果） ===
    @TableField(exist = false)
    private Integer likes;
}

