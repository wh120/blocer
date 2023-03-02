import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/errors/base_error_widget.dart';
import 'blocer_cubit.dart';

typedef ModelBuilder<Model> = Widget Function(Model model);
typedef ModelReceived<Model> = Function(Model model);

class Blocer<B extends StateStreamable<BlocerState> , ResponseModel> extends StatefulWidget {
  final  bloc;
   ModelBuilder<ResponseModel>? builder;
   VoidCallback? getData;
   Widget? child ;
    ModelReceived<ResponseModel>? onSuccess;

   Blocer.get({Key? key, this.bloc, required this.builder,required  this.getData , this.onSuccess}) : super(key: key);
   Blocer.post({Key? key, this.bloc , required this.child , this.onSuccess  }) : super(key: key);

  @override
  State<Blocer< B ,ResponseModel>> createState() => _BlocerState<B, ResponseModel>();
}

class _BlocerState<B extends StateStreamable<BlocerState> , ResponseModel> extends State<Blocer<B ,ResponseModel>> {

 @override
  void initState() {
   // if(widget.getData != null)
   //   widget.getData!();
  }
  @override
  Widget build(BuildContext context) {
   if(widget.getData != null)
      return buildGetBlocer();
   else return buildPostBlocer();
  }

  BlocConsumer<dynamic, BlocerState> buildGetBlocer() {
    return BlocConsumer<B,BlocerState>(
      bloc: widget.bloc,
        builder: (c,state){
        if(state is BlocerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        else if(state is BlocerLoaded) {
          return RefreshIndicator(
              child: widget.builder!(state.data),
              onRefresh: ()async {
                if(widget.getData != null)
                  widget.getData!();
              },
          );
         }
        else if(state is BlocerError){
          return BaseErrorWidget(
            icon: Icon(Icons.error_outline_sharp ,size: 50,color: Colors.red,),
            onTap: (){
              if(widget.getData != null)
                widget.getData!();
            },
            title: state.error.toString(),
          );
        }
        else if(state is BlocerInitial){
          widget.getData!();
          return const Center(child: CircularProgressIndicator());
        }
        else {

          return const Center(child: CircularProgressIndicator());
        }
        },

        listener: (c,state){

          if(state is BlocerLoaded){
            if(widget.onSuccess != null){
              widget.onSuccess!(state.data);
            }

          }
        }
    );
  }

 BlocConsumer<dynamic, BlocerState> buildPostBlocer() {
   return BlocConsumer<B,BlocerState>(
       bloc: widget.bloc,
       builder: (c,state){
         if(state is BlocerLoading  ) {
           return const Center(child: CircularProgressIndicator());
           // return Shimmer.fromColors(
           //     baseColor: Colors.blue,
           //     highlightColor: Colors.grey,
           //     child: widget.child!);
         }

         else {
           return widget.child!;
         }
       },

       listener: (c,state){
         if(state is BlocerError){
           var snackBar = SnackBar(
             content: Text(state.error.toString()),
           );
           ScaffoldMessenger.of(context).showSnackBar(snackBar);

         }
         else if(state is BlocerLoaded){
           if(widget.onSuccess != null){
             widget.onSuccess!(state.data);
           }
         }
       },
   );
 }
}
