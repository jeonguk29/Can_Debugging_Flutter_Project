import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbti_storage/shared/bloc/cubit.dart';
import 'package:mbti_storage/shared/bloc/states.dart';
import 'package:mbti_storage/shared/components/components.dart';

class newTasks extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    appCubit cubit=appCubit.get(context);
    return BlocConsumer<appCubit,States>(
      builder: (context,State){
        return tasksList(tasks: cubit.NewTasks);
      },
      listener: (context,state){});
    throw UnimplementedError();
  }

}