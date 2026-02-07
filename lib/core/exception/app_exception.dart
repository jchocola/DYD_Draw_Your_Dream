enum AppException {
  // PAINTING
  failedToSaveImageToGallery,
  saveImageToGallerySuccessfully,
  settingBackgroundImage,

  // AUTH
  failedToCreateNewUser,
  emailAlreadyInUse,
  invalidEmail,
  operationNotAllowed,
  weakPassword,
  tooManyRequests,
  userTokenExpired,
  networkRequestFailed,

  failedToSignIn,
  userDisabled,
  userNotFound,
  wrongPassword,
  invalidCredential,

  failedToUpdateUserName,
  passwordsDoNotMatch,

  userNotAuthenticated,
}
