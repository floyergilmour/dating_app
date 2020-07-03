library types;

enum Gender { male, female, unknown, missing }
enum UserType { groom, bride, bestMan, bridesMaid, guest, handler, missing,unknown}
enum Product { premium, free }



UserType stringToUserType([String userTypeInput]){
  if(userTypeInput == null){
    return UserType.missing;
  }
  else{
    switch(userTypeInput){
      case "groom": return UserType.groom;
      case "bride": return UserType.bride;
      case "bestMan": return UserType.bestMan;
      case "bridesMaid": return UserType.bridesMaid;
      case "guest": return UserType.guest;
      case "handler": return UserType.handler;
      case "missing": return UserType.missing;
      default: {
        return UserType.unknown;
      }
    }
  }
}