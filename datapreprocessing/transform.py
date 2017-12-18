#!/usr/bin/env python3
#coding=utf8
#by Shanshan Wang
#transform rawdata(test.csv) to seed(seeds.rb) 
# run: ./transform > seeds.rb

import csv

print('#---')
print('# This file should contain all the record creation needed to seed the database with its default values.')
print('# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).')
print('#')
print('# Examples:')
print('#')
print('#   movies = Movie.create([{ name: \'Star Wars\' }, { name: \'Lord of the Rings\' }])')
print('#   Character.create(name: \'Luke\', movie: movies.first)')
print('#---')
print('# encoding: utf-8')
print('Movie.delete_all')

csv_reader = csv.DictReader(open('test.csv', encoding='utf-8'))
for row in csv_reader:
    print('Movie.create(')
    print('  title: \''+row['title']+'\',')
    print('  place: \''+row['place']+'\',')
    print('  description: '+'%{<p>'+row['summary']+'</p>}'+',')
    print('  detail_url: \''+row['url']+'\',')
    print('  image_url: \''+row['title']+'.jpg\'')
    print(')')
    print('# . . .')

