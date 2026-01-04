package llp.spring.controller;

import llp.spring.entity.User;
import llp.spring.entity.dto.UserDTO;
import llp.spring.mapper.UserMapper;
import llp.spring.service.IUserService;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import org.springframework.util.StringUtils; // 建议引入
@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private IUserService userService;

    @Autowired
    private UserMapper userMapper;

    @PostMapping("/register")
    public Result register(@RequestBody User user) {
        return userService.register(user);
    }

    @GetMapping("/checkUsername")
    public Result checkUsername(@RequestParam String username) {
        return userService.checkUsername(username);
    }

    // 替换原来的 updateInfo 方法
    @PostMapping("/updateInfo")
    public Result updateInfo(@RequestBody User user) {
        Result result = new Result();
        try {
            // 1. 获取当前登录用户
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String currentUsername = ((UserDetails) principal).getUsername();
            User currentUser = userService.selectByUsername(currentUsername);

            if (currentUser != null) {
                // 2. 检查用户名修改
                if (user.getUsername() != null && !user.getUsername().equals(currentUser.getUsername())) {
                    User checkUser = userService.selectByUsername(user.getUsername());
                    if (checkUser != null) {
                        result.setErrorMessage("该用户名已被占用，请更换！");
                        return result;
                    }
                    currentUser.setUsername(user.getUsername());
                }

                // 3. 更新其他信息
                if (user.getEmail() != null) {
                    currentUser.setEmail(user.getEmail());
                }

                // 【修复】添加头像更新逻辑
                if (user.getAvatar() != null && !user.getAvatar().isEmpty()) {
                    currentUser.setAvatar(user.getAvatar());
                }

                // 【建议】如果 UserDTO 有昵称 name 字段，这里也应该更新
                // if (user.getName() != null) currentUser.setName(user.getName());

                // 4. 执行更新
                userService.updateById(currentUser);

                // 重新封装 UserDTO 返回给前端更新 Store
                UserDTO userDTO = UserDTO.entityToDto(currentUser);
                // 补充权限信息(因为entity里没有)
                userDTO.setAuthorities(userMapper.findAuthorityByName(currentUser.getUsername()));

                result.getMap().put("user", userDTO); // 返回 DTO 更规范
                result.setMsg("修改成功");
                result.setSuccess(true);
            }
        } catch (Exception e) {
            result.setErrorMessage("修改失败");
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 【新增】获取当前登录用户信息（用于前端初始化检查登录状态）
     */
    @GetMapping("/currentUser")
    public Result currentUser() {
        Result result = new Result();
        try {
            // 1. 从 Spring Security 上下文中获取当前认证信息
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            // 2. 判断是否是已登录用户 (未登录时 principal 通常是字符串 "anonymousUser")
            if (principal instanceof UserDetails) {
                String username = ((UserDetails) principal).getUsername();
                User user = userService.selectByUsername(username);

                if (user != null) {
                    user.setPassword(null); // 安全起见，抹除密码
                    result.getMap().put("user", user);
                    result.setSuccess(true);
                    result.setMsg("已登录");
                    return result;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. 如果没取到用户，返回失败
        result.setSuccess(false);
        result.setErrorMessage("未登录或会话已过期");
        return result;
    }
}