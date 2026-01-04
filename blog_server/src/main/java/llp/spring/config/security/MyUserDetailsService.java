package llp.spring.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import llp.spring.entity.User;
import llp.spring.mapper.UserMapper;
import java.util.ArrayList;
import java.util.List;

@Service
public class MyUserDetailsService implements UserDetailsService {

    @Autowired
    private UserMapper userMapper;

    @Override // 用于查找用户及其密码、权限等信息
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 此处的User类是数据库实体类
        User user = userMapper.findByNameWithValid(username);

        if (null == user) {
            throw new UsernameNotFoundException("用户不存在或已被禁用: " + username);
        }

        // 查找用户拥有的权限（角色）
        List<String> authorityNames = userMapper.findAuthorityByName(username);
        List<SimpleGrantedAuthority> authorities = new ArrayList<>();
        for (String authorityName : authorityNames) {
            authorities.add(new SimpleGrantedAuthority(authorityName));
        }

        // 此处的User类是Spring Security的User类
        return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(),
                authorities
        );
    }
}