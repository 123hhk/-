package llp.spring.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.Comment;
import llp.spring.entity.Reply;
import llp.spring.entity.User;
import llp.spring.entity.vo.UserCommentVO;
import llp.spring.mapper.CommentMapper;
import llp.spring.service.ICommentService;
import llp.spring.service.IOpLogService;
import llp.spring.service.IReplyService;
import llp.spring.service.IUserService;
import llp.spring.tools.IpUtils;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/comment")
public class CommentController {

    @Autowired
    private ICommentService commentService;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private IUserService userService;

    @Autowired
    private IOpLogService opLogService;

    @Autowired
    private IReplyService replyService;

    @PostMapping("/getAPageCommentByArticleId")
    public Result getAPageCommentByArticleId(Integer articleId, @RequestBody PageParams pageParams){
        Result result = new Result();
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
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username;
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            } else {
                username = principal.toString();
            }
            comment.setAuthor(username);
            comment.setCreated(LocalDateTime.now());

            String ip = IpUtils.getIpAddr(request);
            comment.setIp(ip);
            comment.setLocation(IpUtils.getCityInfo(ip));

            Comment comment1 = commentService.insert(comment);

            User user = userService.selectByUsername(username);
            if (user != null) {
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

    @PostMapping("/getAdminPage")
    public Result getAdminPage(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            long page = pageParams.getPage();
            long rows = pageParams.getRows();
            long offset = (page - 1) * rows;
            String author = pageParams.getAuthor();

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

    @PostMapping("/getMyComments")
    public Result getMyComments(String username) {
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

    @PostMapping("/getAllCommentsAndReplies")
    public Result getAllCommentsAndReplies(@RequestBody PageParams pageParams) {
        Result result = new Result();
        try {
            List<Comment> comments = commentService.list();
            List<Reply> replies = replyService.list();

            Map<Integer, Integer> commentArticleMap = comments.stream()
                    .collect(Collectors.toMap(Comment::getId, Comment::getArticleId));

            List<Map<String, Object>> unifiedList = new ArrayList<>();

            for (Comment c : comments) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", c.getId());
                map.put("content", c.getContent());
                map.put("userId", c.getUserId());
                map.put("created", c.getCreated());
                map.put("type", "评论");
                map.put("articleId", c.getArticleId());
                unifiedList.add(map);
            }

            for (Reply r : replies) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", r.getId());
                map.put("content", r.getContent());
                map.put("userId", r.getUserId());
                map.put("created", r.getCreated());
                map.put("type", "回复");
                Integer parentArticleId = commentArticleMap.get(r.getCommentId());
                map.put("articleId", parentArticleId);
                unifiedList.add(map);
            }

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

    // === 【核心修复】评论点赞/取消点赞 ===
    @PostMapping("/likeComment")
    public Result likeComment(Integer commentId) {
        // 1. 获取当前用户 (修复类型转换错误)
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

        // 2. 检查是否点过
        Integer count = commentMapper.countCommentLike(user.getId(), commentId);

        if (count > 0) {
            // === 取消点赞 ===
            try {
                commentMapper.deleteCommentLike(user.getId(), commentId);
                commentMapper.decreaseLikes(commentId);
                return new Result(true, "取消点赞");
            } catch (Exception e) {
                e.printStackTrace();
                return new Result(false, "操作失败");
            }
        } else {
            // === 点赞 ===
            try {
                commentMapper.insertCommentLike(user.getId(), commentId);
                commentMapper.increaseLikes(commentId);
                return new Result(true, "点赞成功");
            } catch (Exception e) {
                e.printStackTrace();
                return new Result(false, "已点赞");
            }
        }
    }
}