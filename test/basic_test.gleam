import gleam/option.{type Option, None, Some}
import gleeunit/should
import non_empty_list
import valid.{type ValidatorResult}

type InputUser {
  InputUser(name: Option(String), email: Option(String), age: Int)
}

type ValidUser {
  ValidUser(name: String, email: String, age: Int)
}

fn user_validator(user: InputUser) -> ValidatorResult(ValidUser, String) {
  valid.build3(ValidUser)
  |> valid.check(user.name, valid.is_some("Please provide a name"))
  |> valid.check(user.email, valid.is_some("Please provide an email"))
  |> valid.check(user.age, valid.ok())
}

pub fn valid_test() {
  let valid_input =
    InputUser(name: Some("Sam"), email: Some("sam@sample.com"), age: 11)

  let valid = ValidUser(name: "Sam", email: "sam@sample.com", age: 11)

  user_validator(valid_input)
  |> should.equal(Ok(valid))
}

pub fn invalid_test() {
  let invalid = InputUser(name: None, email: None, age: 0)

  let expected_error =
    Error(
      non_empty_list.new("Please provide a name", ["Please provide an email"]),
    )

  user_validator(invalid)
  |> should.equal(expected_error)
}
