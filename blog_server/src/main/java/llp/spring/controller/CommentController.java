package llp.spring.controller;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.Comment;
// 20251217新增功能
import llp.spring.entity.Reply;
import llp.spring.mapper.CommentMapper;
import llp.spring.tools.IpUtils;
import llp.spring.tools.PageParams;
import llp.spring.tools.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import llp.spring.tools.Result;
import llp.spring.service.ICommentService;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;
// 引入 HttpSession 和 UserDTO
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import llp.spring.entity.dto.UserDTO;

// 20251216新增功能 - 修改用户名为真实用户名
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

// 20251217新增功能
import llp.spring.entity.vo.UserCommentVO;

// 20251217新增功能 - 个人中心与浏览足迹
import llp.spring.entity.User;
import llp.spring.service.IOpLogService;
import llp.spring.service.IUserService;

import llp.spring.service.IReplyService;

import llp.spring.entity.vo.UserCommentVO;
@RestController
@RequestMapping("/api/comment")
public class CommentController {
    @Autowired
    private ICommentService commentService;

    // 20251217新增功能 - 个人中心与浏览足迹
    @Autowired
    private IUserService userService;

    @Autowired
    private IOpLogService opLogService;
    // 【2. 新增注入 ReplyService】
    // 注意：你的 Service 接口名通常以 I 开头，如果是 ReplyService 请自行修改
    @Autowired
    private IReplyService replyService;

    @PostMapping("/getAPageCommentByArticleId")
    public Result getAPageCommentByArticleId(Integer articleId, @RequestBody PageParams pageParams){
        Result result = new Result(); // 接收查询字符串中的数据    接收axios请求的data数据
        try {
            result = commentService.getAPageCommentByArticleId(articleId, pageParams);
        } catch (Exception e) {
            result.setErrorMessage("查询评论失败！");
            e.printStackTrace();
        }
        return result;
    }

    @PostMapping("/insert")
    public Result insert(@RequestBody Comment comment, HttpServletRequest request){
        Result result = new Result();
        try {
            // 20251216新增功能 - 修改用户名为真实用户名
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username;
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            } else {
                username = principal.toString();
            }
            comment.setAuthor(username);

            comment.setCreated(LocalDateTime.now()); // 之前修改的时间

            // 【新增代码开始】 ===
            String ip = IpUtils.getIpAddr(request);
            comment.setIp(ip);
            comment.setLocation(IpUtils.getCityInfo(ip));
            // 【新增代码结束】 ===

            Comment comment1 = commentService.insert(comment);

            // 20251217新增功能 - 个人中心与浏览足迹
            User user = userService.selectByUsername(username);
            if (user != null) {
                // 记录日志：用户ID, 类型, 内容描述(截取前20个字), 关联文章ID
                String contentSummary = comment.getContent().length() > 20 ? comment.getContent().substring(0, 20) + "..." : comment.getContent();
                opLogService.record(user.getId(), "COMMENT", "评论了文章: " + contentSummary, comment.getArticleId());
            }

            result.getMap().put("Comment", comment1);
            result.setMsg("评论成功!");
        } catch (Exception e) {
            result.setErrorMessage("评论失败!");
            e.printStackTrace();
        }
        return result;
    }

    // 评论管理功能
    // --- 修改：获取所有评论（管理员） ---
    // --- 修改：获取所有评论（管理员） ---
// --- 【修改后】管理员获取所有评论接口 ---
    @PostMapping("/getAdminPage")
    public Result getAdminPage(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            long page = pageParams.getPage();
            long rows = pageParams.getRows();
            long offset = (page - 1) * rows;

            // 【修改】获取前端传来的 author (如果没有则是 null)
            String author = pageParams.getAuthor();

            // 【修改】调用 Mapper 时传入 author
            List<UserCommentVO> list = commentMapper.getAdminComments((int) offset, (int) rows, author);
            Integer total = commentMapper.countAdminComments(author);
            result.getMap().put("comments", list);
            pageParams.setTotal(total);
            result.getMap().put("pageParams", pageParams);

            result.setSuccess(true);
        } catch (Exception e) {
            result.setErrorMessage("获取评论列表失败！");
            e.printStackTrace();
        }
        return result;
    }

    // --- 新增接口：删除评论 ---
    @PostMapping("/deleteById")
    public Result deleteById(Integer id) {
        Result result = new Result();
        try {
            commentService.deleteById(id);
            result.setMsg("删除成功");
        } catch (Exception e) {
            result.setErrorMessage("删除失败！");
            e.printStackTrace();
        }
        return result;
    }

    // 20251217新增功能

    @Autowired
    private CommentMapper commentMapper; // 确保注入了 Mapper

    @PostMapping("/getUserComments")
    public Result getUserComments(String author) {
        Result result = new Result();
        try {
            List<UserCommentVO> list = commentMapper.selectCommentsByAuthor(author);
            result.getMap().put("comments", list);
        } catch (Exception e) {
            result.setErrorMessage("查询失败");
            e.printStackTrace();
        }
        return result;
    }

    // 在 CommentController 中添加
    @PostMapping("/getMyComments")
    public Result getMyComments(String username) { // 直接传用户名查
        Result result = new Result();
        try {
            QueryWrapper<Comment> wrapper = new QueryWrapper<>();
            wrapper.eq("author", username).orderByDesc("created");
            List<Comment> list = commentService.list(wrapper);
            result.getMap().put("comments", list);
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("获取评论失败");
        }
        return result;
    }

    // 【3. 修复后的管理端接口】
    @PostMapping("/getAllCommentsAndReplies")
    public Result getAllCommentsAndReplies(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            // 1. 查所有主评论
            List<Comment> comments = commentService.list();
            // 2. 查所有回复
            List<Reply> replies = replyService.list();

            // 为了给回复找到所属文章，我们需要先把所有评论转成 Map (id -> articleId)
            // 这样不用在循环里查库，性能更好
            Map<Integer, Integer> commentArticleMap = comments.stream()
                    .collect(Collectors.toMap(Comment::getId, Comment::getArticleId));

            // 3. 构造成统一的 VO 对象列表给前端
            List<Map<String, Object>> unifiedList = new ArrayList<>();

            // 处理主评论
            for (Comment c : comments) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", c.getId());
                map.put("content", c.getContent());
                map.put("userId", c.getUserId()); // 【修复】使用 getUserId()
                map.put("created", c.getCreated());
                map.put("type", "评论");
                map.put("articleId", c.getArticleId());
                unifiedList.add(map);
            }

            // 处理回复
            for (Reply r : replies) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", r.getId());
                map.put("content", r.getContent());
                map.put("userId", r.getUserId()); // 【修复】确保 Reply.java 有 @Data
                map.put("created", r.getCreated());
                map.put("type", "回复");

                // 【修复 Bug 3】回复属于哪个评论？通过 commentId 找到对应的主评论，再拿到 articleId
                Integer parentArticleId = commentArticleMap.get(r.getCommentId());
                map.put("articleId", parentArticleId); // 这样管理页点击跳转就正常了

                unifiedList.add(map);
            }

            // 简单按时间倒序排序（可选）
            unifiedList.sort((o1, o2) -> {
                String t1 = o1.get("created").toString();
                String t2 = o2.get("created").toString();
                return t2.compareTo(t1);
            });

            result.getMap().put("list", unifiedList);
            result.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            result.setErrorMessage("获取失败");
        }
        return result;
    }


}