import 'package:flutter/material.dart';

class ProfileField extends StatefulWidget {
  final String label;
  final String? value;
  final void Function(String)? onEdit;

  const ProfileField({
    super.key,
    required this.label,
    this.value,
    this.onEdit,
  });

  @override
  _ProfileFieldState createState() => _ProfileFieldState();
}

class _ProfileFieldState extends State<ProfileField> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          "${widget.label} : ${_isEditing ? '' :  ''}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              if (_isEditing) {
                _isEditing = false;
                widget.onEdit?.call(_controller.text);
              } else {
                _isEditing = true;
              }
            });
          },
          icon: Icon(_isEditing ? Icons.check : Icons.edit),
        ),
        subtitle: _isEditing
            ? TextFormField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Enter new value',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.value ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                      height: 4),
                ],
              ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
