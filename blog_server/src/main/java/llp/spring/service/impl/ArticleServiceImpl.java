package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.Article;
import llp.spring.entity.Comment; // 【新增】引入 Comment 实体
import llp.spring.entity.Statistic;
import llp.spring.entity.User;
import llp.spring.entity.vo.ArticleVO;
import llp.spring.mapper.ArticleMapper;
import llp.spring.mapper.CommentMapper;
import llp.spring.mapper.StatisticMapper;
import llp.spring.mapper.UserMapper;
import llp.spring.service.ArticleService;
import llp.spring.tools.ArticleSearch;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;
import lombok.SneakyThrows;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements ArticleService  {

    @Value("${file.upload-images-dir}")
    private String uploadImagesDir;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private StatisticMapper statisticMapper;

    @Autowired
    private UserMapper userMapper;

    // === 核心辅助方法：根据 user_id 填充作者真名 ===
    private void fillArticleAuthor(Article article) {
        if (article != null && article.getUserId() != null) {
            User user = userMapper.selectById(article.getUserId());
            if (user != null) {
                // 覆盖作者名，确保前端显示的是最新的用户昵称
                article.setAuthor(user.getUsername());
                article.setAuthorName(user.getUsername());
            }
        }
    }

    // 1. 文章搜索
    public Result articleSearch(ArticleSearch articleSearch) {
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<>();
        wrapper.orderBy(true, false, "a.id");

        if (articleSearch.getArticleCondition().getTitle() != null &&
                !articleSearch.getArticleCondition().getTitle().trim().isEmpty()) {
            wrapper.like("a.title", articleSearch.getArticleCondition().getTitle());
        }

        if (articleSearch.getArticleCondition().getStartDate() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            wrapper.ge("a.created", sdf.format(articleSearch.getArticleCondition().getStartDate()) + " 00:00:00");
        }

        // 【必须存在】标签模糊查询
        if (articleSearch.getArticleCondition().getTag() != null &&
                !articleSearch.getArticleCondition().getTag().trim().isEmpty()) {
            wrapper.like("a.tags", articleSearch.getArticleCondition().getTag());
        }

        if (articleSearch.getArticleCondition().getEndDate() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            wrapper.le("a.created", sdf.format(articleSearch.getArticleCondition().getEndDate()) + " 23:59:59");
        }

        Page<ArticleVO> page = new Page<>(articleSearch.getPageParams().getPage(),
                articleSearch.getPageParams().getRows());
        IPage<ArticleVO> aPage = articleMapper.articleSearch(page, wrapper);

        Result result = new Result();
        articleSearch.getPageParams().setTotal(aPage.getTotal());
        result.getMap().put("articleVOs", aPage.getRecords());
        result.getMap().put("pageParams", articleSearch.getPageParams());
        result.setSuccess(true);


        return result;
    }

    // 2. 分页获取文章列表
    public Result getAPageOfArticle(PageParams pageParams) {
        Page<Article> page = new Page<>(pageParams.getPage(), pageParams.getRows());
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<>();

        // === 【核心修改】排序逻辑 ===
        // 如果前端传了 sort=hot，则按点赞数(s.likes)倒序
        // 否则默认按 id 倒序 (最新发布)
        if ("hot".equals(pageParams.getSort())) {
            wrapper.orderByDesc("s.likes");
        } else {
            wrapper.orderByDesc("t_article.id");
        }
        // ==========================

        IPage<Article> iPage = articleMapper.getAPageOfArticle(page, wrapper);

        // 处理文章摘要 (去除HTML标签，截取前100字)
        if (iPage.getRecords() != null) {
            for (Article article : iPage.getRecords()) {
                if (article.getContent() != null) {
                    // 使用正则去除HTML标签
                    String text = article.getContent().replaceAll("<[^>]+>", "");
                    // 截取
                    if (text.length() > 100) {
                        text = text.substring(0, 99) + "...";
                    }
                    article.setContent(text);
                }
            }
        }

        Result result = new Result();
        pageParams.setTotal(iPage.getTotal());
        result.getMap().put("articles", iPage.getRecords());
        result.getMap().put("pageParams", pageParams);
        result.setSuccess(true);
        return result;
    }

    // 3. 获取首页数据
    public Result getIndexData(PageParams pageParams) {
        Result result = getAPageOfArticle(pageParams);

        PageParams pageParams1 = new PageParams();
        pageParams1.setPage(1);
        pageParams1.setRows(10L);
        Result result1 = getAPageOfArticleVO(pageParams1, "hits");
        result.getMap().put("articleVOs", result1.getMap().get("articleVOs"));
        return result;
    }

    public Result getIndexData(){
        Result result = new Result();

        // 轮播图数据
        List<Article> articles = articleMapper.getAPage(0L, 5L);
        if (articles != null) {
            for (Article article : articles) {
                fillArticleAuthor(article); // 记得给轮播图也填充作者
            }
        }
        result.getMap().put("articles", articles);

        // 排行榜数据
        PageParams pageParams = new PageParams();
        pageParams.setPage(1L);
        pageParams.setRows(10L);
        Result result1 = getAPageOfArticleVO(pageParams, "hits");
        result.getMap().put("articleVOs", result1.getMap().get("articleVOs"));

        return result;
    }

    public Result getAPageOfArticleVO(PageParams pageParams, String type) {
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<ArticleVO>();
        if("id".equals(type)) {
            wrapper.orderBy(true, false, "t_article.id");
        } else if("hits".equals(type)) {
            wrapper.orderBy(true, false, "t_statistic.hits");
        }

        Page<ArticleVO> page = new Page<ArticleVO>(pageParams.getPage(), pageParams.getRows());
        IPage<ArticleVO> aPage = articleMapper.getAPageOfArticleVO(page, wrapper);

        Result result = new Result();
        pageParams.setTotal(aPage.getTotal());
        result.getMap().put("articleVOs", aPage.getRecords());
        result.getMap().put("pageParams", pageParams);
        return result;
    }

    // 4. 获取文章详情及评论
    public Result getArticleAndFirstPageCommentByArticleId(Integer articleId, PageParams pageParams){
        Result result = new Result();

        // 使用 this.selectById(articleId) 以触发缓存和作者填充逻辑
        result.getMap().put("article", this.selectById(articleId));

        result.getMap().put("comments",
                commentMapper.getAPageCommentByArticleId(
                        articleId, (int) ((pageParams.getPage()-1)*pageParams.getRows()), (int) pageParams.getRows()));

        // 更新点击量
        Statistic statistic = statisticMapper.selectByArticleId(articleId);
        if (statistic == null) {
            statistic = new Statistic();
            statistic.setArticleId(articleId);
            statistic.setHits(1);
            statistic.setCommentsNum(0);
            statisticMapper.insert(statistic);
        } else {
            statistic.setHits(statistic.getHits() + 1);
            statisticMapper.updateById(statistic);
        }

        return result;
    }

    // 5. 更新文章
    @Override
    @CachePut(cacheNames = "article", key = "#article.id")
    public Article update(Article article) {
        // 先查原文章
        Article newArticle = articleMapper.selectById(article.getId());

        newArticle.setModified(LocalDateTime.now());
        newArticle.setTags(article.getTags());
        newArticle.setContent(article.getContent());
        newArticle.setTitle(article.getTitle());
        newArticle.setThumbnail(article.getThumbnail());
        newArticle.setUserId(article.getUserId());
        // 如果你需要更新位置，取消下面这行的注释
        // newArticle.setLocation(article.getLocation());

        articleMapper.updateById(newArticle);

        fillArticleAuthor(newArticle);
        return newArticle;
    }

    // 6. 发布文章
    @Override
    @CachePut(cacheNames = "article", key = "#article.id")
    @Transactional
    public Article publish(Article article) {
        article.setCreated(LocalDateTime.now());
        articleMapper.insert(article);

        Statistic statistic = new Statistic();
        statistic.setArticleId(article.getId());
        statistic.setHits(0);
        statistic.setCommentsNum(0);
        statisticMapper.insert(statistic);

        fillArticleAuthor(article);
        return article;
    }

    // 7. 图片上传
    @SneakyThrows
    @Override
    public String upload(MultipartFile file) {
        final File folder = new File(uploadImagesDir);
        if (!folder.exists()) {
            folder.mkdirs();
        }
        String type = file.getOriginalFilename().substring(
                file.getOriginalFilename().lastIndexOf(".")
        );
        final String newName = UUID.randomUUID() + type;
        file.transferTo(new File(folder, newName));
        String url = "/api/images/" + newName;
        return url;
    }

    // 8. 单个文章查询
    @Override
    @Cacheable(value = "article", key = "#id")
    public Article selectById(Integer id) {
        Article article = articleMapper.selectById(id);
        fillArticleAuthor(article);
        return article;
    }

    // 9. 删除文章 (级联删除)
    @Override
    @CacheEvict(cacheNames = "article", key = "#id")
    @Transactional(rollbackFor = Exception.class) // 【新增】开启事务，确保删除操作原子性
    public void deleteById(Integer id) {
        // 1. 删除文章本体
        articleMapper.deleteById(id);

        // 2. 删除关联的评论数据
        QueryWrapper<Comment> commentWrapper = new QueryWrapper<>();
        commentWrapper.eq("article_id", id);
        commentMapper.delete(commentWrapper);

        // 3. 删除关联的统计数据
        QueryWrapper<Statistic> statWrapper = new QueryWrapper<>();
        statWrapper.eq("article_id", id);
        statisticMapper.delete(statWrapper);
    }


}