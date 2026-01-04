package llp.spring.controller;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.tools.ArticleSearch;
import llp.spring.tools.PageParams;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import llp.spring.service.ArticleService;
import llp.spring.entity.Article;
import llp.spring.tools.Result;
import org.springframework.web.multipart.MultipartFile;

//新增功能标签筛选
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Set;
import java.util.HashSet;
// 20251217新增功能 - 个人中心与浏览足迹
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import llp.spring.entity.User; // 引入你的 User 实体
import llp.spring.service.IUserService; // 引入 UserService
import llp.spring.service.IOpLogService;

// 20251217新增功能 - 完善个人中心与浏览足迹
import llp.spring.entity.Article;
import llp.spring.entity.User;
import llp.spring.service.IOpLogService;
import llp.spring.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;


import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;

@RestController
@RequestMapping("/api/article")  // 为控制器指定访问路径
public class ArticleController {

    @Autowired  // 注入系统自动创建的Service对象，注意下面的对象名（首字母小写的类名）
    private ArticleService articleService;

    // 20251217新增功能 - 个人中心与浏览足迹
    // 1. 注入
    @Autowired
    private IOpLogService opLogService;

    // 20251217新增功能 - 完善个人中心与浏览足迹
    @Autowired
    private IUserService userService;

    // 方法1：主页打开时或从文章返回主页时调用
    @PostMapping("/getIndexData1")
    public Result getIndexData1(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            result = articleService.getIndexData(pageParams);
        } catch (Exception e) {
            result.setErrorMessage("获取数据失败！");
            e.printStackTrace();
        }
        return result;
    }

    // 方法2：主页通过分页组件分页查询时调用
    @PostMapping("/getAPageOfArticle")
    public Result getAPageOfArticle(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            result = articleService.getAPageOfArticle(pageParams);
        } catch (Exception e) {
            result.setErrorMessage("查询文章失败！");
            e.printStackTrace();
        }
        return result;
    }

    @GetMapping("/getAllTags")
    public Result getAllTags() {
        Result result = new Result();
        try {
            // 1. 查询所有文章的标签字段 (这里为了省事直接查了所有文章，如果数据量大建议只查 tags 列)
            // 你可以使用 queryWrapper.select("tags") 来优化
            List<Article> list = articleService.list(new QueryWrapper<Article>().select("tags"));

            // 2. 使用 Set 去重
            Set<String> tagSet = new HashSet<>();
            for (Article article : list) {
                String tags = article.getTags();
                if (tags != null && !tags.isEmpty()) {
                    // 假设标签是用中文逗号或英文逗号分隔的，替换中文逗号为英文逗号
                    String[] splitTags = tags.replace("，", ",").split(",");
                    for (String t : splitTags) {
                        if (!t.trim().isEmpty()) {
                            tagSet.add(t.trim());
                        }
                    }
                }
            }

            // 3. 返回去重后的标签列表
            result.getMap().put("tags", tagSet);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("获取标签失败");
        }
        return result;
    }

    @PostMapping("/getIndexData")
    public Result getIndexData (){
        Result result = new Result();
        try{
            result = articleService.getIndexData();
        }catch (Exception e){
            result.setErrorMessage("获取数据失败!");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/getAPageOfArticleVO")
    public Result getAPageOfArticleVO(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            result = articleService.getAPageOfArticleVO(pageParams, "id");
        } catch (Exception e) {
            result.setErrorMessage("查询变量失败！原因：" + e.getMessage());
            e.printStackTrace();
            // 打印更详细的错误信息
            System.err.println("=== 查询文章详细错误 ===");
            e.printStackTrace();
            System.err.println("=== 请求参数 ===");
            System.err.println("page: " + pageParams.getPage());
            System.err.println("rows: " + pageParams.getRows());
        }
        return result;
    }

    // 20251217新增功能 - 完善个人中心与浏览足迹
    @PostMapping("/getArticleAndFirstPageCommentByArticleId")
    // 【修改】给 Integer articleId 加上 @RequestParam 注解
    public Result getArticleAndFirstPageCommentByArticleId(@RequestParam Integer articleId, @RequestBody PageParams pageParams) {
        // 1. 原有逻辑：获取文章
        Result result = articleService.getArticleAndFirstPageCommentByArticleId(articleId, pageParams);
        // 2. --- 新增：浏览埋点逻辑 ---
        try {
            // 尝试获取当前登录用户
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            // 只有登录用户才记录浏览足迹
            if (principal instanceof UserDetails) {
                String username = ((UserDetails) principal).getUsername();
                User user = userService.selectByUsername(username);

                if (user != null) {
                    // 从 result 中尝试取出文章标题
                    Object articleObj = result.getMap().get("article");
                    String title = "未知文章";
                    if (articleObj instanceof Article) {
                        title = ((Article) articleObj).getTitle();
                    }

                    // 记录日志：用户ID, 类型BROWSE, 内容, 关联文章ID
                    opLogService.record(user.getId(), "BROWSE", "浏览了文章: " + title, articleId);
                }
            }
        } catch (Exception e) {
            // 埋点报错不应影响文章正常展示，仅后台打印即可
            System.err.println("浏览日志埋点失败: " + e.getMessage());
        }
        // ---------------------------

        return result;
    }

// ... 其他引用保持不变

    @RequestMapping("/publishArticle")
    public String publishArticle(String type, @RequestBody Article article) {
        try {
            // === 【新增核心代码 START】 ===
            // 1. 获取当前登录的安全主体
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            // 2. 判断是否已登录
            if (principal instanceof UserDetails) {
                String username = ((UserDetails) principal).getUsername();
                // 3. 查询数据库获取完整的用户信息（主要是为了拿 ID）
                User user = userService.selectByUsername(username);

                if (user != null) {
                    // 4. 强制设置文章作者为当前登录用户
                    article.setUserId(user.getId());      // 设置作者ID (数据库字段: user_id)
                    article.setAuthorName(user.getUsername()); // 设置作者名 (数据库字段: author)
                }
            }
            // === 【新增核心代码 END】 ===

            if(article.getThumbnail() == null || !article.getThumbnail().startsWith("/api")) {
                article.setThumbnail("/api/images/6.png"); // 设置默认缩略图
            }

            if ("add".equals(type)) {
                articleService.publish(article);
            } else if ("edit".equals(type)) {
                // 如果是编辑，这里会将最后修改人设置为当前登录用户
                // 如果需要限制“只能编辑自己的文章”，需要额外加判断逻辑
                articleService.update(article);
            }
            return "操作成功！";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "操作失败！";
    }
    @PostMapping("/upload")
    public Result upload(MultipartFile file) {
        Result result = new Result();
        try {
            String url = articleService.upload(file);
            result.getMap().put("url", url); // 保存返回结果
        } catch (Exception e) {
            result.setErrorMessage("上传失败！");
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/selectById")
    public Result selectById(@RequestParam Integer id) {
        Result result = new Result();
        try {
            Article article = articleService.selectById(id);
            result.getMap().put("article", article);
        } catch (Exception e) {
            result.setErrorMessage("查询失败！");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/deleteById")
    public Result deleteById(Integer id) {
        Result result = new Result();
        try {
            articleService.deleteById(id);
        } catch (Exception e) {
            result.setErrorMessage("删除文章失败！");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/articleSearch")
    public Result articleSearch(@RequestBody ArticleSearch articleSearch) {
        Result result = new Result();
        try {
            // 确保pageParams存在
            if (articleSearch.getPageParams() == null) {
                PageParams pageParams = new PageParams();
                pageParams.setPage(1L);
                pageParams.setRows(10L);
                articleSearch.setPageParams(pageParams);
            }

            result = articleService.articleSearch(articleSearch);
        } catch (Exception e) {
            result.setErrorMessage("获取数据失败！");
            e.printStackTrace();
        }
        return result;
    }

    // 【修改】获取我的文章接口 - 现在直接用 ID 查，效率起飞！
    @PostMapping("/getMyArticles")
    public Result getMyArticles(Integer userId) {
        Result result = new Result();
        try {
            // 直接使用 MyBatis Plus 的 QueryWrapper 查 user_id
            QueryWrapper<Article> wrapper = new QueryWrapper<>();

            // 以前是查 author，现在改成查 user_id
            wrapper.eq("user_id", userId).orderByDesc("created");

            List<Article> list = articleService.list(wrapper);
            result.getMap().put("articles", list);
            result.setSuccess(true); // 显式设置成功
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("获取文章失败");
        }
        return result;
    }
}