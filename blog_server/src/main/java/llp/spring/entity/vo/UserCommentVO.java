// 20251217新增功能

package llp.spring.entity.vo;
import lombok.Data;
import java.time.LocalDate;

// 20251217新增功能 - 修改DATE为DATETIME
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;

@Data
public class UserCommentVO {
    private Integer id;
    private String content;
    private String author;
    private String type; // "COMMENT" 或 "REPLY"
    // 【新增】专门用于管理后台，存储关联的文章ID
    private Integer articleId;
    private Integer refId; // 如果是COMMENT存articleId，如果是REPLY存commentId
    private String targetName; // 文章标题 或 父评论内容(简略)

    // 20251217新增功能 - 修改DATE为DATETIME
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime created; // 改为 LocalDateTime
}