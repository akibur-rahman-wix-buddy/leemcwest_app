import 'package:leemcwest/features/authentication/data/rx_post_login/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_sign_up/rx.dart';
import 'package:leemcwest/features/authentication/data/rx_post_verify_email/rx.dart';
import 'package:leemcwest/features/authentication/model/login_model.dart';
import 'package:leemcwest/features/authentication/model/otp_verify_model.dart';
import 'package:rxdart/subjects.dart';
SignUpRx signUpRxObj = SignUpRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
VerifyEmailRX verifyEmailRxObj = VerifyEmailRX(empty: OtpVerifyModel(), dataFetcher: BehaviorSubject<OtpVerifyModel>());
LoginRx loginRxObj = LoginRx(empty: LoginModel(), dataFetcher: BehaviorSubject<LoginModel>());