package llp.spring.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;

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
@TableName("t_statistic")
public class Statistic implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 关联的文章id
     */
    private Integer articleId;

    /**
     * 文章点击总量
     */
    private Integer hits;

    /**
     * 文章评论总量
     */
    private Integer commentsNum;

    /**
     * 【新增】文章点赞量
     */
    private Integer likes;
}
