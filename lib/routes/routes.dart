import 'package:buscador_animales/ui/home_ui.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getAppicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (_) => const HomeUi(),
    // 'login': (_) => const LoginUi(),
    // 'detalleTicket': (_) => const DetalleTicketUi(),
  };
}
