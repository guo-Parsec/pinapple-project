package org.pineapple.common.utils;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.dom4j.tree.DefaultElement;
import org.pineapple.common.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * <p>xml工具类</p>
 *
 * @author guocq
 * @since 2023/2/23
 */
public class XmlUtil {
    private static final Logger log = LoggerFactory.getLogger(XmlUtil.class);

    public static void main(String[] args) throws DocumentException {
        SAXReader reader = new SAXReader();
        File file = new File("D:\\Code\\mine-space\\project\\pineapple-project\\pineapple-service-system\\pineapple-system-core\\src\\main\\resources\\sys-dict-query-config.xml");
        Document document = reader.read(file);
        if (document == null) {
            throw ErrorRecords.error.record(log, "解析xml失败");
        }
        Element rootElement = document.getRootElement();
        List<Node> content = rootElement.content();
        for (Node node : content) {
            if (!(node instanceof DefaultElement)) {
                continue;
            }
            DefaultElement element = (DefaultElement) node;

        }

    }

    public static Map<String, Object> xmlToMap(Element element) {
        Map<String, Object> resultMap = new HashMap<>();
//        if (element.isTextOnly()) {
//            resultMap.put(element.getName(), element.getText());
//            return resultMap;
//        }
        Iterator<Element> ite = element.elementIterator();
        while (ite.hasNext()) {
            resultMap.put(element.getName(), xmlToMap(ite.next()));
//            xmlToMap(ite.next());
        }
        return resultMap;
    }
}
