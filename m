Return-Path: <cygwin-patches-return-3355-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7700 invoked by alias); 7 Jan 2003 22:49:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7690 invoked from network); 7 Jan 2003 22:49:12 -0000
Message-Id: <4.3.2.7.2.20030107154846.00b30128@smtphost-cod.intra.kyocera-wireless.com>
X-Sender: tcurtiss@smtphost-cod.intra.kyocera-wireless.com
Date: Tue, 07 Jan 2003 22:49:00 -0000
To: cygwin-patches@cygwin.com
From: Troy Curtiss <tcurtiss@qcpi.com>
Subject: [PATCH] 230.4Kbps support for serial port
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_603776294==_"
X-SW-Source: 2003-q1/txt/msg00004.txt.bz2

--=====================_603776294==_
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-length: 1426

Hi,
   Attached is a patch that enables cygwin to talk at 230400 bps on serial 
ports that support the higher rate.  It also does the necessary 
error-checking to confirm whether or not a given port is capable of 
extended bitrates.  I added B230400 (for Posix) and CBR_230400 (for Win32) 
definitions to the appropriate header files (termios.h and winbase.h, 
respectively).  I've been testing for a couple days now and it appears to 
work as designed.  (We use a lot of extended bitrate devices at work, 
mostly with Win32 code - so this simply brings the paradigm across to the 
posix side of the house.)

Question:  Upon failure (ie. trying to configure a non-230.4K capable port 
to talk 230.4K), I simply return -1...  I'm not sure whether POSIX would 
set errno = EINVAL or not... either way is fine.

   Let me know if you have any questions, otherwise it sure would be nice 
to roll this in if possible :)  Thanks,

-Troy


Changelog entry:

2003-01-06  Troy Curtiss <troyc@usa.net>

  * fhandler_serial.cc (fhandler_serial::tcsetattr):
      Add support and capability checking for B230400 bitrate
  * fhandler_serial.cc (fhandler_serial::tcgetattr):
      Add support for B230400 bitrate
  * /cvs/src/src/winsup/w32api/include/winbase.h:
      Add CBR_230400 definition for Win32 support of 230.4Kbps
  * /cvs/src/src/winsup/cygwin/include/sys/termios.h:
      Add B230400 definition for Posix support of 230.4Kbps 
--=====================_603776294==_
Content-Type: application/octet-stream; name="cygwin_serial_230k4_support.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cygwin_serial_230k4_support.patch"
Content-length: 3530

