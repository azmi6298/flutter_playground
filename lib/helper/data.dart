import 'package:newsapp/models/category_model.dart';

List getCountries(){
  List countries = new List();
  countries.add('id');
  countries.add('us');

  return countries;
}

List<CategoryModel> getCategories(){
  List<CategoryModel> categories  = new List<CategoryModel>(); 

  CategoryModel categoryData = new CategoryModel();

  categoryData.categoryName = 'Business';
  categoryData.imageUrl = 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60';
  categories.add(categoryData);

  categoryData = new CategoryModel();
  categoryData.categoryName = 'Sports';
  categoryData.imageUrl = 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60';
  categories.add(categoryData);

  categoryData = new CategoryModel();
  categoryData.categoryName = 'Entertainment';
  categoryData.imageUrl = 'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80';
  categories.add(categoryData);

  categoryData = new CategoryModel();
  categoryData.categoryName = 'Business';
  categoryData.imageUrl = 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60';
  categories.add(categoryData);

  categoryData = new CategoryModel();
  categoryData.categoryName = 'Business';
  categoryData.imageUrl = 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60';
  categories.add(categoryData);

  return categories;
}