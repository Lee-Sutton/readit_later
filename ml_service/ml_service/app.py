from fastapi import FastAPI
from pydantic import BaseModel
from ml_service.article_parser import parse_article


class Article(BaseModel):
    url: str


app = FastAPI()


@app.post("/parse_article")
def parse_article_endpoint(article: Article):
    return parse_article(article.url)
