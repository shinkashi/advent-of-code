// day7

use regex::Regex;

fn main() {
    let s = "light salmon bags contain 5 dark brown bags, 2 dotted coral bags, 5 mirrored turquoise bags.";

    let re = Regex::new(r"^(?P<leftbag>.+) bags contain (?P<rightbags>.+).$").unwrap();

    let caps = re.captures(s).unwrap();
    let left_bag = &caps["leftbag"];
    let mut right_bags: Vec<String> = caps["rightbags"]
        .split(',')
        .map(|x| x.replace("bags", ""))
        .collect();
    right_bags = right_bags.map(|x| std::string::trim(&x));

    println!("left_bag {}", left_bag);
    println!("right_bags {:?}", right_bags);
}
