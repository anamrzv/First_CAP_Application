namespace sap.capire.products;

using { Currency, managed, sap.common.CodeList } from '@sap/cds/common';

entity Products : managed {
  key ID   : Integer;
  title    : localized String(111);
  descr    : localized String(1111);
  stock    : Integer;
  price    : Decimal(9,2);
  currency : Currency;
}

entity Categories : CodeList {
  key ID   : Integer;
  parent   : Association to Categories;
  children : Composition of many Categories on children.parent = $self;
}