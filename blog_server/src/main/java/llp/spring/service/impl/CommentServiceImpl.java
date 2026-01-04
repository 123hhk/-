package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.Comment;
import llp.spring.mapper.CommentMapper;
import llp.spring.service.ICommentService;
import llp.spring.tools.PageParams;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author baomidou
 * @since 2025-10-31
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Autowired
    private CommentMapper commentMapper;

    public Comment insert(Comment comment){
        commentMapper.insert(comment);
        return comment;
    }

    public Result getAPageCommentByArticleId(Integer articleId, PageParams pageParams) {
        Page<Comment> page = new Page<>(pageParams.getPage(), pageParams.getRows());
        QueryWrapper<Comment> wrapper = new QueryWrapper<>();
        wrapper.eq("article_id", articleId);

        // === 【新增】评论排序逻辑 ===
        if ("hot".equals(pageParams.getSort())) {
            wrapper.orderByDesc("likes"); // 按点赞数
        } else {
            wrapper.orderByDesc("id");    // 按最新
        }
        // ==========================

        IPage<Comment> iPage = commentMapper.selectPage(page, wrapper);

        Result result = new Result();
        result.setSuccess(true);
        result.getMap().put("comments", iPage.getRecords());
        result.getMap().put("total", iPage.getTotal());
        return result;
    }

    // 评论管理功能
    // --- 新增实现：管理员获取评论列表 ---
    public Result getAdminPage(PageParams pageParams) {
        QueryWrapper<Comment> wrapper = new QueryWrapper<>();
        // 按时间倒序或ID倒序排列
        wrapper.orderBy(true, false, "id");

        Page<Comment> page = new Page<>(pageParams.getPage(), pageParams.getRows());
        Page<Comment> aPage = commentMapper.selectPage(page, wrapper);

        Result result = new Result();
        // 将分页记录和总数都放入结果
        result.getMap().put("comments", aPage.getRecords());
        // 关键：返回总条数给前端分页组件
        pageParams.setTotal(aPage.getTotal());
        result.getMap().put("pageParams", pageParams);

        return result;
    }

    // --- 新增实现：删除评论 ---
    public void deleteById(Integer id) {
        commentMapper.deleteById(id);
    }
}
