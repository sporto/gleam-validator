import gleeunit/should
import non_empty_list
import valid

pub fn int_min_test() {
  let validator = valid.int_min(5, ">=5")

  validator(5)
  |> should.equal(Ok(5))

  let expected_error = Error(non_empty_list.new(">=5", []))

  validator(4)
  |> should.equal(expected_error)
}

pub fn int_max_test() {
  let validator = valid.int_max(5, "<=5")

  validator(5)
  |> should.equal(Ok(5))

  let expected_error = Error(non_empty_list.new("<=5", []))

  validator(6)
  |> should.equal(expected_error)
}
