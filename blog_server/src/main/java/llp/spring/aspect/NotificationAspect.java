package llp.spring.aspect;

import llp.spring.entity.Article;
import llp.spring.entity.Comment;
import llp.spring.entity.Notification;
import llp.spring.entity.Reply;
import llp.spring.entity.User;
import llp.spring.service.ArticleService;
import llp.spring.service.INotificationService;
import llp.spring.service.IUserService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Aspect
@Component
public class NotificationAspect {

    @Autowired
    private INotificationService notificationService;
    @Autowired
    private ArticleService articleService;
    @Autowired
    private IUserService userService;

    // 1. 监听评论文章
    @AfterReturning(pointcut = "execution(* llp.spring.controller.CommentController.insert(..))", returning = "result")
    public void afterComment(JoinPoint joinPoint, Object result) {
        // 从参数中获取 Comment 对象
        Object[] args = joinPoint.getArgs();
        if (args.length > 0 && args[0] instanceof Comment) {
            Comment comment = (Comment) args[0];

            // 获取当前登录用户 (发送者)
            User sender = getCurrentUser();
            if (sender == null) return;

            // 获取文章作者 (接收者)
            Article article = articleService.getById(comment.getArticleId());
            if (article == null) return;
            Integer receiverId = article.getUserId(); // 假设 Article 实体里存了 userId

            // 自己评论自己不发通知
            if (sender.getId().equals(receiverId)) return;

            // 构建通知
            Notification notification = new Notification();
            notification.setSenderId(sender.getId());
            notification.setSenderName(sender.getUsername());
            notification.setReceiverId(receiverId);
            notification.setArticleId(article.getId());
            notification.setType("COMMENT");
            notification.setContent("评论了你的文章: " + truncate(comment.getContent()));
            notification.setIsRead(false);
            notification.setCreated(LocalDateTime.now());

            notificationService.save(notification);
        }
    }

    // 2. 监听回复评论
    @AfterReturning(pointcut = "execution(* llp.spring.controller.ReplyController.insert(..))", returning = "result")
    public void afterReply(JoinPoint joinPoint, Object result) {
        Object[] args = joinPoint.getArgs();
        if (args.length > 0 && args[0] instanceof Reply) {
            Reply reply = (Reply) args[0];

            User sender = getCurrentUser();
            if (sender == null) return;

            // 接收者：reply.toUid (前端传过来的被回复人ID)
            Integer receiverId = reply.getToUid();
            if (receiverId == null) return;

            if (sender.getId().equals(receiverId)) return;

            // 注意：Reply 对象里可能暂时没有 articleId，需要根据 commentId 去查，或者前端传
            // 为了简单，我们只通知 "收到一条新回复"，或者在 ReplyController 插入时前端把 articleId 也传进来
            // 这里假设 Reply 暂时不方便获取 ArticleId，设为 null 或者你在 Reply 实体加个字段

            Notification notification = new Notification();
            notification.setSenderId(sender.getId());
            notification.setSenderName(sender.getUsername());
            notification.setReceiverId(receiverId);
            // notification.setArticleId(...); // 如果能获取最好
            notification.setType("REPLY");
            notification.setContent("回复了你的评论: " + truncate(reply.getContent()));
            notification.setIsRead(false);
            notification.setCreated(LocalDateTime.now());

            notificationService.save(notification);
        }
    }

    private User getCurrentUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            return userService.selectByUsername(username);
        }
        return null;
    }

    private String truncate(String content) {
        if (content == null) return "";
        return content.length() > 20 ? content.substring(0, 20) + "..." : content;
    }
}