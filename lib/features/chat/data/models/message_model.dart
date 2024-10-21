class MessageModel{
  final String message;
  final int id;

  MessageModel(this.message, this.id);

  factory MessageModel.fromJson(json){
    return MessageModel(json['message'],(json['id']));
  }
}