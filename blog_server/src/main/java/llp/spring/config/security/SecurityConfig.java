package llp.spring.config.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true) // 启用方法级别的权限认证
public class SecurityConfig extends WebSecurityConfigurerAdapter { // 权限配置

    @Autowired
    private MyUserDetailsService myUserDetailsService;

    @Autowired
    private MyAuthenticationFailureHandler myAuthenticationFailureHandler;

    @Autowired
    private MyAuthenticationSuccessHandler myAuthenticationSuccessHandler;

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .cors() // 【新增】开启 Spring Security 的跨域支持
                .and()
                .authorizeRequests();
        http.authorizeRequests()
                // 1. 自定义用户访问控制
                .antMatchers(
                        "/",                  // 【新增】允许访问根路径
                        "/index.html",        // 【新增】允许访问首页文件
                        "/assets/**",         // 【新增】允许访问 Vue 打包后的静态资源 (js, css)
                        "/favicon.ico",       // 【新增】允许访问图标
                        "/images/**",
                        "/file/images/**",
                        // 【修改】下面这些都要加上 /api
                        "/api/article/articleSearch",
                        "/api/article/getIndexData1",
                        "/api/article/getAPageOfArticle",
                        "/api/article/getIndexData",
                        "/api/article/getArticleAndFirstPageCommentByArticleId",
                        "/api/article/selectById",
                        "/api/comment/getAPageCommentByArticleId",
                        "/api/user/register",
                        "/api/user/checkUsername",
                        "/api/category/**"
                )
                .permitAll() // 任意访问
                .antMatchers(
                        "/api/article/deleteById",
                        "/api/article/getAPageOfArticleVO"
                )
                .hasRole("admin") // 管理员权限
                // 20251217新增功能 - 个人中心与浏览足迹
                // 修改为: 把 /oplog/** 也加进来，允许有角色的人访问
                .antMatchers("/comment/insert",
                        "/oplog/**",
                        "/reply/**",
                        "/comment/getUserComments",
                        "/user/updateInfo",
                        "/api/article/upload",
                        "/api/article/publishArticle")

                .hasAnyRole("common", "admin") // [建议] 改为 hasAnyRole，这样管理员也能发评论、看日志

                .anyRequest().authenticated()
                .and()
                // 2. 自定义用户登录控制
                .formLogin()
                .loginProcessingUrl("/api/login") // 【新增】指定处理登录请求的URL为 /api/login
                .failureHandler(myAuthenticationFailureHandler) // 权限验证失败的处理
                .successHandler(myAuthenticationSuccessHandler) // 权限验证成功的处理
                .permitAll() // 登录页面所有人可以访问
                .and()
                .logout() // 注销用户
                .logoutUrl("/api/logout") // 注销网址
                .logoutSuccessHandler(new LogoutSuccessHandler() {
                    @Override
                    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response,
                                                Authentication authentication) throws IOException {
                        request.getSession().removeAttribute("user");
                        response.setContentType("application/json;charset=utf-8");
                        response.getWriter().write(objectMapper.writeValueAsString(
                                new Result(true, "登出成功")));
                    }
                })
                .permitAll()

                .and()
                .csrf().disable() // 禁用跨站csrf攻击防御
                // 防止错误：Refused to display in a frame because it set 'X-Frame-Options' to 'DENY'
                .headers().frameOptions().disable();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(myUserDetailsService).passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // 密码加密策略
    }
}