namespace sap.capire.bookshop; //helpful for reuse
using { Currency, managed, cuid } from '@sap/cds/common';
using { sap.capire.products.Products } from '../../products/db/schema';

entity Books : Products, additionalInfo {
  author   : Association to Authors;
}

@cds.persistence.exists
entity Magazines {
  key ID   : Integer;
  title : String(111);
  descr : String(1111);
  publisher : String(50);
  rating : Integer;
}

@cds.persistence.exists
entity MagazinesInfo (REQ_RATING : Integer) {
  key id   : Integer;
  rating : Integer;
  magazine_publisher_info : String;
}

@cds.autoexpose
entity Authors : managed {
  key ID   : Integer;
  name     : String(111);
  dateOfBirth : Date;
  dateOfDeath : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books    : Association to many Books on books.author = $self;
}

entity Orders : managed, cuid {
  OrderNo  : String @title:'Order Number'; //> readable key
  Items    : Composition of many OrderItems on Items.parent = $self;
  total    : Decimal(9,2) @readonly;
  currency : Currency;
}

entity OrderItems : cuid {
  parent   : Association to Orders;
  book     : Association to Books;
  amount   : Integer;
  netAmount: Decimal(9,2);
}

entity Movies : additionalInfo {
    key ID :Integer;
    name:String(100);
}

aspect additionalInfo {
    genre: String(100);
    language: String(200);
}