Return-Path: <cygwin-patches-return-3791-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20217 invoked by alias); 8 Apr 2003 19:18:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20208 invoked from network); 8 Apr 2003 19:18:09 -0000
To: cygwin-patches@cygwin.com
Subject: PATCH: Better handle accented characters from the console
MIME-Version: 1.0
Message-ID: <OF6CEF17F8.90DA3582-ON85256D02.0067BCF9-85256D02.006A074C@abinitio.com>
From: Bob Cassels <bcassels@abinitio.com>
Date: Tue, 08 Apr 2003 19:18:00 -0000
Content-Type: multipart/mixed; boundary="=_mixed 006A074A85256D02_="
X-SW-Source: 2003-q2/txt/msg00018.txt.bz2

--=_mixed 006A074A85256D02_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-length: 1331

This patch allows pasting accented characters into the console, and also=20
typing them using the "alt + numerics" sequences.

e.g. (with num-lock on):

<alt> 0 1 2 8 =3D> ?=20
<alt> 0 2 3 3 =3D> =E9

Note that to see the Euro, you'll need to switch your console window to=20
use a TrueType font.  (Click right on the window title, select=20
"Properties", select a TrueType font.)  And you'll need to switch the=20
console code page to something that contains the Euro -- e.g 'cmd /c chcp=20
1252'.)

It works by taking characters from certain "key up" events.  Note that=20
this stuff isn't documented anywhere I could find.  It's experimentally=20
determined on my Windows XP box.  I've verified that it doesn't help (but=20
doesn't make things worse) on Windows 95 (I don't see any keyboard events=20
that help here, other than interpreting the raw keystrokes directly).  I=20
haven't checked anywhere else.  (I don't have other systems readily=20
available.)  If you know where this is documented, please let me know.

I hope this patch is simple enough to not require paperwork.


2003-04-08  Bob Cassels <bcassels@abinitio.com>
        * fhandler_console.cc: In fhandler_console::read, handle
        certain key up events, to allow pasting accented characters
        and typing them using the "alt + numerics" sequences.



--=_mixed 006A074A85256D02_=
Content-Type: text/plain; name="accents-patch.txt"
Content-Disposition: attachment; filename="accents-patch.txt"
Content-Transfer-Encoding: base64
Content-length: 1871

SW5kZXg6IGN5Z3dpbi9maGFuZGxlcl9jb25zb2xlLmNjDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXJfY29uc29sZS5jYyx2DQpyZXRyaWV2aW5nIHJldmlz
aW9uIDEuMTA5DQpkaWZmIC11IC1wIC1yMS4xMDkgZmhhbmRsZXJfY29uc29s
ZS5jYw0KLS0tIGN5Z3dpbi9maGFuZGxlcl9jb25zb2xlLmNjCTIgQXByIDIw
MDMgMjM6MDE6MTEgLTAwMDAJMS4xMDkNCisrKyBjeWd3aW4vZmhhbmRsZXJf
Y29uc29sZS5jYwk4IEFwciAyMDAzIDE4OjQ4OjM1IC0wMDAwDQpAQCAtMzIx
LDEzICszMjEsMjYgQEAgZmhhbmRsZXJfY29uc29sZTo6cmVhZCAodm9pZCAq
cHYsIHNpemVfdA0KIAkgICAgICBicmVhazsNCiAJICAgIH0NCiANCi0JICBp
ZiAoIWlucHV0X3JlYy5FdmVudC5LZXlFdmVudC5iS2V5RG93bikNCi0JICAg
IGNvbnRpbnVlOw0KLQ0KICNkZWZpbmUgaWNoIChpbnB1dF9yZWMuRXZlbnQu
S2V5RXZlbnQudUNoYXIuQXNjaWlDaGFyKQ0KICNkZWZpbmUgd2NoIChpbnB1
dF9yZWMuRXZlbnQuS2V5RXZlbnQudUNoYXIuVW5pY29kZUNoYXIpDQogI2Rl
ZmluZSBBTFRfUFJFU1NFRCAoTEVGVF9BTFRfUFJFU1NFRCB8IFJJR0hUX0FM
VF9QUkVTU0VEKQ0KICNkZWZpbmUgQ1RSTF9QUkVTU0VEIChMRUZUX0NUUkxf
UFJFU1NFRCB8IFJJR0hUX0NUUkxfUFJFU1NFRCkNCisNCisJICAvKiANCisJ
ICAgICBJZ25vcmUga2V5IHVwIGV2ZW50cywgZXhjZXB0IGZvciBsZWZ0IGFs
dCBldmVudHMgd2l0aCBub24temVybyBjaGFyYWN0ZXINCisJICAgKi8NCisJ
ICBpZiAoIWlucHV0X3JlYy5FdmVudC5LZXlFdmVudC5iS2V5RG93biAmJg0K
KwkgICAgICAvKg0KKwkJRXZlbnQgZm9yIGxlZnQgYWx0LCB3aXRoIGEgbm9u
LXplcm8gY2hhcmFjdGVyLCBjb21lcyBmcm9tDQorCQkiYWx0ICsgbnVtZXJp
Y3MiIGtleSBzZXF1ZW5jZS4NCisJCWUuZy4gPGxlZnQtYWx0PiAwMjMzID0+
ICZlYWN1dGU7DQorCSAgICAgICovDQorCSAgICAgICEod2NoICE9IDAgJiYN
CisJCS8vID8/IGV4cGVyaW1lbnRhbGx5IGRldGVybWluZWQgb24gYW4gWFAg
c3lzdGVtDQorCQl2aXJ0dWFsX2tleV9jb2RlID09IFZLX01FTlUgJiYNCisJ
CS8vIGxlZnQgYWx0IC0tIHNlZSBodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20v
aHdkZXYvdGVjaC9pbnB1dC9TY2FuY29kZS5hc3ANCisJCWlucHV0X3JlYy5F
dmVudC5LZXlFdmVudC53VmlydHVhbFNjYW5Db2RlID09IDB4MzgpKQ0KKwkg
ICAgY29udGludWU7DQogDQogCSAgaWYgKHdjaCA9PSAwIHx8DQogCSAgICAg
IC8qIGFycm93L2Z1bmN0aW9uIGtleXMgKi8NCg==

--=_mixed 006A074A85256D02_=--
