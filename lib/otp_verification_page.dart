// صفحة التحقق من رمز OTP
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  int _resendAfter = 60;
  late final SupabaseClient _client;

  @override
  void initState() {
    super.initState();
    _client = Supabase.instance.client;
    _startResendCountdown();
  }

  void _startResendCountdown() {
    Future.doWhile(() async {
      if (_resendAfter > 0) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() => _resendAfter--);
        return true;
      }
      return false;
    });
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter the OTP')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await _client
          .from('otp_codes')
          .select()
          .eq('phone_number', widget.phoneNumber)
          .eq('otp', otp)
          .eq('is_used', false)
          .maybeSingle();

      if (response != null) {
        // تحديث حالة is_used
        await _client
            .from('otp_codes')
            .update({'is_used': true})
            .eq('id', response['id']);

        // توجيه المستخدم إلى الصفحة الرئيسية
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid or expired OTP')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Verification failed: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resendOtp() async {
    if (_resendAfter > 0) return;
    try {
      final generatedOtp = '123456'; // استبداله بعملية توليد فعلية لاحقًا
      await _client.from('otp_codes').insert({
        'phone_number': widget.phoneNumber,
        'otp': generatedOtp,
        'expires_at': DateTime.now()
            .add(const Duration(minutes: 5))
            .toIso8601String(),
        'is_used': false,
      });

      setState(() => _resendAfter = 60);
      _startResendCountdown();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP resent successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to resend OTP: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter the OTP sent to ${widget.phoneNumber}'),
            const SizedBox(height: 16),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Verify'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _resendAfter == 0 ? _resendOtp : null,
              child: Text(
                _resendAfter == 0
                    ? 'Resend OTP'
                    : 'Resend in $_resendAfter seconds',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
