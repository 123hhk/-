package llp.spring.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDate;
import lombok.Getter;
import lombok.Setter;

// 20251217新增功能 - 修改DATE为DATETIME
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonFormat;
/**
 * <p>
 * 
 * </p>
 *
 * @author baomidou
 * @since 2025-10-31
 */
@Getter
@Setter
@TableName("t_user")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String username;

    private String password;

    private String email;

    // 20251217新增功能 - 修改DATE为DATETIME
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime created;

    private Boolean valid;

    private String avatar;
}
