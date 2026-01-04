package llp.spring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.boot.CommandLineRunner;
import org.springframework.data.redis.core.RedisTemplate;

@EnableCaching
@SpringBootApplication
@MapperScan("llp.spring.mapper")
public class BlogServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(BlogServerApplication.class, args);
    }

    /**
     * 核弹级缓存清理
     * 项目启动后，直接获取底层连接，执行 flushDb
     * 切记千千万万不要随意启用!!!!!!!!!!
     */
    //@Bean
    public CommandLineRunner manualFlushDB(RedisTemplate redisTemplate) {
        return args -> {
            System.out.println("=========================================");
            System.out.println(">>> 正在执行 FLUSHDB (清空数据库)...");

            // 核心代码：拿到连接，直接执行命令，绕过所有序列化机制
            redisTemplate.getConnectionFactory().getConnection().flushDb();

            System.out.println(">>> FLUSHDB 执行完毕！Redis 已变为空白。");
            System.out.println("=========================================");
        };
    }
}