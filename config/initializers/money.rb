# coding: utf-8
require 'money'

curr_hk = {
  :priority        => 1,
  :iso_code        => "HKD",
  :iso_numeric     => "344",
  :name            => "Hong Kong Dollar",
  :symbol 		   => "HK$",
  :alternate_symbols => ["HK$"],
  :subunit         => "Cent",
  :subunit_to_unit => 1,
  :symbol_first   => true,
  :html_entity    => "$",
  :decimal_mark   =>  ".",
  :thousands_separator => ","
}

curr_cn = {
  :priority        => 1,
  :iso_code        => "CNY",
  :iso_numeric     => "156",
  :name            => "Chinese Renminbi Yuan",
  :symbol 		   => "¥",
  :alternate_symbols => ["CN¥", "元", "CN元"],
  :subunit         => "Fen",
  :subunit_to_unit => 1,
  :symbol_first   => true,
  :html_entity    => "&#20803;",
  :decimal_mark   =>  ".",
  :thousands_separator => ","
}

curr_us = {
  :priority        => 1,
  :iso_code        => "USD",
  :iso_numeric     => "840",
  :name            => "United States Dollar",
  :symbol 		   => "$",
  :alternate_symbols => ["US$"],
  :subunit         => "Cent",
  :subunit_to_unit => 1,
  :symbol_first   => true,
  :html_entity    => "$",
  :decimal_mark   =>  ".",
  :thousands_separator => ","
}

Money::Currency.register(curr_hk)
Money::Currency.register(curr_cn)
Money::Currency.register(curr_us)