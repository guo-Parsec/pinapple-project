package org.pineapple.common.utils;

import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * <p>xml工具类</p>
 *
 * @author guocq
 * @since 2023/2/23
 */
public class XmlUtil {
    private static final Logger log = LoggerFactory.getLogger(XmlUtil.class);

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
