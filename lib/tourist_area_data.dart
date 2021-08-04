class TouristAreaData{

 late String rural;
 late String city;
 late String explanation;
 late List<String> genre;
 late List<String> dish;
 late List<String> canDo;
 late List<String> image;

 TouristAreaData(Map data){
   rural = data["rural"];
   city = data["city"];
   explanation = data["explanation"];
   genre = (data["genre"] as List).cast<String>();
   dish = (data["dish"] as List).cast<String>();
   canDo = (data["canDo"] as List).cast<String>();
   image = (data["image"] as List).cast<String>();
 }

}