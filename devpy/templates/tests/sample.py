# content of test_sample.py
def inc(x):
    return x + 1


def test_answer():
    value = 4
    import ipdb; ipdb.set_trace()
    from IPython import embed; embed(colors="neutral")
    assert inc(value) == 5
