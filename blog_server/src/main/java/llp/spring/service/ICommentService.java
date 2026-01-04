package llp.spring.service;

import llp.spring.entity.Comment;
import com.baomidou.mybatisplus.extension.service.IService;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author baomidou
 * @since 2025-10-31
 */
public interface ICommentService extends IService<Comment> {
    public Result getAPageCommentByArticleId(Integer articleId, PageParams pageParams);
    public Comment insert(Comment comment);

    // 评论管理功能
    // --- 新增：管理员获取评论列表 ---
    public Result getAdminPage(PageParams pageParams);
    // --- 新增：删除评论 ---
    public void deleteById(Integer id);
}

