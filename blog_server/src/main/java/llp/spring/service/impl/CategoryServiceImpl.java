package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import llp.spring.entity.Category;
import llp.spring.mapper.CategoryMapper;
import llp.spring.service.ICategoryService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements ICategoryService {

    @Override
    public List<Category> getTree() {
        // 1. 查出所有分类，按 sort 排序
        QueryWrapper<Category> wrapper = new QueryWrapper<>();
        wrapper.orderByAsc("sort");
        List<Category> allCategories = baseMapper.selectList(wrapper);

        // 2. 使用 Stream 流构建树形结构
        return allCategories.stream()
                .filter(c -> c.getParentId() == 0) // 找到所有根节点
                .map(root -> {
                    root.setChildren(getChildren(root, allCategories));
                    return root;
                })
                .collect(Collectors.toList());
    }

    // 递归查找子节点
    private List<Category> getChildren(Category root, List<Category> all) {
        List<Category> children = all.stream()
                .filter(c -> Objects.equals(c.getParentId(), root.getId()))
                .map(child -> {
                    child.setChildren(getChildren(child, all)); // 递归调用
                    return child;
                })
                .collect(Collectors.toList());
        // 如果没有子节点，返回null，这样前端级联组件不会显示空的子级菜单
        return children.isEmpty() ? null : children;
    }
}