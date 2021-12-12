import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/events/models/song_model.dart';
import 'package:myapp/events/networking/event_api.dart';

class EventRepository {
  Future<http.Response> createEvent(
    String name,
    String description,
    List<String> selectedPrefList,
    String eventStatus,
  ) async {
    final response =
        await CreateEvent(name, description, selectedPrefList, eventStatus)
            .createEvent();
    // print('response status code from -event repo-' +
    //     response.statusCode.toString());
    return response;
  }

  Future<http.Response> getEvents() async {
    // print('get event from repos was called');
    final response = await GetAllEvents().fetchAllEvents();
    // print('response from get event in repo ${jsonDecode(response.body)}');
    return response;
  }

  Future<http.Response> getMyEvents() async {
    final response = await GetMyEvents().fetchAllMyEvents();
    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      return response;
    } else {
      throw Exception('FALID LAODING DATA EVENTS');
    }
  }

  Future<http.Response> editEvent(
    String name,
    String desc,
    List<String> musicPreference,
    String visibility,
    String id,
  ) async {
    final response = await EditEvent()
        .editEvent(name, desc, musicPreference, visibility, id);
    return response;
  }

  Future<AlbumModel?> getOneEvent(String id) async {
    print('Striiiiiiiing $id');

    final response = await GetOneEvent().getOneEvant(id);
    print(response.statusCode);
    // final res = jsonDecode(response.body);
    print(
        "this is the res body success status from event repo ${response.statusCode}");
    if (response.statusCode == 200) {
      print(response.body.toString());
      return AlbumModel.fromJson(jsonDecode(response.body.toString()));
      // print('Striiiiiiiing ${event.name}');
      // return event;
    } else {
      // throw (Error);
      return null;
    }
  }

  Future<AlbumModel> getEvent(String id) async {
    print('Striiiiiiiing $id');

    final response = await GetOneEvent().getOneEvant(id);
    print(response.statusCode);
    final res = jsonDecode(response.body);
    print("this is the res body success status from event repo $res");
    if (response.statusCode == 200) {
      print(response.body.toString());
      return AlbumModel.fromJson((res));
      // print('Striiiiiiiing ${event.name}');
      // return event;
    } else {
      throw (Error);
    }
  }

  Future<void> startEvent(String eventId) async {
    try {
      final http.Response response = await StartEvent().start(eventId);
      print(
          'this is start buttton response from try event repository ${response.body}');
      if (response.statusCode == 200) {
        print('this is the  success body from event repository start event');
      } else {
        print(
            'response failure frome event repository start event ${response.statusCode}');
      }
    } catch (e) {
      print('some things catched in the event repository staet event $e');
    }
  }
}
