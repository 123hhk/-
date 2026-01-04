package llp.spring.controller;

import llp.spring.entity.User;
import llp.spring.mapper.ArticleMapper;
import llp.spring.mapper.StatisticMapper;
import llp.spring.service.IUserService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/statistic")
public class StatisticController {

    @Autowired
    private StatisticMapper statisticMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private IUserService userService;

    // === 仪表盘数据接口 ===
    @GetMapping("/dashboard")
    public Result getDashboardData() {
        Result result = new Result();
        Map<String, Object> map = new HashMap<>();

        // 1. 基础统计
        Long totalArticles = articleMapper.selectCount(null);
        Long totalHits = statisticMapper.getTotalHits();
        Long totalComments = statisticMapper.getTotalComments();

        map.put("totalArticles", totalArticles);
        map.put("totalHits", totalHits);
        map.put("totalComments", totalComments);

        // 2. 分类占比
        List<Map<String, Object>> categoryStats = articleMapper.getArticleCountByCategory();
        for (Map<String, Object> item : categoryStats) {
            if (item.get("name") == null || item.get("name").toString().isEmpty()) {
                item.put("name", "未分类");
            }
        }
        map.put("categoryStats", categoryStats);

        // 3. 标签雷达图
        List<String> allTags = articleMapper.getAllTags();
        Map<String, Integer> tagCountMap = new HashMap<>();
        for (String tagStr : allTags) {
            if (tagStr != null && !tagStr.isEmpty()) {
                String[] tags = tagStr.replace(",", " ").replace("，", " ").split("\\s+");
                for (String t : tags) {
                    if (!t.isEmpty() && !t.startsWith("#")) {
                        tagCountMap.put(t, tagCountMap.getOrDefault(t, 0) + 1);
                    } else if (!t.isEmpty() && t.startsWith("#")) {
                        String realTag = t.substring(1);
                        if(!realTag.isEmpty()) tagCountMap.put(realTag, tagCountMap.getOrDefault(realTag, 0) + 1);
                    }
                }
            }
        }
        List<Map.Entry<String, Integer>> sortedTags = tagCountMap.entrySet().stream()
                .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
                .limit(6)
                .collect(Collectors.toList());

        List<Map<String, Object>> radarIndicator = new ArrayList<>();
        List<Integer> radarData = new ArrayList<>();
        int maxVal = sortedTags.isEmpty() ? 10 : sortedTags.get(0).getValue() + 2;

        for (Map.Entry<String, Integer> entry : sortedTags) {
            Map<String, Object> indicator = new HashMap<>();
            indicator.put("name", entry.getKey());
            indicator.put("max", maxVal);
            radarIndicator.add(indicator);
            radarData.add(entry.getValue());
        }

        map.put("radarIndicator", radarIndicator);
        map.put("radarData", radarData);

        result.setMap(map);
        result.setSuccess(true);
        return result;
    }

    // === 文章点赞/取消点赞接口 ===
    @PostMapping("/likeArticle")
    public Result likeArticle(Integer articleId) {
        // 1. 获取当前用户 (修复类型转换异常)
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }

        if ("anonymousUser".equals(username)) {
            return new Result(false, "请先登录");
        }
        User user = userService.selectByUsername(username);
        if (user == null) return new Result(false, "用户异常");

        // 2. 检查是否点过赞
        Integer count = statisticMapper.countArticleLike(user.getId(), articleId);

        if (count > 0) {
            // === 已点赞 -> 执行取消 ===
            try {
                statisticMapper.deleteArticleLike(user.getId(), articleId);
                statisticMapper.decreaseLikes(articleId);
                return new Result(true, "取消点赞");
            } catch (Exception e) {
                e.printStackTrace();
                return new Result(false, "操作失败");
            }
        } else {
            // === 未点赞 -> 执行点赞 ===
            try {
                statisticMapper.insertArticleLike(user.getId(), articleId);
                statisticMapper.increaseLikes(articleId);
                return new Result(true, "点赞成功");
            } catch (Exception e) {
                // 防止并发重复插入
                return new Result(false, "操作失败");
            }
        }
    }
}