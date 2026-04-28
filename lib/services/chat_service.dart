// // // chat_service.dart

// // import 'dart:convert';

// // import 'package:http/http.dart' as http;
// // import 'package:medical_delivery_app/models/chat_model.dart';

// // import 'package:socket_io_client/socket_io_client.dart' as IO;

// // class ChatService {

// //   static const String baseUrl = 'https://api.simcurarx.com';

// //   late IO.Socket socket;

// //   // Singleton pattern

// //   static final ChatService instance = ChatService.internal();

// //   factory ChatService() => _instance;

// //   ChatService._internal();

// //   // Initialize socket connection

// //   void initSocket() {

// //     try {

// //       socket = IO.io(baseUrl, <String, dynamic>{

// //         'transports': ['websocket'],

// //         'autoConnect': false,

// //       });

// //       socket.connect();

// //       socket.onConnect((_) {

// //         print('🟢 Socket connected: ${socket.id}');

// //       });

// //       socket.onDisconnect((_) {

// //         print('🔴 Socket disconnected');

// //       });

// //       socket.onError((error) {

// //         print('❌ Socket error: $error');

// //       });

// //     } catch (e) {

// //       print('❌ Socket initialization error: $e');

// //     }

// //   }

// //   // Send message via API

// //   Future<bool> sendMessage({

// //     required String userId,

// //     required String riderId,

// //     required String message,

// //     required String senderType,

// //   }) async {

// //     try {

// //       final url = Uri.parse('$baseUrl/api/users/sendMessage/$userId/$riderId');

// //       final response = await http.post(

// //         url,

// //         headers: {

// //           'Content-Type': 'application/json',

// //         },

// //         body: jsonEncode({

// //           'message': message,

// //           'senderType': senderType,

// //         }),

// //       );

// //       if (response.statusCode == 200) {

// //         // Also emit via socket for real-time update

// //         socket.emit('sendMessage', {

// //           'riderId': riderId,

// //           'userId': userId,

// //           'message': message,

// //           'senderType': senderType,

// //         });

// //         return true;

// //       } else {

// //         print('❌ Failed to send message: ${response.statusCode}');

// //         return false;

// //       }

// //     } catch (e) {

// //       print('❌ Error sending message: $e');

// //       return false;

// //     }

// //   }

// //   // Get chat history

// //   Future<List<ChatMessage>> getChatHistory({

// //     required String userId,

// //     required String riderId,

// //   }) async {

// //     try {

// //       final url = Uri.parse('$baseUrl/api/users/getChatHistory/$userId/$riderId');

// //       final response = await http.get(url);

// //       if (response.statusCode == 200) {

// //         final data = jsonDecode(response.body);

// //         if (data['success'] == true) {

// //           final List<dynamic> messagesJson = data['messages'];

// //           return messagesJson.map((json) => ChatMessage.fromJson(json)).toList();

// //         }

// //       }

// //       return [];

// //     } catch (e) {

// //       print('❌ Error fetching chat history: $e');

// //       return [];

// //     }

// //   }

// //   // Join chat room

// //   void joinRoom(String userId, String riderId) {

// //     final roomId = '${riderId}_$userId';

// //     socket.emit('join', roomId);

// //     print('📱 Joined room: $roomId');

// //   }

// //   // Leave chat room

// //   void leaveRoom(String userId, String riderId) {

// //     final roomId = '${riderId}_$userId';

// //     socket.emit('leave', roomId);

// //     print('📱 Left room: $roomId');

// //   }

// //   // Listen for incoming messages

// //   void onMessageReceived(Function(ChatMessage) callback) {

// //     socket.on('receiveMessage', (data) {

// //       try {

// //         final message = ChatMessage.fromJson(data);

// //         callback(message);

// //       } catch (e) {

// //         print('❌ Error parsing received message: $e');

// //       }

// //     });

// //   }

// //   // Disconnect socket

// //   void disconnect() {

// //     socket.disconnect();

// //     socket.dispose();

// //   }
// // }

