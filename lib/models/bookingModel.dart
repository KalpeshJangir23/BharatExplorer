// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Bookingmodel {
  final String? price; //booking screen
  final String? currentLocation; // ! Location screen update
  final String? currentArea;
  final String? distination;

  final DateTime? startDate; //! date time Selector
  final DateTime? endDate;
  final String? StartTime;

  final String? numberOfAdult; //! no of traveller
  final String? numberOfChild;

  final String? seatSelected; //! seat selection
  final String? totalPrice;
  Bookingmodel({
    this.price,
    this.currentLocation,
    this.currentArea,
    this.distination,
    this.startDate,
    this.endDate,
    this.StartTime,
    this.numberOfAdult,
    this.numberOfChild,
    this.seatSelected,
    this.totalPrice,
  });

  Bookingmodel copyWith({
    String? price,
    String? currentLocation,
    String? currentArea,
    String? distination,
    DateTime? startDate,
    DateTime? endDate,
    String? StartTime,
    String? numberOfAdult,
    String? numberOfChild,
    String? seatSelected,
    String? totalPrice,
  }) {
    return Bookingmodel(
      price: price ?? this.price,
      currentLocation: currentLocation ?? this.currentLocation,
      currentArea: currentArea ?? this.currentArea,
      distination: distination ?? this.distination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      StartTime: StartTime ?? this.StartTime,
      numberOfAdult: numberOfAdult ?? this.numberOfAdult,
      numberOfChild: numberOfChild ?? this.numberOfChild,
      seatSelected: seatSelected ?? this.seatSelected,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'currentLocation': currentLocation,
      'currentArea': currentArea,
      'distination': distination,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'StartTime': StartTime,
      'numberOfAdult': numberOfAdult,
      'numberOfChild': numberOfChild,
      'seatSelected': seatSelected,
      'totalPrice': totalPrice,
    };
  }

  factory Bookingmodel.fromMap(Map<String, dynamic> map) {
    return Bookingmodel(
      price: map['price'] != null ? map['price'] as String : null,
      currentLocation: map['currentLocation'] != null ? map['currentLocation'] as String : null,
      currentArea: map['currentArea'] != null ? map['currentArea'] as String : null,
      distination: map['distination'] != null ? map['distination'] as String : null,
      startDate: map['startDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int) : null,
      endDate: map['endDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int) : null,
      StartTime: map['StartTime'] != null ? map['StartTime'] as String : null,
      numberOfAdult: map['numberOfAdult'] != null ? map['numberOfAdult'] as String : null,
      numberOfChild: map['numberOfChild'] != null ? map['numberOfChild'] as String : null,
      seatSelected: map['seatSelected'] != null ? map['seatSelected'] as String : null,
      totalPrice: map['totalPrice'] != null ? map['totalPrice'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bookingmodel.fromJson(String source) => Bookingmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Bookingmodel(price: $price, currentLocation: $currentLocation, currentArea: $currentArea, distination: $distination, startDate: $startDate, endDate: $endDate, StartTime: $StartTime, numberOfAdult: $numberOfAdult, numberOfChild: $numberOfChild, seatSelected: $seatSelected, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(covariant Bookingmodel other) {
    if (identical(this, other)) return true;
  
    return 
      other.price == price &&
      other.currentLocation == currentLocation &&
      other.currentArea == currentArea &&
      other.distination == distination &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.StartTime == StartTime &&
      other.numberOfAdult == numberOfAdult &&
      other.numberOfChild == numberOfChild &&
      other.seatSelected == seatSelected &&
      other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return price.hashCode ^
      currentLocation.hashCode ^
      currentArea.hashCode ^
      distination.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      StartTime.hashCode ^
      numberOfAdult.hashCode ^
      numberOfChild.hashCode ^
      seatSelected.hashCode ^
      totalPrice.hashCode;
  }
}
