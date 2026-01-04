package llp.spring.tools;

import org.lionsoul.ip2region.xdb.Searcher;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.FileCopyUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;

public class IpUtils {

    // 缓存 ip2region 的数据，防止每次请求都读文件
    private static byte[] cBuff;

    static {
        try {
            // 从资源文件夹加载 ip2region.xdb
            ClassPathResource resource = new ClassPathResource("ip2region.xdb");
            InputStream inputStream = resource.getInputStream();
            cBuff = FileCopyUtils.copyToByteArray(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("ip2region.xdb 加载失败，IP属地功能将受限！");
        }
    }

    /**
     * 根据IP获取精准物理地址
     * 返回格式：中国 广东 深圳 | 美国 犹他州
     */
    public static String getCityInfo(String ip) {
        if (ip == null || ip.isEmpty()) return "未知";
        if ("127.0.0.1".equals(ip) || "0:0:0:0:0:0:0:1".equals(ip) || ip.startsWith("192.168.")) {
            return "本地局域网";
        }

        try {
            // 创建搜索对象 (Searcher 不是线程安全的，所以每次查询创建一个，或者使用 ThreadLocal)
            // 由于我们已经预加载了 byte[]，这里创建 Searcher 非常快 (微秒级)
            Searcher searcher = Searcher.newWithBuffer(cBuff);

            // 查询格式：国家|区域|省份|城市|ISP
            // 例如：中国|0|上海|上海市|联通
            String region = searcher.search(ip);

            // 关闭资源 (因为是基于内存 buffer 的，其实不关也没事，但为了规范还是关一下)
            searcher.close();

            if (region != null && !region.isEmpty()) {
                return parseRegion(region);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // 解析失败时，回退到简易显示
            return "未知星球";
        }
        return "未知";
    }

    /**
     * 解析 ip2region 返回的字符串，提取友好显示的地址
     */
    private static String parseRegion(String region) {
        // 格式：国家|区域|省份|城市|ISP
        String[] parts = region.split("\\|");
        if (parts.length < 5) return region;

        String country = parts[0]; // 国家
        String province = parts[2]; // 省份
        String city = parts[3]; // 城市

        if ("0".equals(country)) country = "未知";
        if ("0".equals(province)) province = "";
        if ("0".equals(city)) city = "";

        // 国内显示逻辑
        if ("中国".equals(country)) {
            // 如果省份和城市一样（如：上海 上海市），只显示一个
            if (province.startsWith(city) || city.startsWith(province)) {
                return province;
            }
            return province + " " + city;
        }

        // 国外显示逻辑
        if (!province.isEmpty()) {
            return country + " " + province;
        }
        return country;
    }

    /**
     * 获取客户端真实 IP 地址 (保持不变)
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ipAddress = null;
        try {
            ipAddress = request.getHeader("x-forwarded-for");
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("WL-Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getRemoteAddr();
                if (ipAddress.equals("127.0.0.1") || ipAddress.equals("0:0:0:0:0:0:0:1")) {
                    try {
                        InetAddress inet = InetAddress.getLocalHost();
                        ipAddress = inet.getHostAddress();
                    } catch (UnknownHostException e) {
                        e.printStackTrace();
                    }
                }
            }
            if (ipAddress != null && ipAddress.length() > 15) {
                if (ipAddress.indexOf(",") > 0) {
                    ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
                }
            }
        } catch (Exception e) {
            ipAddress = "";
        }
        return ipAddress;
    }
}