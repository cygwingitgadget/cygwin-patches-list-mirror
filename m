From: egor duda <deo@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: Cut and paste problem with cygwin 1.3.1
Date: Thu, 26 Apr 2001 05:59:00 -0000
Message-id: <33191091635.20010426165929@logos-m.ru>
References: <3AE76EC4.EF0FFA66@lucent.com> <20010425222146.D3536@redhat.com> <3AE79346.6E761199@bbn.com> <20010425232756.A4338@redhat.com>
X-SW-Source: 2001-q2/msg00167.html
Content-type: multipart/mixed; boundary="----------=_1583532847-65438-53"

This is a multi-part message in MIME format...

------------=_1583532847-65438-53
Content-length: 824

Hi!

Thursday, 26 April, 2001 Christopher Faylor cgf@redhat.com wrote:

>>> I tried both CYGWIN=tty and CYGWIN=notty and had similar experiences with
>>> both.
>>
>>Cat worked for me as well.  vi on the other hand froze up when I tried
>>pasting more than three lines.  I think I was able to paste larger
>>quantities to vi before.

CF> No problems with vi, either.

i've reproduced it. it looks like bug in my tty_slave changes. hope
this patch helps.

2001-04-26  Egor Duda  <deo@logos-m.ru>

        * tty.cc (tty::make_pipes): Set to_slave pipe mode to non-blocking.
        * fhandler_tty.cc (fhandler_pty_master::accept_input): If pipe buffer
        is full, give slave a chance to read data.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
paste-tty-freeze.diff
paste-tty-freeze.ChangeLog


------------=_1583532847-65438-53
Content-Type: text/plain; charset=us-ascii; name="paste-tty-freeze.ChangeLog"
Content-Disposition: inline; filename="paste-tty-freeze.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 305

MjAwMS0wNC0yNiAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiB0
dHkuY2MgKHR0eTo6bWFrZV9waXBlcyk6IFNldCB0b19zbGF2ZSBwaXBlIG1v
ZGUgdG8gbm9uLWJsb2NraW5nLgoJKiBmaGFuZGxlcl90dHkuY2MgKGZoYW5k
bGVyX3B0eV9tYXN0ZXI6OmFjY2VwdF9pbnB1dCk6IElmIHBpcGUgYnVmZmVy
CglpcyBmdWxsLCBnaXZlIHNsYXZlIGEgY2hhbmNlIHRvIHJlYWQgZGF0YS4K

------------=_1583532847-65438-53
Content-Type: text/x-diff; charset=us-ascii; name="paste-tty-freeze.diff"
Content-Disposition: inline; filename="paste-tty-freeze.diff"
Content-Transfer-Encoding: base64
Content-Length: 2888

