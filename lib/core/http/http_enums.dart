enum HTTPMethod { get, post, put, delete }

enum HTTPStatus {
  // Informational
  continue_(code: 100),
  switchingProtocols(code: 101),

  // Success
  ok(code: 200),
  created(code: 201),
  accepted(code: 202),
  nonAuthoritativeInformation(code: 203),
  noContent(code: 204),
  resetContent(code: 205),
  partialContent(code: 206),

  // Redirection
  multipleChoices(code: 300),
  movedPermanently(code: 301),
  found(code: 302),
  seeOther(code: 303),
  notModified(code: 304),
  useProxy(code: 305),
  temporaryRedirect(code: 307),
  permanentRedirect(code: 308),

  // Client Error
  badRequest(code: 400),
  unauthorized(code: 401),
  paymentRequired(code: 402),
  forbidden(code: 403),
  notFound(code: 404),
  methodNotAllowed(code: 405),
  notAcceptable(code: 406),
  proxyAuthenticationRequired(code: 407),
  requestTimeout(code: 408),
  conflict(code: 409),
  gone(code: 410),
  lengthRequired(code: 411),
  preconditionFailed(code: 412),
  payloadTooLarge(code: 413),
  uriTooLong(code: 414),
  unsupportedMediaType(code: 415),
  rangeNotSatisfiable(code: 416),
  expectationFailed(code: 417),
  imaTeapot(code: 418), // the best http status
  upgradeRequired(code: 426),
  preconditionRequired(code: 428),
  tooManyRequests(code: 429),
  requestHeaderFieldsTooLarge(code: 431),

  // Server Error
  internalServerError(code: 500),
  notImplemented(code: 501),
  badGateway(code: 502),
  serviceUnavailable(code: 503),
  gatewayTimeout(code: 504),
  httpVersionNotSupported(code: 505),
  variantAlsoNegotiates(code: 506),
  insufficientStorage(code: 507),
  loopDetected(code: 508),
  notExtended(code: 510),
  networkAuthenticationRequired(code: 511),

  /// Arbitrary Error
  ///
  /// Used when error is not related with http
  arbitraryError(code: 999),

  /// Initial
  /// 
  /// Used to denote initial state of the HTTPResponseModel
  initial(code: 998);

  const HTTPStatus({required this.code});
  final int code;

  bool equals(int statusCode) {
    return code == statusCode;
  }

  /// Convert integer into corresponding `HTTPStatus`
  /// ### Default
  /// If `code` is not part of the enum, will return `HTTPStatus.arbitraryError` instead
  static HTTPStatus from(int code) {
    return HTTPStatus.values.firstWhere(
      (status) => status.code == code,
      orElse: () => HTTPStatus.initial,
    );
  }
}
