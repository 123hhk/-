package llp.spring.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.Reply;
import llp.spring.mapper.ReplyMapper;
import llp.spring.service.IReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl extends ServiceImpl<ReplyMapper, Reply> implements IReplyService {

    @Autowired
    private ReplyMapper replyMapper;

    @Override
    public List<Reply> getRepliesByCommentId(Integer commentId, int page, int rows) {
        int offset = (page - 1) * rows;
        // 调用 Mapper 里写好的关联查询
        return replyMapper.getRepliesByCommentId(commentId, offset, rows);
    }

    @Override
    public Integer countByCommentId(Integer commentId) {
        return replyMapper.countByCommentId(commentId);
    }
}