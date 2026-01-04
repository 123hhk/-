package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import llp.spring.entity.Statistic;
import llp.spring.entity.vo.ArticleVO;
import llp.spring.mapper.CommentMapper;
import llp.spring.mapper.StatisticMapper;
import llp.spring.entity.Article;
import llp.spring.tools.ArticleSearch;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;

import llp.spring.service.ArticleService;
import llp.spring.mapper.ArticleMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.stereotype.Service;
import lombok.SneakyThrows;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.jsoup.nodes.Document;

import java.io.File;
import java.sql.Wrapper;
import java.text.SimpleDateFormat;

// 20251217新增功能 - 修改DATE为DATETIME
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import java.util.Date;

import org.springframework.beans.factory.annotation.Value;

import org.springframework.cache.annotation.Cacheable; // 导入注解

// 导入必要的包
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.mapper.ArticleMapper;
import llp.spring.entity.Article;
import llp.spring.service.ArticleService;
import org.springframework.stereotype.Service;
// ... 其他原本的 import

@Service // Spring注解，系统会自动创建该类的一个对象
@Transactional
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements ArticleService  {

    // 1. 注入路径
    @Value("${file.upload-images-dir}")
    private String uploadImagesDir;

    @Autowired // 注入系统自动创建的ArticleMapper对象
    private ArticleMapper articleMapper;

    @Autowired
    private CommentMapper commentMapper;;

    @Autowired
    private StatisticMapper statisticMapper;
    @Autowired
    private ArticleService articleService;

    public Result articleSearch(ArticleSearch articleSearch) {
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<>();
        wrapper.orderBy(true, false, "a.id");

        // 设置查询条件
        if (articleSearch.getArticleCondition().getTitle() != null &&
                !articleSearch.getArticleCondition().getTitle().trim().isEmpty()) {
            wrapper.like("a.title", articleSearch.getArticleCondition().getTitle());
        }

        // === 【新增代码 START】 ===
        // 如果 tag 字段不为空，则进行模糊查询
        // 注意：这里假设你的 tags 存的是 "Java,Spring" 这种字符串
        // 使用 like 查询包含该标签的文章
        if (articleSearch.getArticleCondition().getTag() != null &&
                !articleSearch.getArticleCondition().getTag().trim().isEmpty()) {
            wrapper.like("a.tags", articleSearch.getArticleCondition().getTag());
        }
        // === 【新增代码 END】 ===

        // 日期范围查询 - 使用 Date 类型
        if (articleSearch.getArticleCondition().getStartDate() != null) {
            // 将 Date 转换为字符串格式
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            wrapper.ge("a.created", sdf.format(articleSearch.getArticleCondition().getStartDate()) + " 00:00:00");
        }

        if (articleSearch.getArticleCondition().getEndDate() != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            wrapper.le("a.created", sdf.format(articleSearch.getArticleCondition().getEndDate()) + " 23:59:59");
        }

        Page<ArticleVO> page = new Page<>(articleSearch.getPageParams().getPage(),
                articleSearch.getPageParams().getRows());
        IPage<ArticleVO> aPage = articleMapper.articleSearch(page, wrapper);


        if (aPage.getRecords() != null && !aPage.getRecords().isEmpty()) {
            for (ArticleVO vo : aPage.getRecords()) {
                String content = vo.getContent();
                if (content != null) {
                    // 1. 去除 HTML 标签
                    Document doc = Jsoup.parse(content);
                    String text = doc.text();
                    // 2. 截取前 100 字
                    if (text.length() > 100) {
                        text = text.substring(0, 99) + "......";
                    }
                    vo.setContent(text);
                } else {
                    vo.setContent(""); // 防止为 null
                }
            }
        }
        Result result = new Result();
        articleSearch.getPageParams().setTotal(aPage.getTotal());
        result.getMap().put("articleVOs", aPage.getRecords());
        result.getMap().put("pageParams", articleSearch.getPageParams());
        result.setSuccess(true);

        return result;
    }

    public Result getAPageOfArticle(PageParams pageParams) {
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<>();
        wrapper.orderBy(true, false, "t_article.id");

        Page<Article> page = new Page<Article>(pageParams.getPage(), pageParams.getRows());
        IPage<Article> aPage = articleMapper.getAPageOfArticle(page, wrapper);

        Result result = new Result();
        pageParams.setTotal(aPage.getTotal());

        // 只返回部分文章内容
        if(aPage.getRecords() != null && aPage.getRecords().size() > 0) {
            for(Article article : aPage.getRecords()) {
                Document doc = Jsoup.parse(article.getContent());
                String content = doc.text(); // text方法返回全部非html代码的内容（消除html代码）
                if(content.length() > 100) {
                    content = content.substring(0, 99) + "......";
                }
                article.setContent(content);
            }
        }
        result.getMap().put("articles", aPage.getRecords());
        result.getMap().put("pageParams", pageParams);
        return result;
    }

    // 方法2：获取首页数据（重载方法）
    public Result getIndexData(PageParams pageParams) {
        // 定义索引页
        Result result = getAPageOfArticle(pageParams); // 重用本类的方法，分页查询文章

        // 获取点击量排名前十文章
        PageParams pageParams1 = new PageParams();
        pageParams1.setPage(1);
        pageParams1.setRows(10L);
        Result result1 = getAPageOfArticleVO(pageParams1, "hits");
        result.getMap().put("articleVOs", result1.getMap().get("articleVOs"));

        return result;
    }

    public Result getIndexData(){
        Result result = new Result();
        List<Article> articles = articleMapper.getAPage(0L, 5L);
        result.getMap().put("articles", articles);

        PageParams pageParams = new PageParams();
        pageParams.setPage(1L);
        pageParams.setRows(10L);     // 调用本类的方法

        Result result1 = getAPageOfArticleVO(pageParams, "hits");
        result.getMap().put("articleVOs", result1.getMap().get("articleVOs"));

        return result;
    }

    public Result getAPageOfArticleVO(PageParams pageParams, String type) {
        QueryWrapper<ArticleVO> wrapper = new QueryWrapper<ArticleVO>();

        // 修改这里：使用 apply 方法来设置连接条件
        //wrapper.apply("t_article.id = t_statistic.article_id");

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

    public Result getArticleAndFirstPageCommentByArticleId(Integer articleId, PageParams pageParams){
        Result result=new Result();
        result.getMap().put("article",articleService.selectById(articleId));
        result.getMap().put("comments",
                commentMapper.getAPageCommentByArticleId(
                        articleId, (int) ((pageParams.getPage()-1)*pageParams.getRows()), (int) pageParams.getRows()));

        // 文章的点击次数+1
        Statistic statistic = statisticMapper.selectByArticleId(articleId);
        if (statistic == null) {
            // 如果统计记录不存在，创建新的统计记录
            statistic = new Statistic();
            statistic.setArticleId(articleId);
            statistic.setHits(1); // 第一次访问，点击量为1
            statistic.setCommentsNum(0);
            statisticMapper.insert(statistic);
        } else {
            // 统计记录存在，点击量+1
            statistic.setHits(statistic.getHits() + 1);
            statisticMapper.updateById(statistic);
        }

        return result;
    }

    @Override
    @CachePut(cacheNames = "article", key = "#article.id")
    public Article update(Article article) {
        Article newArticle = articleService.selectById(article.getId());
        // 20251217新增功能 - 修改DATE为DATETIME
        newArticle.setModified(LocalDateTime.now());
        newArticle.setTags(article.getTags());
        newArticle.setContent(article.getContent());
        newArticle.setTitle(article.getTitle());
        newArticle.setThumbnail(article.getThumbnail());
        // articleMapper使用从父类BaseMapper继承过来的updateById方法，更新表t_article中的文章

        newArticle.setUserId(article.getUserId());

        articleMapper.updateById(newArticle);

        return newArticle;
    }

    // 发布文章
    @Override
    @CachePut(cacheNames = "article", key = "#article.id")
    @Transactional // 表示publish方法会被作为一个事务执行，确保文章和统计记录同时添加或均不添加
    public Article publish(Article article) {
        // 20251217新增功能 - 修改DATE为DATETIME
        article.setCreated(LocalDateTime.now());
        // articleMapper使用从父类BaseMapper继承过来的Insert方法，将文章添加到其t_article
        articleMapper.insert(article);

        // 添加统计记录
        Statistic statistic = new Statistic();
        statistic.setArticleId(article.getId());
        statistic.setHits(0);
        statistic.setCommentsNum(0);
        statisticMapper.insert(statistic);

        return article;
    }

    @SneakyThrows // lombok注解，可以不写出异常的代码
    @Override
    public String upload(MultipartFile file) {
        // 2. 使用注入的变量替代硬编码
        final File folder = new File(uploadImagesDir);
        if (!folder.exists()) {
            folder.mkdirs(); // 创建文件夹
        }
        // 获得上传文件的扩展名
        String type = file.getOriginalFilename().substring(
                file.getOriginalFilename().lastIndexOf(".")
        );
        // 为文件随机取名
        final String newName = UUID.randomUUID() + type;
        file.transferTo(new File(folder, newName)); // 保存文件
        String url = "/api/images/" + newName; // 文件的相对网址
        return url;
    }

    // 修改 selectById 方法，添加缓存注解
    @Override
    @Cacheable(value = "article", key = "#id") // 这里的 value 是缓存名称，key 是参数 id
    public Article selectById(Integer id) {
        System.out.println("查询数据库: " + id); // 添加这行打印，方便你在控制台观察是否走了缓存
        return articleMapper.selectById(id);
    }

    @CacheEvict(cacheNames = "article", key = "#id")
    public void deleteById(Integer id) {
        articleMapper.deleteById(id);
    }
}


