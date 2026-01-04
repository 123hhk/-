package llp.spring.tools;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ArticleSearch {
    private ArticleCondition articleCondition; // 查询条件
    private PageParams pageParams; // 分页参数
}