From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: einval-on-wrong-args patch
Date: Fri, 16 Feb 2001 07:38:00 -0000
Message-id: <12986060127.20010216183755@logos-m.ru>
X-SW-Source: 2001-q1/msg00078.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65438-6"

This is a multi-part message in MIME format...

------------=_1583532846-65438-6
Content-length: 263

Hi!

[pedantic mode on]

  return  EINVAL  if  signal()  or  lseek()  are  called  with illegal
arguments.

[pedantic mode off :)]

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
einval-on-wrong-args.diff
einval-on-wrong-args.ChangeLog


------------=_1583532846-65438-6
Content-Type: text/plain; charset=us-ascii;
 name="einval-on-wrong-args.ChangeLog"
Content-Disposition: inline; filename="einval-on-wrong-args.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 232

MjAwMS0wMi0wOSAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBz
aWduYWwuY2MgKHNpZ25hbCk6IFByb2hpYml0IHNldHRpbmcgaGFuZGxlcnMg
Zm9yIFNJR0tJTEwgYW5kCglTSUdTVE9QCgkqIHN5c2NhbGxzLmNjIChfbHNl
ZWspOiBSZXR1cm4gRUlOVkFMIG9uIGludmFsaWQgaW5wdXQK

------------=_1583532846-65438-6
Content-Type: text/x-diff; charset=us-ascii; name="einval-on-wrong-args.diff"
Content-Disposition: inline; filename="einval-on-wrong-args.diff"
Content-Transfer-Encoding: base64
Content-Length: 1509

SW5kZXg6IHNpZ25hbC5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9zaWduYWwuY2Msdgpy
ZXRyaWV2aW5nIHJldmlzaW9uIDEuMjIKZGlmZiAtdSAtcjEuMjIgc2lnbmFs
LmNjCi0tLSBzaWduYWwuY2MJMjAwMS8wMS8xNyAxNDo1NzowOQkxLjIyCisr
KyBzaWduYWwuY2MJMjAwMS8wMi8wOSAxNToyNzoxMApAQCAtNDYsNyArNDYs
NyBAQAogICBfc2lnX2Z1bmNfcHRyIHByZXY7CiAKICAgLyogY2hlY2sgdGhh
dCBzaWcgaXMgaW4gcmlnaHQgcmFuZ2UgKi8KLSAgaWYgKHNpZyA8IDAgfHwg
c2lnID49IE5TSUcpCisgIGlmIChzaWcgPCAwIHx8IHNpZyA+PSBOU0lHIHx8
IHNpZyA9PSBTSUdLSUxMIHx8IHNpZyA9PSBTSUdTVE9QKQogICAgIHsKICAg
ICAgIHNldF9lcnJubyAoRUlOVkFMKTsKICAgICAgIHN5c2NhbGxfcHJpbnRm
ICgiU0lHX0VSUiA9IHNpZ25hbCAoJWQsICVwKSIsIHNpZywgZnVuYyk7Cklu
ZGV4OiBzeXNjYWxscy5jYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYyx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS44MQpkaWZmIC11IC1yMS44MSBzeXNj
YWxscy5jYwotLS0gc3lzY2FsbHMuY2MJMjAwMS8wMi8wNiAxNDowNzowMgkx
LjgxCisrKyBzeXNjYWxscy5jYwkyMDAxLzAyLzA5IDE1OjI3OjExCkBAIC00
NDcsNyArNDQ3LDEyIEBACiAgIG9mZl90IHJlczsKICAgc2lnZnJhbWUgdGhp
c2ZyYW1lIChtYWludGhyZWFkKTsKIAotICBpZiAoZmR0YWIubm90X29wZW4g
KGZkKSkKKyAgaWYgKCBkaXIgIT0gU0VFS19TRVQgJiYgZGlyICE9IFNFRUtf
Q1VSICYmIGRpciAhPSBTRUVLX0VORCApCisgICAgeworICAgICAgc2V0X2Vy
cm5vICggRUlOVkFMICk7CisgICAgICByZXMgPSAtMTsKKyAgICB9CisgIGVs
c2UgaWYgKGZkdGFiLm5vdF9vcGVuIChmZCkpCiAgICAgewogICAgICAgc2V0
X2Vycm5vIChFQkFERik7CiAgICAgICByZXMgPSAtMTsK

------------=_1583532846-65438-6--
