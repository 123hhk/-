package llp.spring.config.security;


import com.fasterxml.jackson.databind.ObjectMapper;
import llp.spring.entity.User;
import llp.spring.mapper.UserMapper;
import llp.spring.tools.Result;
import llp.spring.entity.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class MyAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private UserMapper userMapper;

    @Override // 用户认证成功后执行
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        String username = request.getParameter("username"); // 客户端传过来的用户名

        // 查询用户信息
        User user = userMapper.findByName(username);
        UserDTO userDTO = UserDTO.entityToDto(user);
        userDTO.setAuthorities(userMapper.findAuthorityByName(username));

        // 将用户数据保存到session中
        request.getSession().setAttribute("user", userDTO);

        Result result = new Result();
        result.getMap().put("user", userDTO);

        // 返回数据给客户端，用于客户端路由转换（如管理员只能访问某些功能）
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(objectMapper.writeValueAsString(result));
    }
}
