def fun(x):
    return x + 1


def test_3_equals_4():
    assert fun(3) == 4


def test_3_equals_4_failed():
    assert fun(3) == 3
