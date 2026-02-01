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
    case AppException.FAILED_TO_SAVE_IMAGE_TO_GALLERY:
      return 'Не удалось сохранить изображение в галерею.';
    case AppException.SAVED_IMAGE_TO_GALLERY_SUCCESSFULLY:
      return 'Изображение успешно сохранено в галерее.';

    ///
    /// AUTH
    ///
    case AppException.FAILED_TO_CREATE_NEW_USER:
      return 'Не удалось создать нового пользователя.';
    case AppException.EMAIL_ALREADY_IN_USE:
      return 'Этот электронный адрес уже используется.';
    case AppException.INVALID_EMAIL:
      return 'Неверный формат электронной почты.';
    case AppException.OPERATION_NOT_ALLOWED:
      return 'Операция не разрешена.';
    case AppException.WEAK_PASSWORD:
      return 'Пароль слишком простой.';
    case AppException.TOO_MANY_REQUESTS:
      return 'Слишком много попыток. Попробуйте позже.';
    case AppException.USER_TOKEN_EXPIRED:
      return 'Срок действия токена пользователя истёк.';
    case AppException.NETWORK_REQUEST_FAILED:
      return 'Ошибка сети. Проверьте подключение к интернету.';

    case AppException.FAILED_TO_SIGN_IN:
      return 'Не удалось войти в аккаунт.';
    case AppException.USER_DISABLED:
      return 'Учетная запись отключена.';
    case AppException.USER_NOT_FOUND:
      return 'Пользователь не найден.';
    case AppException.WRONG_PASSWORD:
      return 'Неверный пароль.';
    case AppException.INVALID_CREDENTIAL:
      return 'Неверные учетные данные.';

    case AppException.FAILED_TO_UPDATE_USER_NAME:
      return 'Не удалось обновить имя пользователя.';
    case AppException.PASSWORDS_DO_NOT_MATCH:
      return 'Пароли не совпадают.';

    case AppException.USER_NOT_AUTHENTICATED:
      return 'Пользователь не аутентифицирован.';

    default:
      return 'Неизвестная ошибка.';
  }
}
