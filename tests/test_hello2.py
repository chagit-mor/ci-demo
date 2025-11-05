import time

from src.hello import hello


def test_type():
    time.sleep(10)
    assert isinstance(hello(),  str)
