import protopyp


# The real reason for having this test is so that pytest will find something in an
# otherwise empty project.
def test_version_is_string():
    # As opposed to some more structured type
    assert isinstance(protopyp.__version__, str)
