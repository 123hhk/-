// 20251217新增功能

package llp.spring.controller;

import llp.spring.entity.Reply;
import llp.spring.mapper.ReplyMapper;
import llp.spring.tools.IpUtils;
import llp.spring.tools.Result;
import llp.spring.tools.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

// 20251216新增功能 - 修改用户名为真实用户名
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api/reply")
public class ReplyController {

    @Autowired
    private ReplyMapper replyMapper;

    // 添加回复
    @PostMapping("/insert")
    public Result insert(@RequestBody Reply reply, HttpServletRequest request) {
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
            reply.setAuthor(username);

            reply.setCreated(LocalDateTime.now());

            // 【新增代码开始】 ===
            String ip = IpUtils.getIpAddr(request);
            reply.setIp(ip);
            reply.setLocation(IpUtils.getCityInfo(ip)); // 设置属地
            // 【新增代码结束】 ===

            replyMapper.insert(reply);
            result.getMap().put("reply", reply);
            result.setMsg("回复成功!");
        } catch (Exception e) {
            result.setErrorMessage("回复失败!");
            e.printStackTrace();
        }
        return result;
    }

    // 获取某评论的子评论（支持分页/加载更多）
    @GetMapping("/getReplies")
    public Result getReplies(Integer commentId, int page, int rows) {
        Result result = new Result();
        try {
            int offset = (page - 1) * rows;
            List<Reply> replies = replyMapper.getRepliesByCommentId(commentId, offset, rows);
            Integer total = replyMapper.countByCommentId(commentId);

            result.getMap().put("replies", replies);
            result.getMap().put("total", total);
        } catch (Exception e) {
            result.setErrorMessage("获取回复失败!");
            e.printStackTrace();
        }
        return result;
    }
}