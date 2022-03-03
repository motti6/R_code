#install.packages("tidyverse") #インストールしていない場合のみ
library("tidyverse")
library("rvest") #スクレイピングパッケージ

kabu_url <- "https://kabutan.jp/stock/kabuka?code=0000"
url_res <- read_html(kabu_url) #read_htmlでURLを読み込む

url_title <- html_nodes(url_res, css = "html > head > title")
url_title

#option+command+Iで開発者ツールを起動
kabuka <- read_html(kabu_url) %>%
  html_node(xpath = "//*[@id='stock_kabuka_table']/table[2]") %>%
  #""にはXpathを入れる。''に修正するのを忘れずに
  html_table()
head(kabuka, 10)

urls <- NULL#for文の中で要素を付け加えておくオブジェクトは
kabukas <- list()#for文の外にあらかじめ空のオブジェクトの用意が必要となる

#ページ番号抜きのURLを用意する
base_url <- "https://kabutan.jp/stock/kabuka?code=0000&ashi=day&page="

for (i in 1:5) {
  
  pgnum <- as.character(i)
  urls[i] <- paste0(base_url,pgnum)

kabukas[[i]] <- read_html(urls[i]) %>%
  html_node(xpath = "//*[@id='stock_kabuka_table']/table[2]") %>%
  html_table() %>%
  dplyr::mutate_at("前日比", as.character)

Sys.sleep(1)
}

dat <- dplyr::bind_rows(kabukas)