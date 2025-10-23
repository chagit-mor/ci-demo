from src.hello import hello


def test_hello():
    assert hello() == "Hello, DevOps"
def test_type():
    assert isinstance(hello(),  str)
