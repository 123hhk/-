package llp.spring.entity.vo;

import lombok.Data;
import java.util.Date;

@Data
public class ArticleVO {
    private Integer id; // 文章id
    private String title; // 文章标题
    private String content; // 文章内容 - 添加这个字段
    private Date created; // 文章创建时间
    private String categories; // 文章分类
    private Integer hits; // 点击量
    private String thumbnail;  // 缩略图
    private String authorName; // 作者名
}