
// class RefreshAccessToken {
//   RefreshAccessToken._();

//   static final NetworkCaller _networkCaller = NetworkCaller();

//   static Future<String?> refreshAccessToken() async {
//     final refreshToken = StorageService.getRefreshToken();
//     if (refreshToken == null || refreshToken.isEmpty) {
//       const message = "Session expired. Please login again.";
//       CommonMessage.showMessage(title: "Error", message: message);
//       AppLoggerHelper.warning(message);
//       return null;
//     }

//     final response = await _networkCaller.postRequest(
//       ApiConstants.refreshTokenApi,
//       body: {"refreshToken": refreshToken},
//     );

//     if (!response.isSuccess) {
//       final errorMessage = _extractErrorMessage(
//         response.responseData,
//         fallback: response.errorMessage.isNotEmpty
//             ? response.errorMessage
//             : "Unable to refresh session. Please login again.",
//       );
//       CommonMessage.showMessage(title: "Error", message: errorMessage);
//       AppLoggerHelper.warning(errorMessage);
//       return null;
//     }

//     final authPayload = _extractAuthPayload(response.responseData);
//     final accessToken = authPayload["accessToken"]?.toString() ??
//         authPayload["token"]?.toString() ??
//         "";
//     final newRefreshToken = authPayload["refreshToken"]?.toString() ?? "";

//     if (accessToken.isEmpty) {
//       const message = "Unable to refresh session. Please login again.";
//       CommonMessage.showMessage(title: "Error", message: message);
//       AppLoggerHelper.warning(message);
//       return null;
//     }

//     await StorageService.setUserToken(accessToken);
//     if (newRefreshToken.isNotEmpty) {
//       await StorageService.setRefreshToken(newRefreshToken);
//     }

//     return accessToken;
//   }

//   static String _extractErrorMessage(
//     dynamic responseData, {
//     required String fallback,
//   }) {
//     if (responseData is Map<String, dynamic>) {
//       final message = responseData["message"];
//       if (message is String && message.trim().isNotEmpty) {
//         return message;
//       }
//       if (message is List) {
//         final joined = message
//             .where((item) => item != null)
//             .map((item) => item.toString().trim())
//             .where((item) => item.isNotEmpty)
//             .join(", ");
//         if (joined.isNotEmpty) {
//           return joined;
//         }
//       }
//     }
//     return fallback;
//   }

//   static Map<String, dynamic> _extractAuthPayload(dynamic responseData) {
//     if (responseData is Map<String, dynamic>) {
//       final dataLevel = responseData["data"];
//       if (dataLevel is Map<String, dynamic>) {
//         final innerData = dataLevel["data"];
//         if (innerData is Map<String, dynamic>) {
//           return innerData;
//         }
//         return dataLevel;
//       }
//     }
//     return <String, dynamic>{};
//   }
// }
