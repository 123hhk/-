package llp.spring.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.Article;
import llp.spring.entity.Category;
import llp.spring.service.ArticleService;
import llp.spring.service.ICategoryService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/category")
public class CategoryController {

    @Autowired
    private ICategoryService categoryService;

    @Autowired
    private ArticleService articleService;
    
    // 获取分类树
    @GetMapping("/getTree")
    public Result getTree() {
        Result result = new Result(true, "获取成功");
        result.getMap().put("data", categoryService.getTree());
        return result;
    }

    // 新增分类
    @PostMapping("/add")
    public Result add(@RequestBody Category category) {
        // 默认放到最后
        if (category.getParentId() == null) category.setParentId(0);
        if (category.getSort() == null) category.setSort(99);

        boolean success = categoryService.save(category);
        return new Result(success, success ? "添加成功" : "添加失败");
    }

    // 修改分类（重命名）
    @PostMapping("/update")
    public Result update(@RequestBody Category category) {
        boolean success = categoryService.updateById(category);
        return new Result(success, success ? "修改成功" : "修改失败");
    }

    // 删除分类
    @PostMapping("/delete")
    public Result delete(Integer id) {
        // 检查是否有子分类
        long count = categoryService.count(new QueryWrapper<Category>().eq("parent_id", id));
        if (count > 0) {
            return new Result(false, "请先删除子分类！");
        }
        boolean success = categoryService.removeById(id);
        return new Result(success, success ? "删除成功" : "删除失败");
    }

    // 【关键】批量更新分类（用于拖拽排序后保存）
    // 前端会把受影响的节点列表传过来（包含新的 parentId 和 sort）
    @PostMapping("/updateBatch")
    public Result updateBatch(@RequestBody List<Category> categories) {
        boolean success = categoryService.updateBatchById(categories);
        return new Result(success, success ? "排序保存成功" : "保存失败");
    }

    // 【新增】核心接口：获取某分类下的“子分类”和“文章”
    @GetMapping("/getResources")
    public Result getResources(@RequestParam Integer id) {
        Result result = new Result(true, "获取成功");

        // 1. 获取子分类 (Folders) - 按 sort 排序
        QueryWrapper<Category> catWrapper = new QueryWrapper<>();
        catWrapper.eq("parent_id", id).orderByAsc("sort");
        List<Category> subCategories = categoryService.list(catWrapper);

        // 2. 获取该分类下的文章 (Files)
        // 2.1 递归计算当前分类的完整路径字符串 (例如 "技术/后端/Java")
        String categoryPath = buildCategoryPath(id);

        List<Article> articles = new ArrayList<>();
        if (categoryPath != null) {
            QueryWrapper<Article> artWrapper = new QueryWrapper<>();
            // 精确匹配分类路径
            artWrapper.eq("categories", categoryPath).orderByDesc("created");
            articles = articleService.list(artWrapper);
        }

        // 3. 返回数据，前端负责渲染顺序（文件夹置顶）
        Map<String, Object> data = new HashMap<>();
        data.put("folders", subCategories); // 文件夹
        data.put("articles", articles);     // 文章
        data.put("currentPath", categoryPath); // 当前路径，方便前端展示

        result.getMap().put("data", data);
        return result;
    }

    // --- 辅助方法：根据ID递归向上查找，构建路径字符串 ---
    private String buildCategoryPath(Integer id) {
        Category current = categoryService.getById(id);
        if (current == null) return null;

        LinkedList<String> pathList = new LinkedList<>();
        pathList.addFirst(current.getName());

        // 循环查找父节点
        while (current.getParentId() != 0) {
            current = categoryService.getById(current.getParentId());
            if (current == null) break; // 防止数据异常
            pathList.addFirst(current.getName());
        }

        // 使用 / 拼接，例如 ["技术", "后端"] -> "技术/后端"
        return String.join("/", pathList);
    }
}