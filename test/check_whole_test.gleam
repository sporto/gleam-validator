import gleeunit/should
import non_empty_list
import valid.{type ValidatorResult}

type Character {
  Character(level: Int, strength: Int)
}

fn whole_validator(c: Character) -> ValidatorResult(Character, String) {
  let error = "Strength cannot be less than level"

  case c.level > c.strength {
    True -> Error(non_empty_list.new(error, []))
    False -> Ok(c)
  }
}

fn character_validator(c: Character) -> ValidatorResult(Character, String) {
  valid.build2(Character)
  |> valid.check(c.level, valid.int_min(1, "Level must be more that zero"))
  |> valid.check(
    c.strength,
    valid.int_min(1, "Strength must be more that zero"),
  )
  |> valid.check_whole(whole_validator)
}

pub fn whole_test() {
  let char = Character(level: 1, strength: 1)

  character_validator(char)
  |> should.equal(Ok(char))

  let char2 = Character(level: 2, strength: 1)

  character_validator(char2)
  |> should.equal(
    Error(non_empty_list.new("Strength cannot be less than level", [])),
  )
}