// // chat_service.dart

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/models/chat_model.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class ChatService {
//   static const String baseUrl = 'https://api.simcurarx.com';
//   late IO.Socket socket;

//   // Singleton pattern - Fixed
//   static final ChatService _instance = ChatService._internal();
//   static ChatService get instance => _instance;
//   factory ChatService() => _instance;
//   ChatService._internal();

//   // Initialize socket connection
//   void initSocket() {
//     try {
//       socket = IO.io(baseUrl, <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': false,
//       });

//       socket.connect();

//       socket.onConnect((_) {
//         print('🟢 Socket connected: ${socket.id}');
//       });

//       socket.onDisconnect((_) {
//         print('🔴 Socket disconnected');
//       });

//       socket.onError((error) {
//         print('❌ Socket error: $error');
//       });
//     } catch (e) {
//       print('❌ Socket initialization error: $e');
//     }
//   }

//   // Send message via API
//   Future<bool> sendMessage({
//     required String userId,
//     required String riderId,
//     required String message,
//     required String senderType,
//   }) async {
//     try {

//       print('userdddddddddddddddddddddddddddddddddddddddddddd $userId');
//             print('riderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr $riderId');

//       final url = Uri.parse('$baseUrl/api/users/sendMessage/$userId/$riderId');
//             print('urlllllllllllllllllllllllllllllllllllllll $url');

//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'message': message,
//           'senderType': senderType,
//         }),
//       );

//       print('response status codeeeeeeeeeeeeeeeeeeeeeeeee${response.statusCode}');
//             print('response bodyyyyyyyyyyyyyyyyyyyyyyyyyy${response.body}');

//       if (response.statusCode == 201) {
//         // Also emit via socket for real-time update
//         socket.emit('sendMessage', {
//           'riderId': riderId,
//           'userId': userId,
//           'message': message,
//           'senderType': senderType,
//         });
//         return true;
//       } else {
//         print('❌ Failed to send message: ${response.statusCode}');
//         return false;
//       }
//     } catch (e) {
//       print('❌ Error sending message: $e');
//       return false;
//     }
//   }

//   // Get chat history
//   Future<List<ChatMessage>> getChatHistory({
//     required String userId,
//     required String riderId,
//   }) async {
//     try {
//       final url = Uri.parse('$baseUrl/api/users/getChatHistory/$userId/$riderId');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['success'] == true) {
//           final List<dynamic> messagesJson = data['messages'];
//           return messagesJson.map((json) => ChatMessage.fromJson(json)).toList();
//         }
//       }
//       return [];
//     } catch (e) {
//       print('❌ Error fetching chat history: $e');
//       return [];
//     }
//   }

//   // Join chat room
//   void joinRoom(String userId, String riderId) {
//     final roomId = '${riderId}_$userId';
//     socket.emit('join', roomId);
//     print('📱 Joined room: $roomId');
//   }

//   // Leave chat room
//   void leaveRoom(String userId, String riderId) {
//     final roomId = '${riderId}_$userId';
//     socket.emit('leave', roomId);
//     print('📱 Left room: $roomId');
//   }

//   // Listen for incoming messages
//   void onMessageReceived(Function(ChatMessage) callback) {
//     socket.on('receiveMessage', (data) {
//       try {
//         final message = ChatMessage.fromJson(data);
//         callback(message);
//       } catch (e) {
//         print('❌ Error parsing received message: $e');
//       }
//     });
//   }

//   // Disconnect socket
//   void disconnect() {
//     socket.disconnect();
//     socket.dispose();
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/models/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  static const String baseUrl = 'https://api.simcurarx.com';
  IO.Socket? socket;
  bool _isConnected = false;

  // Singleton pattern
  static final ChatService _instance = ChatService._internal();
  static ChatService get instance => _instance;
  factory ChatService() => _instance;
  ChatService._internal();

  bool get isConnected => _isConnected && socket != null && socket!.connected;

  // Initialize socket
  Future<void> initSocket() async {
    try {
      if (socket != null) {
        socket!.disconnect();
        socket!.dispose();
      }

      socket = IO.io(baseUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'timeout': 20000,
        'reconnection': true,
        'reconnectionDelay': 1000,
        'reconnectionAttempts': 5,
      });

      socket!.onConnect((_) {
        print('🟢 Socket connected: ${socket!.id}');
        _isConnected = true;
      });

      socket!.onDisconnect((_) {
        print('🔴 Socket disconnected');
        _isConnected = false;
      });

      socket!.onError((error) {
        print('❌ Socket error: $error');
        _isConnected = false;
      });

      socket!.onReconnect((_) {
        print('🔄 Socket reconnected');
        _isConnected = true;
      });

      await Future.delayed(Duration(milliseconds: 2000));

      if (!isConnected) {
        print('⚠ Socket connection timeout - retrying...');
        socket!.connect();
      }
    } catch (e) {
      print('❌ Socket initialization error: $e');
      _isConnected = false;
    }
  }

  // Send message via API + socket
  Future<bool> sendMessage({
    required String userId,
    required String riderId,
    required String message,
    required String senderType,
  }) async {
    try {
      if (isConnected) {
        if (isConnected) {
          socket!.emit('sendMessage', {
            'riderId': riderId,
            'userId': userId,
            'message': message,
            'senderType': senderType,
            'timestamp': DateTime.now().toIso8601String(),
          });
          print('📤 Message emitted via socket');
        } else {
          print('⚠ Socket not connected, message sent via API only');
        }
        return true;
      } else {
        print('Sending message - User: $userId, Rider: $riderId');

        final url =
            Uri.parse('$baseUrl/api/users/sendMessage/$userId/$riderId');
        print('API URL: $url');

        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'message': message,
            'senderType': senderType,
          }),
        );

        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          return true;
        } else {
          print('❌ Failed to send message: ${response.statusCode}');
          return false;
        }
      }
    } catch (e) {
      print('❌ Error sending message: $e');
      return false;
    }
  }

  // Get chat history
  Future<List<ChatMessage>> getChatHistory({
    required String userId,
    required String riderId,
  }) async {
    try {
      final url =
          Uri.parse('$baseUrl/api/users/getChatHistory/$userId/$riderId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> messagesJson = data['messages'];
          return messagesJson
              .map((json) => ChatMessage.fromJson(json))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('❌ Error fetching chat history: $e');
      return [];
    }
  }

  // Join chat room
  void joinRoom(String userId, String riderId) {
    if (isConnected) {
      socket!.emit('joinRoom', {
        'userId': userId,
        'riderId': riderId,
      });
      print('📱 Joined room: ${userId}_$riderId');
    } else {
      print('⚠ Cannot join room - socket not connected');
      Future.delayed(Duration(seconds: 2), () {
        if (isConnected) {
          joinRoom(userId, riderId);
        }
      });
    }
  }

  // Leave chat room
  void leaveRoom(String userId, String riderId) {
    if (isConnected) {
      socket!.emit('leaveRoom', {
        'userId': userId,
        'riderId': riderId,
      });
      print('📱 Left room: ${userId}_$riderId');
    }
  }

  // Listen for messages
  void onMessageReceived(Function(ChatMessage) callback) {
    if (socket == null) {
      print('❌ Socket not initialized');
      return;
    }

    socket!.on('receiveMessage', (data) {
      try {
        print('📥 Message received via socket: $data');
        final message = ChatMessage.fromJson(data);
        callback(message);
      } catch (e) {
        print('❌ Error parsing received message: $e');
      }
    });
  }

  void removeAllListeners() {
    if (socket != null) {
      socket!.clearListeners();
      print('🧹 All socket listeners removed');
    }
  }

  Future<void> reconnect() async {
    print('🔄 Attempting to reconnect socket...');
    await initSocket();
  }

  void disconnect() {
    if (socket != null) {
      socket!.disconnect();
      socket!.dispose();
      socket = null;
      _isConnected = false;
      print('🔌 Socket disconnected and disposed');
    }
  }
}
