import 'package:flutter/material.dart';
import 'package:milestone/src/helpers/vars.dart';
import 'package:milestone/src/models/video.dart';

getVideoCard(Video video, bool isActive) {
  return Card(
    elevation: 1.0,
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        isThreeLine: true,
        leading: Image.network(
          "$baseUrl/storage/${video.thumbnail}",
          width: 60.0,
        ),
        title: Container(
          margin: EdgeInsets.only(bottom: 5.0),
          child: Text(
            video.title,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 16.0,
              fontFamily: "TitilliumWeb-Regular",
            ),
          ),
        ),
        subtitle: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 170.0,
                child: Text(
                  video.description,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: "TitilliumWeb-Regular",
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: Container(
          child: Icon(
            isActive ? Icons.pause_circle_filled : Icons.play_circle_filled,
            size: 42.0,
            color: isActive ? Colors.green : Colors.grey,
          ),
        ),
      ),
    ),
  );
}
