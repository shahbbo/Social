import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/shared/cubit/states.dart';
import 'package:project/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;

  void changeIndex (int index)
  {
    currentIndex = index ;
    emit(AppChangeBottomNabBarState());
  }

  bool isBottomSheetShown = false ;
  IconData fabIcon = Icons.edit ;

  void changeBottomSheetState(
      {
  required bool isShow ,
  required IconData icon ,
       })
  {
  isBottomSheetShown = isShow;
  fabIcon = icon ;

  emit(AppChangeBottomSheetState()) ;
  }

  bool isDark = false ;
  void changeAppMode({bool? fromShared})
  {
   if(fromShared != null)
   {
      isDark = fromShared;
      emit(AppChangeModeState());
   }
   else {
      isDark = !isDark ;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {emit(AppChangeModeState()); });
    }
  }
}