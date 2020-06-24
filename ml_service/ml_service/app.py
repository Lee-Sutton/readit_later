from fastapi import FastAPI
from ml_service.article_parser import parse_article

app = FastAPI()

@app.post("/parse_article/")
def get_article_details(arg1):
    """TODO: Docstring for parse_article.

    :arg1: TODO
    :returns: TODO

    """
    pass
