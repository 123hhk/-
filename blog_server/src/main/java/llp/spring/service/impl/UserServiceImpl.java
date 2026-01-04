package llp.spring.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import llp.spring.entity.Authority;
import llp.spring.entity.User;
import llp.spring.entity.UserAuthority;
import llp.spring.mapper.UserMapper;
import llp.spring.service.IAuthorityService;
import llp.spring.service.IUserAuthorityService;
import llp.spring.service.IUserService;
import llp.spring.tools.Result;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private IUserAuthorityService userAuthorityService;

    @Autowired
    private IAuthorityService authorityService;

    // 20251217新增功能 - 个人中心与浏览足迹
    @Autowired
    private UserMapper userMapper;


    @Override
    @Transactional
    public Result register(User user) {
        Result result = new Result();

        try {
            // 1. 检查用户名是否已存在
            LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(User::getUsername, user.getUsername());
            User existingUser = this.getOne(queryWrapper);
            if (existingUser != null) {
                result.setErrorMessage("用户名已存在！");
                return result;
            }

            // 2. 检查邮箱是否已存在（如果需要）
            if (user.getEmail() != null && !user.getEmail().trim().isEmpty()) {
                LambdaQueryWrapper<User> emailQueryWrapper = new LambdaQueryWrapper<>();
                emailQueryWrapper.eq(User::getEmail, user.getEmail());
                User existingEmail = this.getOne(emailQueryWrapper);
                if (existingEmail != null) {
                    result.setErrorMessage("邮箱已被注册！");
                    return result;
                }
            }

            // 3. 设置用户属性
            user.setPassword(passwordEncoder.encode(user.getPassword())); // 密码加密
            user.setValid(true); // 默认启用账户
            user.setCreated(LocalDateTime.now()); // 创建时间

            // 4. 保存用户
            boolean saveSuccess = this.save(user);
            if (!saveSuccess) {
                result.setErrorMessage("用户注册失败！");
                return result;
            }

            // 5. 为新用户分配默认权限（ROLE_common）
            // 首先查询普通用户权限的ID
            LambdaQueryWrapper<Authority> authorityQueryWrapper = new LambdaQueryWrapper<>();
            authorityQueryWrapper.eq(Authority::getAuthority, "ROLE_common");
            Authority commonAuthority = authorityService.getOne(authorityQueryWrapper);

            if (commonAuthority == null) {
                // 如果权限表中没有ROLE_common，创建它
                commonAuthority = new Authority();
                commonAuthority.setAuthority("ROLE_common");
                authorityService.save(commonAuthority);
            }

            UserAuthority userAuthority = new UserAuthority();
            userAuthority.setUserId(user.getId());
            userAuthority.setAuthorityId(commonAuthority.getId());
            userAuthorityService.save(userAuthority);

            result.setSuccess(true);
            result.setMsg("注册成功！");

        } catch (Exception e) {
            result.setErrorMessage("注册失败！");
            e.printStackTrace();
        }

        return result;
    }

    @Override
    public Result checkUsername(String username) {
        Result result = new Result();

        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getUsername, username);
        User existingUser = this.getOne(queryWrapper);

        if (existingUser != null) {
            result.setErrorMessage("用户名已存在");
        } else {
            result.setSuccess(true);
            result.setMsg("用户名可用");
        }

        return result;
    }

    // 20251217新增功能 - 个人中心与浏览足迹
    // --- 实现接口定义的方法 ---
    @Override
    public User selectByUsername(String username) {
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("username", username);
        return userMapper.selectOne(wrapper);
    }
}