SW5kZXg6IGN5Z3dpbi9maGFuZGxlcl9zZXJpYWwuY2MKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3
aW4vZmhhbmRsZXJfc2VyaWFsLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAx
LjM4CmRpZmYgLXUgLXAgLXIxLjM4IGZoYW5kbGVyX3NlcmlhbC5jYwotLS0g
Y3lnd2luL2ZoYW5kbGVyX3NlcmlhbC5jYwkxNCBEZWMgMjAwMiAwNDowMToz
MiAtMDAwMAkxLjM4CisrKyBjeWd3aW4vZmhhbmRsZXJfc2VyaWFsLmNjCTcg
SmFuIDIwMDMgMDU6Mjg6MzggLTAwMDAKQEAgLTU5MSw2ICs1OTEsOSBAQCBm
aGFuZGxlcl9zZXJpYWw6OnRjc2V0YXR0ciAoaW50IGFjdGlvbiwgCiAgICAg
ICBjYXNlIEIxMTUyMDA6CiAJc3RhdGUuQmF1ZFJhdGUgPSBDQlJfMTE1MjAw
OwogCWJyZWFrOworICAgICAgY2FzZSBCMjMwNDAwOgorCXN0YXRlLkJhdWRS
YXRlID0gQ0JSXzIzMDQwMDsKKwlicmVhazsKICAgICAgIGRlZmF1bHQ6CiAJ
LyogVW5zdXBwb3J0ZWQgYmF1ZCByYXRlISAqLwogCXRlcm1pb3NfcHJpbnRm
ICgiSW52YWxpZCB0LT5jX29zcGVlZCAlZCIsIHQtPmNfb3NwZWVkKTsKQEAg
LTcyMyw4ICs3MjYsMTIgQEAgZmhhbmRsZXJfc2VyaWFsOjp0Y3NldGF0dHIg
KGludCBhY3Rpb24sIAogICBzdGF0ZS5mQWJvcnRPbkVycm9yID0gVFJVRTsK
IAogICAvKiAtLS0tLS0tLS0tLS0tLSBTZXQgc3RhdGUgYW5kIGV4aXQgLS0t
LS0tLS0tLS0tLS0tLS0tICovCi0gIGlmIChtZW1jbXAgKCZvc3RhdGUsICZz
dGF0ZSwgc2l6ZW9mIChzdGF0ZSkpICE9IDApCi0gICAgU2V0Q29tbVN0YXRl
IChnZXRfaGFuZGxlICgpLCAmc3RhdGUpOworICBpZiAoKG1lbWNtcCAoJm9z
dGF0ZSwgJnN0YXRlLCBzaXplb2YgKHN0YXRlKSkgIT0gMCkgJiYKKyAgICAg
ICFTZXRDb21tU3RhdGUgKGdldF9oYW5kbGUgKCksICZzdGF0ZSkpCisgICAg
eworICAgICAgLyogUmV0dXJuIG5vdyBpZiBhbnkgb2YgdGhlIHBhcmFtZXRl
cnMgaW4gdGhlIERDQiBkaWRuJ3QgdGFrZSAqLworICAgICAgcmV0dXJuIC0x
OworICAgIH0KIAogICBzZXRfcl9iaW5hcnkgKCh0LT5jX2lmbGFnICYgSUdO
Q1IpID8gMCA6IDEpOwogICBzZXRfd19iaW5hcnkgKCh0LT5jX29mbGFnICYg
T05MQ1IpID8gMCA6IDEpOwpAQCAtODkwLDYgKzg5Nyw5IEBAIGZoYW5kbGVy
X3NlcmlhbDo6dGNnZXRhdHRyIChzdHJ1Y3QgdGVybWkKIAlicmVhazsKICAg
ICAgIGNhc2UgQ0JSXzExNTIwMDoKIAl0LT5jX2NmbGFnID0gdC0+Y19vc3Bl
ZWQgPSB0LT5jX2lzcGVlZCA9IEIxMTUyMDA7CisJYnJlYWs7CisgICAgICBj
YXNlIENCUl8yMzA0MDA6CisJdC0+Y19jZmxhZyA9IHQtPmNfb3NwZWVkID0g
dC0+Y19pc3BlZWQgPSBCMjMwNDAwOwogCWJyZWFrOwogICAgICAgZGVmYXVs
dDoKIAkvKiBVbnN1cHBvcnRlZCBiYXVkIHJhdGUhICovCkluZGV4OiBjeWd3
aW4vaW5jbHVkZS9zeXMvdGVybWlvcy5oCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2luY2x1
ZGUvc3lzL3Rlcm1pb3MuaCx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS41CmRp
ZmYgLXUgLXAgLXIxLjUgdGVybWlvcy5oCi0tLSBjeWd3aW4vaW5jbHVkZS9z
eXMvdGVybWlvcy5oCTIyIEp1bCAyMDAyIDA5OjExOjQ1IC0wMDAwCTEuNQor
KysgY3lnd2luL2luY2x1ZGUvc3lzL3Rlcm1pb3MuaAk3IEphbiAyMDAzIDA1
OjI4OjQ4IC0wMDAwCkBAIC0xNzcsNyArMTc3LDggQEAgUE9TSVggY29tbWFu
ZHMgKi8KICNkZWZpbmUgQjU3NjAwCSAweDAxMDAxCiAjZGVmaW5lIEIxMTUy
MDAJIDB4MDEwMDIKICNkZWZpbmUgQjEyODAwMAkgMHgwMTAwMwotI2RlZmlu
ZSBCMjU2MDAwCSAweDAxMDAzCisjZGVmaW5lIEIyMzA0MDAgIDB4MDEwMDQK
KyNkZWZpbmUgQjI1NjAwMAkgMHgwMTAwNQogI2RlZmluZSBDUlRTWE9GRiAw
eDA0MDAwCiAjZGVmaW5lIENSVFNDVFMJIDB4MDgwMDAKIApJbmRleDogdzMy
YXBpL2luY2x1ZGUvd2luYmFzZS5oCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
UkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvdzMyYXBpL2luY2x1ZGUv
d2luYmFzZS5oLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjMyCmRpZmYgLXUg
LXAgLXIxLjMyIHdpbmJhc2UuaAotLS0gdzMyYXBpL2luY2x1ZGUvd2luYmFz
ZS5oCTMwIERlYyAyMDAyIDA4OjQ4OjIzIC0wMDAwCTEuMzIKKysrIHczMmFw
aS9pbmNsdWRlL3dpbmJhc2UuaAk3IEphbiAyMDAzIDA1OjI5OjIzIC0wMDAw
CkBAIC00MzUsNiArNDM1LDcgQEAgZXh0ZXJuICJDIiB7CiAjZGVmaW5lIENC
Ul81NzYwMAk1NzYwMAogI2RlZmluZSBDQlJfMTE1MjAwCTExNTIwMAogI2Rl
ZmluZSBDQlJfMTI4MDAwCTEyODAwMAorI2RlZmluZSBDQlJfMjMwNDAwICAy
MzA0MDAKICNkZWZpbmUgQ0JSXzI1NjAwMAkyNTYwMDAKICNkZWZpbmUgQkFD
S1VQX0lOVkFMSUQJMAogI2RlZmluZSBCQUNLVVBfREFUQSAxCg==

--=====================_603776294==_--
