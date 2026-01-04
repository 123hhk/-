package llp.spring.service;

import llp.spring.entity.Article;
import llp.spring.tools.ArticleSearch;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;
import org.springframework.web.multipart.MultipartFile;
// 1. 引入 IService
import com.baomidou.mybatisplus.extension.service.IService;

// 2. 关键修改：extends IService<Article>
// 这样你的 Service 就自动拥有了 list(), getOne(), save() 等几十个方法
public interface ArticleService extends IService<Article> {

    // 原有的自定义方法保持不变
    // 【修改】将 void 改为 Article
    Article publish(Article article);

    // 【修改】将 void 改为 Article
    Article update(Article article);
    public String upload(MultipartFile file);
    public Result getArticleAndFirstPageCommentByArticleId (Integer articleId, PageParams pageParams);
    public Result getAPageOfArticleVO( PageParams pageParams, String type);
    public Article selectById(Integer id);
    public void deleteById(Integer id);
    public Result getIndexData();
    public Result getIndexData(PageParams pageParams);
    public Result getAPageOfArticle(PageParams pageParams);
    public Result articleSearch(ArticleSearch articleSearch);
}