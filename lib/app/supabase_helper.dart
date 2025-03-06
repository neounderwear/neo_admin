import 'package:dio/dio.dart';

class SupabaseHelper {
  final String url = 'https://wovklugpxmjwinfeaded.supabase.co';
  final String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvdmtsdWdweG1qd2luZmVhZGVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAyMDQ2MzIsImV4cCI6MjA1NTc4MDYzMn0.EvYq1oi4tnF4Ix19ZBV4RGaKVsl1lli8hXb1VXcVXFI';
  final Dio dio = Dio();

  SupabaseHelper() {
    dio.options.headers = {
      'apiKey': anonKey,
      'authorization': 'Bearer $anonKey',
      'Content-Type': 'application/json',
    };
  }
}
