package com.hnu.highlynewapp.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.awt.*;

@Component
@ConfigurationProperties(prefix = "watermark")
public class WatermarkConfig {
    private Visible visible = new Visible();
    private Stegano stegano = new Stegano();

    public Visible getVisible() {
        return visible;
    }

    public void setVisible(Visible visible) {
        this.visible = visible;
    }

    public Stegano getStegano() {
        return stegano;
    }

    public void setStegano(Stegano stegano) {
        this.stegano = stegano;
    }

    public static class Visible {
        private boolean enabled = true;
        private String text = "yecheng_APP@HNU";
        private String color = "PINK";
        private float opacity = 1.0f;

        public boolean isEnabled() {
            return enabled;
        }

        public void setEnabled(boolean enabled) {
            this.enabled = enabled;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public String getColor() {
            return color;
        }

        public void setColor(String color) {
            this.color = color;
        }

        public float getOpacity() {
            return opacity;
        }

        public void setOpacity(float opacity) {
            this.opacity = opacity;
        }

        /**
         * 将字符串颜色名称转换为Color对象
         */
        public Color getColorObject() {
            try {
                java.lang.reflect.Field field = Color.class.getField(color.toUpperCase());
                return (Color) field.get(null);
            } catch (Exception e) {
                // 如果颜色名称无效，返回默认的粉色
                return Color.PINK;
            }
        }
    }

    public static class Stegano {
        private String prefix = "yecheng_APP@HNU: ";

        public String getPrefix() {
            return prefix;
        }

        public void setPrefix(String prefix) {
            this.prefix = prefix;
        }
    }
}
