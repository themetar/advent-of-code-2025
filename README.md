# Advent of Code 2025

## Inputs

Puzzle inputs aren't shared as per the Advent of Code FAQ.

The tests expect puzzle inputs to reside in files in the `inputs` directory. And to follow the naming scheme `{day}{_optional_puzzle_part}{_optional_tag}.txt`.
`day` is leading-zero two-digit number, `optional_puzzle_part` is 1 or 2, and the tag can be any text.
E.g.: `01_1_example.txt` for the short example input of the first puzzle of the first day, and `01.txt` for the *main* puzzle input.

## Answers

Similarly answers should reside in the `answers` directory, and follow the same naming scheme. 

## Tests

Tests are generated on the fly and match input files with answer files. Pass the targeted puzzle as an argument in the command line `{day}_{puzzle_part}`. For example: `ruby tests/test.rb 01_2`

### Additional tests

Day 8 part 1 has a custom test, since it requires an extra parameter. Run it with `ruby tests/test_08_1.rb`

## Run the programs

You can run the solution file itself like a script with input redirect `ruby days/XX_Y.rb <inputfile` or pipe `cat inputfile | ruby days/XX_Y.rb`
