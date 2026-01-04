package llp.spring.service;

import com.baomidou.mybatisplus.extension.service.IService;
import llp.spring.entity.Reply;
import java.util.List;

// 继承 MyBatis-Plus 的通用接口
public interface IReplyService extends IService<Reply> {

    // 获取某条评论下的回复列表
    List<Reply> getRepliesByCommentId(Integer commentId, int page, int rows);

    // 获取某条评论下的回复总数
    Integer countByCommentId(Integer commentId);
}