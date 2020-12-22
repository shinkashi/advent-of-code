fn main() {
    let v = vec![1, 2, 3];
    let res = backtrack(v);
    println!("{:?}", res);
}

fn backtrack(v: Vec<i16>) -> Vec<Vec<i16>> {
    let mut res = vec![];
    if v.len() == 1 {
        return vec![v];
    }

    for i in 0..(v.len()) {
        let mut vv = v.clone();
        vv.remove(i);
        // println!("i {:?}, vv {:?}", i, vv);
        let vvres = backtrack(vv);
        // println!("vvres {:?}", vvres);

        for j in vvres {
            let mut jj = j.clone();
            // println!("jj {:?}", jj);
            jj.insert(0, v[i]);
            res.push(jj)
        }

        // println!("res {:?}", res);
    }
    return res;
}
