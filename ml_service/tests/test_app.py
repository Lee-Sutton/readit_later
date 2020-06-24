from ml_service.app import app
from fastapi.testclient import TestClient
from unittest.mock import patch, MagicMock

client = TestClient(app)


@patch("ml_service.app.parse_article")
def test_parse_article_endpoint(mock_parse_article: MagicMock):
    article_content = {"title": "test article title", "content": "Dummy content"}
    mock_parse_article.return_value = article_content
    response = client.post("/parse_article", json={"url": "test.com"})

    mock_parse_article.assert_called()

    assert response.status_code == 200
    assert response.json() == article_content
