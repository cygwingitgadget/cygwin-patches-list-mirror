Return-Path: <cygwin-patches-return-3453-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21568 invoked by alias); 23 Jan 2003 00:34:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21520 invoked from network); 23 Jan 2003 00:34:45 -0000
Message-Id: <4.3.2.7.2.20030122170920.00b83008@smtphost-cod.intra.kyocera-wireless.com>
X-Sender: tcurtiss@smtphost-cod.intra.kyocera-wireless.com
Date: Thu, 23 Jan 2003 00:34:00 -0000
To: cygwin-patches@cygwin.com
From: Troy Curtiss <tcurtiss@qcpi.com>
Subject: [PATCH] - tc{set,get}attr() error checking and B0 support
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_201890663==_"
X-SW-Source: 2003-q1/txt/msg00102.txt.bz2

--=====================_201890663==_
Content-Type: multipart/alternative;
	boundary="=====================_201890673==_.ALT"

--=====================_201890673==_.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-length: 1160

Chris,
   Per your comments on my prior patches, I have re-architected my 
error-checking changes so that the short-circuiting behavior in tcsetattr() 
is gone.  I also cleaned up the B0 (ie. drop DTR) support to more closely 
resemble what POSIX expects while not enraging Win32 :)  Please let me know 
if this passes muster - the prior test case program still applies.  My only 
remaining question is why errno isn't being propagated back up to the 
application?  Thanks,

-Troy

2003-01-22  Troy Curtiss  <troyc@usa.net>

         * fhandler_serial.cc (fhandler_serial::tcsetattr): Add error-checking
         so that if any Win32 SetComm*() calls fail, errno gets set to EINVAL
      and tcsetattr() returns -1. Catches invalid bitrates, mostly.
         * fhandler_serial.cc (fhandler_serial::tcsetattr): If baud rate 
setting
      is B0, just drop DTR and leave Win32 DCB bitrate as-is since 0 is not
      a valid Win32 setting.
         (fhandler_serial::tcgetattr): If DTR is low, populate the bitrate 
as B0,
      otherwise get it from the DCB.  Works around Win32's lack of bitrate 0
      at the expense of using DTR as the flag (POSIX behavior.)
--=====================_201890673==_.ALT
Content-Type: text/html; charset="us-ascii"
Content-length: 1587

<html>
<tt>Chris,<br>
&nbsp; Per your comments on my prior patches, I have re-architected my
error-checking changes so that the short-circuiting behavior in
tcsetattr() is gone.&nbsp; I also cleaned up the B0 (ie. drop DTR)
support to more closely resemble what POSIX expects while not enraging
Win32 :)&nbsp; Please let me know if this passes muster - the prior test
case program still applies.&nbsp; My only remaining question is why errno
isn't being propagated back up to the application?&nbsp; Thanks,<br>
<br>
-Troy<br>
<br>
2003-01-22&nbsp; Troy Curtiss&nbsp; &lt;troyc@usa.net&gt;<br>
<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>*
fhandler_serial.cc (fhandler_serial::tcsetattr): Add error-checking<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>so that if
any Win32 SetComm*() calls fail, errno gets set to EINVAL<br>
&nbsp;&nbsp;&nbsp;&nbsp; and tcsetattr() returns -1. Catches invalid
bitrates, mostly.<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>*
fhandler_serial.cc (fhandler_serial::tcsetattr): If baud rate
setting<br>
&nbsp;&nbsp;&nbsp;&nbsp; is B0, just drop DTR and leave Win32 DCB bitrate
as-is since 0 is not<br>
&nbsp;&nbsp;&nbsp;&nbsp; a valid Win32 setting.<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>(fhandler_serial::tcgetattr):
If DTR is low, populate the bitrate as B0,<br>
&nbsp;&nbsp;&nbsp;&nbsp; otherwise get it from the DCB.&nbsp; Works
around Win32's lack of bitrate 0<br>
&nbsp;&nbsp;&nbsp;&nbsp; at the expense of using DTR as the flag (POSIX
behavior.)</html>

