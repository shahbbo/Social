import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/shared/components/components.dart';

class SocialSearch extends StatelessWidget {
  var searchController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context , state) {},
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value)
                  {
                  },
                  validate: (String?value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'search must not be empty';
                    }
                    return null ;
                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
