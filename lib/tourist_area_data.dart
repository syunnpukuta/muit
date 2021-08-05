class TouristAreaData{

 late String rural;
 late String city;
 late String explanation;
 late List<String> genre;
 late List<String> dish;
 late List<String> canDo;
 late List<String> image;
 late double score;

 TouristAreaData(Map data){
   rural = data["rural"];
   city = data["city"];
   explanation = data["explanation"];
   score = data["score"];
   genre = data["genre"].toString().split(",");
   dish = data["dish"].toString().split(",");
   canDo = data["canDO"].toString().split(",");
   image = data["image"].toString().split(",");
 }

}