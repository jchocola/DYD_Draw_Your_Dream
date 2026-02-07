import 'package:dyd_drawer/core/exception/app_exception.dart';
import 'package:flutter/material.dart';

String appExceptionConvert(
  BuildContext context, {
  required AppException exception,
}) {
  switch (exception) {
    ///
    /// PAINTING
    ///
    case AppException.failedToSaveImageToGallery:
      return 'Не удалось сохранить изображение в галерею.';
    case AppException.saveImageToGallerySuccessfully:
      return 'Изображение успешно сохранено в галерее.';

    ///
    /// AUTH
    ///
    case AppException.failedToCreateNewUser:
      return 'Не удалось создать нового пользователя.';
    case AppException.emailAlreadyInUse:
      return 'Этот электронный адрес уже используется.';
    case AppException.invalidEmail:
      return 'Неверный формат электронной почты.';
    case AppException.operationNotAllowed:
      return 'Операция не разрешена.';
    case AppException.weakPassword:
      return 'Пароль слишком простой.';
    case AppException.tooManyRequests:
      return 'Слишком много попыток. Попробуйте позже.';
    case AppException.userTokenExpired:
      return 'Срок действия токена пользователя истёк.';
    case AppException.networkRequestFailed:
      return 'Ошибка сети. Проверьте подключение к интернету.';

    case AppException.failedToSignIn:
      return 'Не удалось войти в аккаунт.';
    case AppException.userDisabled:
      return 'Учетная запись отключена.';
    case AppException.userNotFound:
      return 'Пользователь не найден.';
    case AppException.wrongPassword:
      return 'Неверный пароль.';
    case AppException.invalidCredential:
      return 'Неверные учетные данные.';

    case AppException.failedToUpdateUserName:
      return 'Не удалось обновить имя пользователя.';
    case AppException.passwordsDoNotMatch:
      return 'Пароли не совпадают.';

    case AppException.userNotAuthenticated:
      return 'Пользователь не аутентифицирован.';
  }
}
