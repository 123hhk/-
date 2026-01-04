package llp.spring.service;

import com.baomidou.mybatisplus.extension.service.IService;
import llp.spring.entity.Category;
import java.util.List;

public interface ICategoryService extends IService<Category> {
    List<Category> getTree(); // 获取树形结构数据
}