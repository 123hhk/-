package llp.spring.controller;

import llp.spring.tools.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@RestController
// 注意：前端上传接口写的是 /api/file/upload，经过代理后，这里映射 /file 即可
@RequestMapping("/api/file")
public class FileController {

    @Value("${file.upload-avatar-dir}")
    private String uploadPath; // 从配置文件读取 D:\my_blog_upload\

    // 返回给前端的 URL 前缀必须带 /api，这样前端访问时才能走 Vite 代理
    private static final String URL_PREFIX = "/api/file/images/";

    @PostMapping("/upload")
    public Result upload(MultipartFile file) {
        Result result = new Result();
        if (file.isEmpty()) {
            result.setErrorMessage("图片不能为空");
            return result;
        }
        try {
            // 1. 获取原文件名后缀 (如 .jpg)
            String originalFilename = file.getOriginalFilename();
            String suffix = originalFilename != null && originalFilename.contains(".")
                    ? originalFilename.substring(originalFilename.lastIndexOf("."))
                    : ".jpg";

            // 2. 生成唯一文件名 (防止用户文件名冲突)
            String newFileName = UUID.randomUUID().toString() + suffix;

            // 3. 创建保存目录 (如果 D:/my_blog_upload/ 不存在就创建)
            File destDir = new File(uploadPath);
            if (!destDir.exists()) {
                destDir.mkdirs();
            }

            // 4. 【核心动作】将图片写入硬盘
            File destFile = new File(uploadPath + newFileName);
            file.transferTo(destFile);

            // 5. 拼接访问 URL 返回给前端
            // 例如: /api/file/images/abc-123.jpg
            String fileUrl = URL_PREFIX + newFileName;

            result.getMap().put("url", fileUrl);
            result.setMsg("上传成功");

        } catch (IOException e) {
            e.printStackTrace();
            result.setErrorMessage("上传失败: " + e.getMessage());
        }
        return result;
    }
}