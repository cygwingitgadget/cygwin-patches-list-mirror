From: Egor Duda <deo@logos-m.ru>
To: cygwin-patches@sourceware.cygnus.com
Subject: interrupted sleep returns wrong value
Date: Fri, 15 Sep 2000 12:27:00 -0000
Message-id: <37298513830.20000915232401@logos-m.ru>
X-SW-Source: 2000-q3/msg00094.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65437-13"

This is a multi-part message in MIME format...

------------=_1583532846-65437-13
Content-length: 486

Hi!

  SUSv2 says:

    If sleep() returns because the requested time has elapsed, the value
    returned will be 0. If sleep() returns because of premature arousal due to
    delivery of a signal, the return value will be the "unslept" amount (the
    requested time minus the time actually slept) in seconds.

attached patch accomplish this.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
interrupted-sleep-ret-val.ChangeLog
interrupted-sleep-ret-val.diff


------------=_1583532846-65437-13
Content-Type: text/plain; charset=us-ascii;
 name="interrupted-sleep-ret-val.ChangeLog"
Content-Disposition: inline; filename="interrupted-sleep-ret-val.ChangeLog"
Content-Transfer-Encoding: base64
Content-Length: 200

MjAwMC0wOS0xNSAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBz
aWduYWwuY2MgKHNsZWVwKTogSWYgaW50ZXJydXB0ZWQgYnkgc2lnbmFsLCBy
ZXR1cm4gdGhlCglyZXF1ZXN0ZWQgdGltZSBtaW51cyB0aGUgdGltZSBhY3R1
YWxseSBzbGVwdC4K

------------=_1583532846-65437-13
Content-Type: text/x-diff; charset=us-ascii;
 name="interrupted-sleep-ret-val.diff"
Content-Disposition: inline; filename="interrupted-sleep-ret-val.diff"
Content-Transfer-Encoding: base64
Content-Length: 1310

SW5kZXg6IHdpbnN1cC9jeWd3aW4vc2lnbmFsLmNjCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2lu
L3NpZ25hbC5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xMApkaWZmIC11
IC1yMS4xMCBzaWduYWwuY2MKLS0tIHNpZ25hbC5jYwkyMDAwLzA5LzExIDAw
OjI1OjU3CTEuMTAKKysrIHNpZ25hbC5jYwkyMDAwLzA5LzE1IDE5OjE4OjE3
CkBAIC00NCwxOSArNDQsMjIgQEAKIHVuc2lnbmVkIGludAogc2xlZXAgKHVu
c2lnbmVkIGludCBzZWNvbmRzKQogewotICBpbnQgcmVzOworICBpbnQgcmM7
CiAgIHVuc2lnbmVkIHN0YXJ0X3RpbWU7CisgIHVuc2lnbmVkIGludCByZXM7
CiAKICAgc3RhcnRfdGltZSA9IEdldFRpY2tDb3VudCAoKTsKIAogICBzeXNj
YWxsX3ByaW50ZiAoInNsZWVwICglZCkiLCBzZWNvbmRzKTsKLSAgcmVzID0g
V2FpdEZvclNpbmdsZU9iamVjdCAoc2lnbmFsX2Fycml2ZWQsIHNlY29uZHMg
KiAxMDAwKTsKLSAgaWYgKHJlcyA9PSBXQUlUX1RJTUVPVVQpCi0gICAgewot
ICAgICAgc3lzY2FsbF9wcmludGYgKCIwID0gc2xlZXAgKCVkKSIsIHNlY29u
ZHMpOwotICAgICAgcmV0dXJuIDA7Ci0gICAgfQotICByZXR1cm4gKEdldFRp
Y2tDb3VudCAoKSAtIHN0YXJ0X3RpbWUpLzEwMDA7CisgIHJjID0gV2FpdEZv
clNpbmdsZU9iamVjdCAoc2lnbmFsX2Fycml2ZWQsIHNlY29uZHMgKiAxMDAw
KTsKKyAgaWYgKHJjID09IFdBSVRfVElNRU9VVCkKKyAgICByZXMgPSAwOwor
ICBlbHNlCisgICAgcmVzID0gc2Vjb25kcyAtIChHZXRUaWNrQ291bnQgKCkg
LSBzdGFydF90aW1lKS8xMDAwOworCisgIHN5c2NhbGxfcHJpbnRmICgiJWQg
PSBzbGVlcCAoJWQpIiwgcmVzLCBzZWNvbmRzKTsKKworICByZXR1cm4gcmVz
OwogfQogCiBleHRlcm4gIkMiCg==

------------=_1583532846-65437-13--
