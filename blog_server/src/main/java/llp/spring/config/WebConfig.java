package llp.spring.config;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;

@Configuration // Spring的配置注释
public class WebConfig implements WebMvcConfigurer {
    // 1. 注入配置文件中的路径
    @Value("${file.upload-images-dir}")
    private String uploadImagesDir;

    // 2. [新增] 注入新的头像上传路径
    @Value("${file.upload-avatar-dir}")
    private String uploadAvatarDir;

    // 【新增】注入文章图片路径
    @Value("${file.article-img-dir}")
    private String articleImgDir;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 2. 使用注入的变量替代硬编码
        registry.addResourceHandler("/api/images/**")
                .addResourceLocations("file:" + uploadImagesDir);
        // [新增] 配置 article_img 的映射
        // 请确保 E:\img\article_img\ 目录下有你的图片（如 roadmap/1.jpg）
        registry.addResourceHandler("/api/article_img/**")
                .addResourceLocations("file:" + articleImgDir);

        // 3. [修改] 头像上传映射，使用配置文件中的变量
        // 访问 /api/file/images/** -> 去 D:\my_blog_upload\ 找
        registry.addResourceHandler("/file/images/**")
                .addResourceLocations("file:" + uploadAvatarDir);
    }

    @Override
    public void extendMessageConverters(List<HttpMessageConverter<?>> converters) {
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        ObjectMapper objectMapper = converter.getObjectMapper();
        // 时间格式化
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        // 设置格式化内容
        converter.setObjectMapper(objectMapper);
        converters.add(0, converter);
    }
}