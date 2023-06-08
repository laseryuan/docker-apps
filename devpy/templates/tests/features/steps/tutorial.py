from behave import *

@given('we have behave installed')
def step_impl(context):
    pass

@when('we implement a test')
def step_impl(context):
    assert True is not False

@then('behave will test it for us!')
def step_impl(context):
    my_var = 10 / 3
    import ipdb; ipdb.set_trace()
    assert context.failed is False
