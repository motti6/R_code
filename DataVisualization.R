library("tidyverse")

ggplot() +
  geom_histogram(data = mpg, mapping = aes(x = displ))

ggplot() +
  geom_density(data = mpg, mapping = aes(x = displ))

ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = cty), method = "lm")
 #共通項はggplot()内で指定可能
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  geom_smooth(method = "lm")
#dplyrで抽出可能
mpg1999 <- filter(mpg, year == 1999)
mpg2008 <- filter(mpg, year == 2008)

ggplot(mapping = aes(x = displ, y = cty)) +
  geom_point(data = mpg1999) +
  geom_point(data = mpg2008)

#グラデーション #cylはグループ分けする際の因子
ggplot(data = mpg, mapping = aes(x = displ, y = cty, group = cyl, colour = cyl)) +
  geom_point()

#因子型による色識別
ggplot(data = mpg, mapping = aes(x = displ, y = cty, group = factor(cyl), colour = factor(cyl))) +
  geom_point()
#因子によるグループ化  
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  geom_smooth(mapping = aes(group =factor(cyl)), method = "lm")

#線の種類で識別
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  geom_smooth(mapping = aes(linetype = factor(year)), method = "lm")
#形状で識別
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point(mapping = aes(colour = factor(cyl), shape = factor(cyl)))
#データ強調
add_x <- c(2.5, 3, 3.5)
add_y <- c(25, 27.5, 30)

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  annotate(geom = "point", x = add_x, y = add_y, colour = "red")

#描画分割(四分割)
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  facet_wrap(~ cyl)

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  facet_grid(. ~cyl)

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point() +
  facet_grid(cyl ~ .)

#classごとにctyの平均点を算出
mean_cty <- mpg %>%
  group_by(class) %>%
  summarise(cty = mean(cty))

ggplot(data = mean_cty, mapping = aes(x = class, y = cty)) +
  geom_bar(stat = "identity")

#範囲を描画
ggplot(data = mpg, mapping = aes(x = class, y = cty)) +
  stat_summary(geom = "pointrange", fun.y = "mean", fun.ymax = "max", fun.ymin = "min")
#箱ひげ図
ggplot(data = mpg, mapping = aes(x = class, y = cty)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#GUI
#install.packages("ggplotgui")#未インストールの場合のみ
#install.packages("plotly")
library("ggplotgui")
library("plotly")

ggplot_shiny(dataset = mpg)

