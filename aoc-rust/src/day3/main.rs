use std::fs;

fn main() {
    // Load map
    let input = fs::read_to_string("src/input.txt").expect("error");
    let mut field: Vec<Vec<char>> = vec![];
    for (y, ln) in input.lines().enumerate() {
        field[y] = Vec::new();
        for (x, c) in ln.char_indices() {
            print!("{} {} {}", y, x, c);
            field[y].push(c);
        }
        println!("");
    }

    // let lines: Vec<&str> = input.split_whitespace().collect();

    // println!("{:?}", input);
}
