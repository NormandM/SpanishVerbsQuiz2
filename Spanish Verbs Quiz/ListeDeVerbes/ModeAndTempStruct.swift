//
//  ModeAndTempStruct.swift
//  VerbAppRefactored
//
//  Created by Normand Martin on 2019-02-04.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct ModeAndTemp {
    let mode: [String] = ["INDICATIVO", "SUBJUNTIVO", "CONDICIONAL", "IMPERATIVO"]
    let temp: [[String]] = [["Presente", "Imperfecto", "Pretérito", "Futuro", "Presente continuo", "Pretérito perfecto", "Pluscuamperfecto", "Futuro perfecto", "Pretérito anterior"], ["Presente", "Imperfecto", "Futuro", "Pretérito perfecto", "Pluscuamperfecto"], ["Condicional", "Perfecto"], ["Positivo", "Negativo"]]
}
struct ModeEtTempContextuel {
    let mode: [String] = ["INDICATIVO", "SUBJUNTIVO", "CONDICIONAL", "IMPERATIVO"]
    let temp: [[String]] = [["Presente", "Imperfecto", "Pretérito", "Futuro", "Presente continuo", "Pretérito perfecto", "Pluscuamperfecto", "Futuro perfecto"], ["Presente", "Imperfecto"], ["Condicional", "Perfecto"], ["Positivo", "Negativo"]]
}


