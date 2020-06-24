from newspaper import Article

def parse_article(url: str):
    """
    Scrapes the article at the input url and returns the following attributes: 
    title, article_html, top image

    :param url: url where the article is located
    """
    article = Article(url, keep_article_html=True)
    article.download()
    article.parse()
    return {"title": article.title, "article_html": article.article_html, "top_image": article.top_image}

