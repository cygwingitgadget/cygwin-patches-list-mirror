From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: signal semaphores inheritance
Date: Tue, 20 Feb 2001 08:25:00 -0000
Message-id: <1616663500.20010220192409@logos-m.ru>
X-SW-Source: 2001-q1/msg00090.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65438-8"

This is a multi-part message in MIME format...

------------=_1583532846-65438-8
Content-length: 469

Hi!

  if  ntsec is on and cygwin app a.exe  (with pid x) starts non-cygwin
app  b.exe,  b.exe  inherits  cygwin1S3.sigcatch.x semaphore. if a.exe
dies  and  b.exe continue  execution,  and  if  new  cygwin  app c.exe
got  pid  x it, fails to create sigcatch semaphore. looks like typo in
getsem() to me. is this patch ok?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
signal-semaphore-no-inherit.diff
signal-semaphore-no-inherit.ChangeLog


------------=_1583532846-65438-8
Content-Type: text/x-diff; charset=us-ascii;
 name="signal-semaphore-no-inherit.ChangeLog"
Content-Disposition: inline; filename="signal-semaphore-no-inherit.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 822

SW5kZXg6IHNpZ3Byb2MuY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vc2lncHJvYy5jYyx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS43MgpkaWZmIC11IC1wIC0yIC1yMS43
MiBzaWdwcm9jLmNjCi0tLSBzaWdwcm9jLmNjCTIwMDEvMDIvMTAgMDQ6MjA6
NTIJMS43MgorKysgc2lncHJvYy5jYwkyMDAxLzAyLzIwIDE1OjU3OjQ4CkBA
IC05MDAsNSArOTAwLDUgQEAgZ2V0c2VtIChfcGluZm8gKnAsIGNvbnN0IGNo
YXIgKnN0ciwgaW50IAogCiAgICAgICBEV09SRCB3aW5waWQgPSBHZXRDdXJy
ZW50UHJvY2Vzc0lkICgpOwotICAgICAgaCA9IENyZWF0ZVNlbWFwaG9yZSAo
YWxsb3dfbnRzZWMgPyBzZWNfdXNlciAoc2FfYnVmKSA6ICZzZWNfbm9uZV9u
aWgsCisgICAgICBoID0gQ3JlYXRlU2VtYXBob3JlIChhbGxvd19udHNlYyA/
IHNlY191c2VyX25paCAoc2FfYnVmKSA6ICZzZWNfbm9uZV9uaWgsCiAJCQkg
ICBpbml0LCBtYXgsIHN0ciA9IHNoYXJlZF9uYW1lIChzdHIsIHdpbnBpZCkp
OwogICAgICAgcCA9IG15c2VsZjsK

------------=_1583532846-65438-8
Content-Type: text/x-diff; charset=us-ascii;
 name="signal-semaphore-no-inherit.diff"
Content-Disposition: inline; filename="signal-semaphore-no-inherit.diff"
Content-Transfer-Encoding: base64
Content-Length: 822

SW5kZXg6IHNpZ3Byb2MuY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vc2lncHJvYy5jYyx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS43MgpkaWZmIC11IC1wIC0yIC1yMS43
MiBzaWdwcm9jLmNjCi0tLSBzaWdwcm9jLmNjCTIwMDEvMDIvMTAgMDQ6MjA6
NTIJMS43MgorKysgc2lncHJvYy5jYwkyMDAxLzAyLzIwIDE1OjU3OjQ4CkBA
IC05MDAsNSArOTAwLDUgQEAgZ2V0c2VtIChfcGluZm8gKnAsIGNvbnN0IGNo
YXIgKnN0ciwgaW50IAogCiAgICAgICBEV09SRCB3aW5waWQgPSBHZXRDdXJy
ZW50UHJvY2Vzc0lkICgpOwotICAgICAgaCA9IENyZWF0ZVNlbWFwaG9yZSAo
YWxsb3dfbnRzZWMgPyBzZWNfdXNlciAoc2FfYnVmKSA6ICZzZWNfbm9uZV9u
aWgsCisgICAgICBoID0gQ3JlYXRlU2VtYXBob3JlIChhbGxvd19udHNlYyA/
IHNlY191c2VyX25paCAoc2FfYnVmKSA6ICZzZWNfbm9uZV9uaWgsCiAJCQkg
ICBpbml0LCBtYXgsIHN0ciA9IHNoYXJlZF9uYW1lIChzdHIsIHdpbnBpZCkp
OwogICAgICAgcCA9IG15c2VsZjsK

------------=_1583532846-65438-8--
