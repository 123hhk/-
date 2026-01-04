package llp.spring.tools;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageParams {
    private long page = 1L;
    private long rows = 2L;
    private long total;

    // 【新增】字段
    private String author;

    // 【新增】手动编写的 Getter
    public String getAuthor() {
        return author;
    }

    // 【新增】手动编写的 Setter
    public void setAuthor(String author) {
        this.author = author;
    }
}