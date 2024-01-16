import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:postgrest/postgrest.dart';
// final client = Supabase.instance.client;
final supabase = SupabaseClient('https://tptkwiinpwpuktukxeik.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRwdGt3aWlucHdwdWt0dWt4ZWlrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5MDExNDMsImV4cCI6MjAxODQ3NzE0M30.TEMqnlIWzX5kNEfYQcNVVdXXhOiai19ptn2e0GHICss');
