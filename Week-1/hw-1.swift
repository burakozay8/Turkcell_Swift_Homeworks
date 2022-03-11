#!/usr/bin/env swift
import Foundation

let names = ["Mert", "Eren", "Yusuf", "Zeynep", "Ali"]
let reversedSortNames = names.sorted { $0 > $1 }
let uppercasedNames = reversedSortNames.map {$0.uppercased()}

for name in uppercasedNames {
print(name)
}
