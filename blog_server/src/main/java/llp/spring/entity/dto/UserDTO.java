package llp.spring.entity.dto;

import com.fasterxml.jackson.annotation.JsonFormat; // 引入注解
import llp.spring.entity.User;
import lombok.Data;
import org.springframework.beans.BeanUtils;
import java.time.LocalDateTime; // 引入时间类型

import java.util.List;

@Data
public class UserDTO {
    private Integer id;
    private String username;
    private String email;      // 为了安全，未加入密码属性
    private Boolean valid;
    private List<String> authorities;    // 权限

    // 【修复】添加创建时间字段，并指定格式
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime created;

    public static void dtoToEntity(UserDTO dto, User entity) {
        BeanUtils.copyProperties(dto, entity);
    }

    // 将实体类对象转换为DTO对象
    public static UserDTO entityToDto(User entity) {
        UserDTO dto = new UserDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }
}