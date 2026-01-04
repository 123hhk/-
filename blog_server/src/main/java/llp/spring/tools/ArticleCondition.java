package llp.spring.tools;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ArticleCondition {
    // 代表查询条件：可以根据文章标题、创建时间上限和下限查询文章
    private String title;
    private String tag;


    @JsonFormat(pattern = "yyyy-MM-dd") // 设定日期的格式，方便客户端和服务器端数据交互
    private Date startDate;    // 客户端传过来的数据应该是年月日格式

    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date endDate;
}