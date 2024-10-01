

class CustomerLocations {
  int locationId;
  String locationName;


  CustomerLocations({
    required this.locationId,
    required this.locationName,
 

  });
  factory CustomerLocations.fromJson(Map<String, dynamic> json) {
    return CustomerLocations(
        locationId: json['Location_Id'],
        locationName: json['Location_Name'],

       
        
        
        
        
        
        
        
        );
  }
}