SW5kZXg6IGZoYW5kbGVyX3R0eS5jYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9maGFuZGxl
cl90dHkuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzIKZGlmZiAtdSAt
cCAtMiAtcjEuMzIgZmhhbmRsZXJfdHR5LmNjCi0tLSBmaGFuZGxlcl90dHku
Y2MJMjAwMS8wNC8yNCAwMjowNzo1OAkxLjMyCisrKyBmaGFuZGxlcl90dHku
Y2MJMjAwMS8wNC8yNiAxMjo1NDowNgpAQCAtMTY4LDE2ICsxNjgsMzggQEAg
aW50CiBmaGFuZGxlcl9wdHlfbWFzdGVyOjphY2NlcHRfaW5wdXQgKCkKIHsK
LSAgRFdPUkQgd3JpdHRlbjsKKyAgRFdPUkQgYnl0ZXNfbGVmdCwgd3JpdHRl
bjsKICAgRFdPUkQgbjsKICAgRFdPUkQgcmM7CisgIGNoYXIqIHA7CiAKICAg
cmMgPSBXYWl0Rm9yU2luZ2xlT2JqZWN0IChpbnB1dF9tdXRleCwgSU5GSU5J
VEUpOwogCi0gIG4gPSBnZXRfdHR5cCAoKS0+cmVhZF9yZXR2YWwgPSBlYXRf
cmVhZGFoZWFkICgtMSk7CisgIGJ5dGVzX2xlZnQgPSBuID0gZWF0X3JlYWRh
aGVhZCAoLTEpOworICBnZXRfdHR5cCAoKS0+cmVhZF9yZXR2YWwgPSAwOwor
ICBwID0gcmFidWY7CiAKICAgaWYgKG4gIT0gMCkKICAgICB7Ci0gICAgICB0
ZXJtaW9zX3ByaW50ZiAoImFib3V0IHRvIHdyaXRlICVkIGNoYXJzIHRvIHNs
YXZlIiwgbik7Ci0gICAgICByYyA9IFdyaXRlRmlsZSAoZ2V0X291dHB1dF9o
YW5kbGUgKCksIHJhYnVmLCBuLCAmd3JpdHRlbiwgTlVMTCk7CisgICAgICB3
aGlsZSAoYnl0ZXNfbGVmdCA+IDApCisgICAgICAgIHsKKwkgIHRlcm1pb3Nf
cHJpbnRmICgiYWJvdXQgdG8gd3JpdGUgJWQgY2hhcnMgdG8gc2xhdmUiLCBi
eXRlc19sZWZ0KTsKKwkgIHJjID0gV3JpdGVGaWxlIChnZXRfb3V0cHV0X2hh
bmRsZSAoKSwgcCwgYnl0ZXNfbGVmdCwgJndyaXR0ZW4sIE5VTEwpOworCSAg
aWYgKCFyYykKKwkgICAgeworCSAgICAgIGRlYnVnX3ByaW50ZiAoImVycm9y
IHdyaXRpbmcgdG8gcGlwZSAlRSIpOworICAgICAgICAgICAgICBicmVhazsK
KwkgICAgfQorICAgICAgICAgIGdldF90dHlwICgpLT5yZWFkX3JldHZhbCAr
PSB3cml0dGVuOworICAgICAgICAgIHAgKz0gd3JpdHRlbjsKKyAgICAgICAg
ICBieXRlc19sZWZ0IC09IHdyaXR0ZW47CisgICAgICAgICAgaWYgKGJ5dGVz
X2xlZnQgPiAwKQorICAgICAgICAgICAgeworCSAgICAgIGRlYnVnX3ByaW50
ZiAoInRvX3NsYXZlIHBpcGUgaXMgZnVsbCIpOworCSAgICAgIFNldEV2ZW50
IChpbnB1dF9hdmFpbGFibGVfZXZlbnQpOworCSAgICAgIFJlbGVhc2VNdXRl
eCAoaW5wdXRfbXV0ZXgpOworICAgICAgICAgICAgICBTbGVlcCAoMTApOwor
CSAgICAgIHJjID0gV2FpdEZvclNpbmdsZU9iamVjdCAoaW5wdXRfbXV0ZXgs
IElORklOSVRFKTsKKyAgICAgICAgICAgIH0KKwl9CiAgICAgfQogICBlbHNl
CkluZGV4OiB0dHkuY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vdHR5LmNjLHYKcmV0cmll
dmluZyByZXZpc2lvbiAxLjIwCmRpZmYgLXUgLXAgLTIgLXIxLjIwIHR0eS5j
YwotLS0gdHR5LmNjCTIwMDEvMDQvMjQgMTU6MjU6MzAJMS4yMAorKysgdHR5
LmNjCTIwMDEvMDQvMjYgMTI6NTQ6MDYKQEAgLTM2OCw0ICszNjgsOCBAQCB0
dHk6Om1ha2VfcGlwZXMgKGZoYW5kbGVyX3B0eV9tYXN0ZXIgKnB0CiAgIHRl
cm1pb3NfcHJpbnRmICgidHR5JWQgZnJvbV9zbGF2ZSAlcCwgdG9fc2xhdmUg
JXAiLCBudHR5LCBmcm9tX3NsYXZlLAogCQkgIHRvX3NsYXZlKTsKKworICBE
V09SRCBwaXBlX21vZGUgPSBQSVBFX05PV0FJVDsKKyAgaWYgKCFTZXROYW1l
ZFBpcGVIYW5kbGVTdGF0ZSAodG9fc2xhdmUsICZwaXBlX21vZGUsIE5VTEws
IE5VTEwpKQorICAgIHRlcm1pb3NfcHJpbnRmICgiY2FuJ3Qgc2V0IHRvX3Ns
YXZlIHRvIG5vbi1ibG9ja2luZyBtb2RlIik7CiAgIHB0eW0tPnNldF9pb19o
YW5kbGUgKGZyb21fc2xhdmUpOwogICBwdHltLT5zZXRfb3V0cHV0X2hhbmRs
ZSAodG9fc2xhdmUpOwo=

------------=_1583532847-65438-53--
