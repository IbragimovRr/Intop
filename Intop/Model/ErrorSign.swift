//
//  ErrorSign.swift
//  Intop
//
//  Created by Руслан on 06.06.2024.
//

import Foundation

enum ErrorSignIn: String, Swift.Error {
    case invalidLoginOrPassword = "Неправильный логин или пароль"
    case notFound = "Ошибка данных"
    case tryAgainLater = "Ошибка повторите попытку позже"
}

enum ErrorSignUp: String, Swift.Error {
    case invalidPhoneNumber = "Неверный формат номера телефона"
    case invalidPassword = "Пароль должен содержать не менее 8 символов и включать как минимум 1 цифру, 1 прописную и 1 строчную "
    case namberRegister = "Номер уже был зарегистрирован"
    case tryAgainLater = "Ошибка повторите попытку позже"
}
