package org.pineapple.common.utils;

import java.io.Closeable;
import java.io.IOException;
import java.util.function.Consumer;

/**
 * <p>io工具类</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
public class IOUtil {
    public static void closeQuietly(final Closeable closeable, final Consumer<IOException> consumer) {
        if (closeable != null) {
            try {
                closeable.close();
            } catch (final IOException e) {
                if (consumer != null) {
                    consumer.accept(e);
                }
            }
        }
    }
}
