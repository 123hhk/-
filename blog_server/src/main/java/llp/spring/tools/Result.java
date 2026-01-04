package llp.spring.tools;

import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.HashMap;
import java.util.Map;

@Data
@NoArgsConstructor
public class Result {
    private boolean success = true; // 代表操作是否成功
    private String msg = ""; // 显示在浏览器中的操作结果信息
    // 存放要返回给客户端任意数据
    private Map<String, Object> map = new HashMap<>();

    public Result(boolean success, String msg) {
        this.success = success;
        this.msg = msg;
    }

    public void setErrorMessage(String msg) { // 设置错误信息
        this.success = false;
        this.msg = msg;
    }
}