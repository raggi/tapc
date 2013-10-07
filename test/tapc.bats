load test_helper

@test "output contains input" {
	tapc 'foo\nbar\nbaz'
	assert_line 'foo'
	assert_line 'bar'
	assert_line 'baz'
}

@test "test plan is yellow" {
	tapc '1..1'
	assert_eline '\e[1;33m1..1\e[0m'
}

@test "ok line is green" {
	tapc '1..1\nok 1 success'
	assert_eline '\e[1;32mok 1 success\e[0m'
}

@test "not ok line is red" {
	tapc '1..1\nnot ok 1 fail'
	assert_eline '\e[1;31mnot ok 1 fail\e[0m'
}