--=====================_201890673==_.ALT--

--=====================_201890663==_
Content-Type: application/octet-stream; name="serial_support_patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="serial_support_patch"
Content-length: 6788

SW5kZXg6IGN5Z3dpbi9maGFuZGxlcl9zZXJpYWwuY2MKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3
aW4vZmhhbmRsZXJfc2VyaWFsLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAx
LjQwCmRpZmYgLXUgLXAgLXIxLjQwIGZoYW5kbGVyX3NlcmlhbC5jYwotLS0g
Y3lnd2luL2ZoYW5kbGVyX3NlcmlhbC5jYwkxMCBKYW4gMjAwMyAxMjozMjo0
NiAtMDAwMAkxLjQwCisrKyBjeWd3aW4vZmhhbmRsZXJfc2VyaWFsLmNjCTIz
IEphbiAyMDAzIDAwOjA3OjMyIC0wMDAwCkBAIC01MzAsOCArNTMwLDggQEAg
ZmhhbmRsZXJfc2VyaWFsOjp0Y3NldGF0dHIgKGludCBhY3Rpb24sIAogICBD
T01NVElNRU9VVFMgdG87CiAgIERDQiBvc3RhdGUsIHN0YXRlOwogICB1bnNp
Z25lZCBpbnQgb3Z0aW1lID0gdnRpbWVfLCBvdm1pbiA9IHZtaW5fOwotICBp
bnQgdG1wRHRyLCB0bXBSdHM7Ci0gIHRtcER0ciA9IHRtcFJ0cyA9IDA7Cisg
IGludCB0bXBEdHIsIHRtcFJ0cywgc2V0Y29tbWVycjsKKyAgc2V0Y29tbWVy
ciA9IHRtcER0ciA9IHRtcFJ0cyA9IDA7CiAKICAgdGVybWlvc19wcmludGYg
KCJhY3Rpb24gJWQiLCBhY3Rpb24pOwogICBpZiAoKGFjdGlvbiA9PSBUQ1NB
RFJBSU4pIHx8IChhY3Rpb24gPT0gVENTQUZMVVNIKSkKQEAgLTU1NCw5ICs1
NTQsMTAgQEAgZmhhbmRsZXJfc2VyaWFsOjp0Y3NldGF0dHIgKGludCBhY3Rp
b24sIAogCiAgIHN3aXRjaCAodC0+Y19vc3BlZWQpCiAgICAgewotICAgICAg
Y2FzZSBCMDoJLyogZHJvcCBEVFIgKi8KKyAgICAgIGNhc2UgQjA6CisgICAg
LyogRHJvcCBEVFIgLSBidXQgbGVhdmUgRENCLXJlc2lkZW50IGJpdHJhdGUg
YXMtaXMgc2luY2UKKyAgICAgICAwIGlzIGFuIGludmFsaWQgYml0cmF0ZSBp
biBXaW4zMiAqLwogCWRyb3BEVFIgPSBUUlVFOwotCXN0YXRlLkJhdWRSYXRl
ID0gMDsKIAlicmVhazsKICAgICAgIGNhc2UgQjExMDoKIAlzdGF0ZS5CYXVk
UmF0ZSA9IENCUl8xMTA7CkBAIC03MjUsOCArNzI2LDE2IEBAIGZoYW5kbGVy
X3NlcmlhbDo6dGNzZXRhdHRyIChpbnQgYWN0aW9uLCAKIAogICBzdGF0ZS5m
QWJvcnRPbkVycm9yID0gVFJVRTsKIAotICBpZiAobWVtY21wICgmb3N0YXRl
LCAmc3RhdGUsIHNpemVvZiAoc3RhdGUpKSAhPSAwKQotICAgIFNldENvbW1T
dGF0ZSAoZ2V0X2hhbmRsZSAoKSwgJnN0YXRlKTsKKyAgaWYgKChtZW1jbXAg
KCZvc3RhdGUsICZzdGF0ZSwgc2l6ZW9mIChzdGF0ZSkpICE9IDApICYmCisg
ICAgICAhU2V0Q29tbVN0YXRlIChnZXRfaGFuZGxlICgpLCAmc3RhdGUpKQor
ICB7CisgICAgLyogU2V0Q29tbVN0YXRlKCkgZmFpbGVkLCB1c3VhbGx5IGR1
ZSB0byBpbnZhbGlkIERDQiBwYXJhbS4KKyAgICAgICBLZWVwIHRyYWNrIG9m
IHRoaXMgc28gd2UgY2FuIHNldCBlcnJubyB0byBFSU5WQUwgbGF0ZXIKKyAg
ICAgICBhbmQgcmV0dXJuIGZhaWx1cmUgKi8KKyAgICB0ZXJtaW9zX3ByaW50
ZiAoIlNldENvbW1TdGF0ZSgpIGZhaWxlZCwgR2V0TGFzdEVycm9yID0gJWQi
LAorICAgICAgICAgICAgICAgICAgICBHZXRMYXN0RXJyb3IoKSk7CisgICAg
c2V0Y29tbWVyciA9IC0xOworICB9CiAKICAgc2V0X3JfYmluYXJ5ICgodC0+
Y19pZmxhZyAmIElHTkNSKSA/IDAgOiAxKTsKICAgc2V0X3dfYmluYXJ5ICgo
dC0+Y19vZmxhZyAmIE9OTENSKSA/IDAgOiAxKTsKQEAgLTc5NCw0OSArODAz
LDU1IEBAIGZoYW5kbGVyX3NlcmlhbDo6dGNzZXRhdHRyIChpbnQgYWN0aW9u
LCAKIAogICBkZWJ1Z19wcmludGYgKCJ2dGltZSAlZCwgdm1pbiAlZCIsIHZ0
aW1lXywgdm1pbl8pOwogCi0gIGlmIChvdm1pbiA9PSB2bWluXyAmJiBvdnRp
bWUgPT0gdnRpbWVfKQotICAgIHJldHVybiAwOworICBpZiAob3ZtaW4gIT0g
dm1pbl8gfHwgb3Z0aW1lICE9IHZ0aW1lXykKKyAgeworICAgIG1lbXNldCAo
JnRvLCAwLCBzaXplb2YgKHRvKSk7CiAKLSAgbWVtc2V0ICgmdG8sIDAsIHNp
emVvZiAodG8pKTsKLQotICBpZiAoKHZtaW5fID4gMCkgJiYgKHZ0aW1lXyA9
PSAwKSkKKyAgICBpZiAoKHZtaW5fID4gMCkgJiYgKHZ0aW1lXyA9PSAwKSkK
ICAgICB7CiAgICAgICAvKiBSZXR1cm5zIGltbWVkaWF0ZWx5IHdpdGggd2hh
dGV2ZXIgaXMgaW4gYnVmZmVyIG9uIGEgUmVhZEZpbGUoKTsKLQkgb3IgYmxv
Y2tzIGlmIG5vdGhpbmcgZm91bmQuICBXZSB3aWxsIGtlZXAgY2FsbGluZyBS
ZWFkRmlsZSgpOyB1bnRpbAotCSB2bWluXyBjaGFyYWN0ZXJzIGFyZSByZWFk
ICovCisgICAgICAgICBvciBibG9ja3MgaWYgbm90aGluZyBmb3VuZC4gIFdl
IHdpbGwga2VlcCBjYWxsaW5nIFJlYWRGaWxlKCk7IHVudGlsCisgICAgICAg
ICB2bWluXyBjaGFyYWN0ZXJzIGFyZSByZWFkICovCiAgICAgICB0by5SZWFk
SW50ZXJ2YWxUaW1lb3V0ID0gdG8uUmVhZFRvdGFsVGltZW91dE11bHRpcGxp
ZXIgPSBNQVhEV09SRDsKICAgICAgIHRvLlJlYWRUb3RhbFRpbWVvdXRDb25z
dGFudCA9IE1BWERXT1JEIC0gMTsKICAgICB9Ci0gIGVsc2UgaWYgKCh2bWlu
XyA9PSAwKSAmJiAodnRpbWVfID4gMCkpCisgICAgZWxzZSBpZiAoKHZtaW5f
ID09IDApICYmICh2dGltZV8gPiAwKSkKICAgICB7CiAgICAgICAvKiBzZXQg
dGltZW9vdXQgY29uc3RhbnQgYXBwcm9wcmlhdGVseSBhbmQgd2Ugd2lsbCBv
bmx5IHRyeSB0bwotCSByZWFkIG9uZSBjaGFyYWN0ZXIgaW4gUmVhZEZpbGUo
KSAqLworICAgICAgICAgcmVhZCBvbmUgY2hhcmFjdGVyIGluIFJlYWRGaWxl
KCkgKi8KICAgICAgIHRvLlJlYWRUb3RhbFRpbWVvdXRDb25zdGFudCA9IHZ0
aW1lXzsKICAgICAgIHRvLlJlYWRJbnRlcnZhbFRpbWVvdXQgPSB0by5SZWFk
VG90YWxUaW1lb3V0TXVsdGlwbGllciA9IE1BWERXT1JEOwogICAgIH0KLSAg
ZWxzZSBpZiAoKHZtaW5fID4gMCkgJiYgKHZ0aW1lXyA+IDApKQorICAgIGVs
c2UgaWYgKCh2bWluXyA+IDApICYmICh2dGltZV8gPiAwKSkKICAgICB7CiAg
ICAgICAvKiB0aW1lIGFwcGxpZXMgdG8gdGhlIGludGVydmFsIHRpbWUgZm9y
IHRoaXMgY2FzZSAqLwogICAgICAgdG8uUmVhZEludGVydmFsVGltZW91dCA9
IHZ0aW1lXzsKICAgICB9Ci0gIGVsc2UgaWYgKCh2bWluXyA9PSAwKSAmJiAo
dnRpbWVfID09IDApKQorICAgIGVsc2UgaWYgKCh2bWluXyA9PSAwKSAmJiAo
dnRpbWVfID09IDApKQogICAgIHsKICAgICAgIC8qIHJldHVybnMgaW1tZWRp
YXRlbHkgd2l0aCB3aGF0ZXZlciBpcyBpbiBidWZmZXIgYXMgcGVyCi0JIFRp
bWUtT3V0cyBkb2NzIGluIFdpbjMyIFNESyBBUEkgZG9jcyAqLworICAgICAg
ICAgVGltZS1PdXRzIGRvY3MgaW4gV2luMzIgU0RLIEFQSSBkb2NzICovCiAg
ICAgICB0by5SZWFkSW50ZXJ2YWxUaW1lb3V0ID0gTUFYRFdPUkQ7CiAgICAg
fQogCi0gIGRlYnVnX3ByaW50ZiAoIlJlYWRUb3RhbFRpbWVvdXRDb25zdGFu
dCAlZCwgUmVhZEludGVydmFsVGltZW91dCAlZCwgUmVhZFRvdGFsVGltZW91
dE11bHRpcGxpZXIgJWQiLAotCQl0by5SZWFkVG90YWxUaW1lb3V0Q29uc3Rh
bnQsIHRvLlJlYWRJbnRlcnZhbFRpbWVvdXQsIHRvLlJlYWRUb3RhbFRpbWVv
dXRNdWx0aXBsaWVyKTsKLSAgaW50IHJlcyA9IFNldENvbW1UaW1lb3V0cyAo
Z2V0X2hhbmRsZSAoKSwgJnRvKTsKLSAgaWYgKCFyZXMpCi0gICAgewotICAg
ICAgc3lzdGVtX3ByaW50ZiAoIlNldENvbW1UaW1lb3V0IGZhaWxlZCwgJUUi
KTsKLSAgICAgIF9fc2V0ZXJybm8gKCk7Ci0gICAgICByZXR1cm4gLTE7Ci0g
ICAgfQorICAgIGRlYnVnX3ByaW50ZiAoIlJlYWRUb3RhbFRpbWVvdXRDb25z
dGFudCAlZCwgUmVhZEludGVydmFsVGltZW91dCAlZCwgUmVhZFRvdGFsVGlt
ZW91dE11bHRpcGxpZXIgJWQiLAorICAgICAgICAgICAgICAgICAgdG8uUmVh
ZFRvdGFsVGltZW91dENvbnN0YW50LCB0by5SZWFkSW50ZXJ2YWxUaW1lb3V0
LCB0by5SZWFkVG90YWxUaW1lb3V0TXVsdGlwbGllcik7CiAKLSAgcmV0dXJu
IDA7CisgICAgaWYgKCFTZXRDb21tVGltZW91dHMoZ2V0X2hhbmRsZSAoKSwg
JnRvKSkKKyAgICB7CisgICAgICAvKiBTZXRDb21tVGltZW91dHMoKSBmYWls
ZWQuIEtlZXAgdHJhY2sgb2YgdGhpcyBzbyB3ZQorICAgICAgICAgY2FuIHNl
dCBlcnJubyB0byBFSU5WQUwgbGF0ZXIgYW5kIHJldHVybiBmYWlsdXJlICov
CisgICAgICB0ZXJtaW9zX3ByaW50ZiAoIlNldENvbW1UaW1lb3V0cygpIGZh
aWxlZCwgR2V0TGFzdEVycm9yID0gJWQiLAorICAgICAgICAgICAgICAgICAg
ICAgIEdldExhc3RFcnJvcigpKTsKKyAgICAgIHNldGNvbW1lcnIgPSAtMTsK
KyAgICB9CisgIH0KKworICAvKiBJZiBvbmUgb3IgbW9yZSBvZiB0aGUgV2lu
MzIgU2V0Q29tbSooKSdzIGZhaWxlZCwKKyAgICAgc2V0IGVycm5vID0gRUlO
VkFMICovCisgIGlmIChzZXRjb21tZXJyKSBzZXRfZXJybm8oRUlOVkFMKTsK
KyAgCisgIHJldHVybiBzZXRjb21tZXJyOwogfQogCiAvKiB0Y2dldGF0dHI6
IFBPU0lYIDcuMi4xLjEgKi8KQEAgLTg1NCwxMiArODY5LDEwIEBAIGZoYW5k
bGVyX3NlcmlhbDo6dGNnZXRhdHRyIChzdHJ1Y3QgdGVybWkKIAogICAvKiAt
LS0tLS0tLS0tLS0tLSBCYXVkIHJhdGUgLS0tLS0tLS0tLS0tLS0tLS0tICov
CiAKLSAgc3dpdGNoIChzdGF0ZS5CYXVkUmF0ZSkKKyAgLyogSWYgRFRSIGlz
IE5PVCBzZXQsIHJldHVybiBCMCBhcyBvdXIgc3BlZWQgKi8KKyAgaWYgKGR0
ciAhPSBUSU9DTV9EVFIpIHQtPmNfY2ZsYWcgPSB0LT5jX29zcGVlZCA9IHQt
PmNfaXNwZWVkID0gQjA7CisgIGVsc2Ugc3dpdGNoIChzdGF0ZS5CYXVkUmF0
ZSkKICAgICB7Ci0gICAgICBjYXNlIDA6Ci0JLyogRklYTUU6IG5lZWQgdG8g
ZHJvcCBEVFIgKi8KLQl0LT5jX2NmbGFnID0gdC0+Y19vc3BlZWQgPSB0LT5j
X2lzcGVlZCA9IEIwOwotCWJyZWFrOwogICAgICAgY2FzZSBDQlJfMTEwOgog
CXQtPmNfY2ZsYWcgPSB0LT5jX29zcGVlZCA9IHQtPmNfaXNwZWVkID0gQjEx
MDsKIAlicmVhazsK

--=====================_201890663==_--
