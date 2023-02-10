// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'widgets.dart';

class NoData extends StatelessWidget {
  final Function()? event;
  final String? message;
  const NoData({
    Key? key,
    this.event,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: event,
          icon: const Icon(Icons.refresh),
        ),
        const SizedBox(height: 15),
        Text(message!, textAlign: TextAlign.center),
      ],
    );
  }
}
