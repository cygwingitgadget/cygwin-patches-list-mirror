Return-Path: <cygwin-patches-return-3236-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11741 invoked by alias); 26 Nov 2002 10:51:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11701 invoked from network); 26 Nov 2002 10:51:34 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 26 Nov 2002 02:51:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Remove libstdc++ from cygwin1.dll build
Message-ID: <Pine.WNT.4.44.0211261130120.304-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1279655-7869-1038307877=:304"
X-SW-Source: 2002-q4/txt/msg00187.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1279655-7869-1038307877=:304
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1032


I had some problems building the cygwin1.dll after i changed gcc to use
sjlj exceptions. The resulting dll was unusable.

I have discovered that this is due to the fact that cygwin1 is linked
against libstdc++. The only reasons why cygwin1 is linked against stdc++
are the operators new and delete and __cxa_pure_virtual.

IMHO this is not acceptable because the new and new[] operators will throw
exceptions if the memory allocation has failed. C programs will terminate
via abort because the exception is not caught, C++ programs might behave
unpredictable.

A possible solution might be to use the nothrow new operators, i think
that the cleanest way is to define own operators. As a side effect the
cygwin1 dll can be build with an sjlj gcc and the dll is
significantly smaller.

Thomas

2002-11-26  Thomas Pfaff  <tpfaff@gmx.net>

	* cxx.cc: New file. Implement new, new[], delete and delete[]
	operators. Implement  __cxa_pure_virtual.
	* Makefile.in (DLL_OFILES): Add cxx.o.
	Remove libstdc++.a from cygwin1.dll link step.


--1279655-7869-1038307877=:304
Content-Type: TEXT/plain; name="cxx.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0211261151170.304@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="cxx.patch"
Content-length: 2798

ZGlmZiAtdXJwTiBzcmMub2xkL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuaW4g
c3JjL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuaW4KLS0tIHNyYy5vbGQvd2lu
c3VwL2N5Z3dpbi9NYWtlZmlsZS5pbgkyMDAyLTEwLTIxIDAzOjAzOjMyLjAw
MDAwMDAwMCArMDIwMAorKysgc3JjL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUu
aW4JMjAwMi0xMS0yNiAxMTowOTozOC4wMDAwMDAwMDAgKzAxMDAKQEAgLTEy
NCw3ICsxMjQsNyBAQCBNQUxMT0NfT0ZJTEVTPUBNQUxMT0NfT0ZJTEVTQAog
RExMX0lNUE9SVFM6PSQodzMyYXBpX2xpYikvbGlia2VybmVsMzIuYQogCiAj
IFBsZWFzZSBtYWludGFpbiB0aGlzIGxpc3QgaW4gc29ydGVkIG9yZGVyLCB3
aXRoIG1heGltdW0gZmlsZXMgcGVyIDgwIGNvbCBsaW5lCi1ETExfT0ZJTEVT
Oj1hc3NlcnQubyBhdXRvbG9hZC5vIGN5Z2hlYXAubyBjeWdzZXJ2ZXJfY2xp
ZW50Lm8gXAorRExMX09GSUxFUzo9YXNzZXJ0Lm8gYXV0b2xvYWQubyBjeHgu
byBjeWdoZWFwLm8gY3lnc2VydmVyX2NsaWVudC5vIFwKIAljeWdzZXJ2ZXJf
dHJhbnNwb3J0Lm8gY3lnc2VydmVyX3RyYW5zcG9ydF9waXBlcy5vIFwKIAlj
eWdzZXJ2ZXJfdHJhbnNwb3J0X3NvY2tldHMubyBjeWd0aHJlYWQubyBkY3J0
MC5vIGRlYnVnLm8gXAogCWRlbHF1ZXVlLm8gZGlyLm8gZGxmY24ubyBkbGxf
aW5pdC5vIGR0YWJsZS5vIGVudmlyb24ubyBlcnJuby5vIFwKQEAgLTI2Myw3
ICsyNjMsNyBAQCBtYWludGFpbmVyLWNsZWFuIHJlYWxjbGVhbjogY2xlYW4K
IG5ldy0kKERMTF9OQU1FKTogJChMRFNDUklQVCkgJChETExfT0ZJTEVTKSAk
KERFRl9GSUxFKSAkKERMTF9JTVBPUlRTKSAkKExJQkMpICQoTElCTSkgJChB
UElfVkVSKSBNYWtlZmlsZSB3aW52ZXJfc3RhbXAKIAkkKENYWCkgJChDWFhG
TEFHUykgLW5vc3RkbGliIC1XbCwtVCQoZmlyc3R3b3JkICReKSAtV2wsLS1v
dXQtaW1wbGliLGN5Z2RsbC5hIC1zaGFyZWQgLW8gJEAgXAogCS1lICQoRExM
X0VOVFJZKSAkKERFRl9GSUxFKSAkKERMTF9PRklMRVMpIHZlcnNpb24ubyB3
aW52ZXIubyBcCi0JJChNQUxMT0NfT0JKKSAkKExJQk0pIC1sc3RkYysrICQo
TElCQykgXAorCSQoTUFMTE9DX09CSikgJChMSUJNKSAkKExJQkMpIFwKIAkt
bGdjYyAkKERMTF9JTVBPUlRTKQogCiAjIFJ1bGUgdG8gYnVpbGQgbGliY3ln
d2luLmEKZGlmZiAtdXJwTiBzcmMub2xkL3dpbnN1cC9jeWd3aW4vY3h4LmNj
IHNyYy93aW5zdXAvY3lnd2luL2N4eC5jYwotLS0gc3JjLm9sZC93aW5zdXAv
Y3lnd2luL2N4eC5jYwkxOTcwLTAxLTAxIDAxOjAwOjAwLjAwMDAwMDAwMCAr
MDEwMAorKysgc3JjL3dpbnN1cC9jeWd3aW4vY3h4LmNjCTIwMDItMTEtMjYg
MTE6Mjg6MzIuMDAwMDAwMDAwICswMTAwCkBAIC0wLDAgKzEsNDUgQEAKKy8q
IGN4eC5jYworCisgICBDb3B5cmlnaHQgMjAwMiBSZWQgSGF0LCBJbmMuCisK
K1RoaXMgZmlsZSBpcyBwYXJ0IG9mIEN5Z3dpbi4KKworVGhpcyBzb2Z0d2Fy
ZSBpcyBhIGNvcHlyaWdodGVkIHdvcmsgbGljZW5zZWQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZQorQ3lnd2luIGxpY2Vuc2UuICBQbGVhc2UgY29uc3VsdCB0
aGUgZmlsZSAiQ1lHV0lOX0xJQ0VOU0UiIGZvcgorZGV0YWlscy4gKi8KKwor
I2luY2x1ZGUgIndpbnN1cC5oIgorI2luY2x1ZGUgPHN0ZGxpYi5oPgorCit2
b2lkICoKK29wZXJhdG9yIG5ldyAoc2l6ZV90IHMpCit7CisgIHZvaWQgKnAg
PSBtYWxsb2MgKHMpOworICBpZiAocCkKKyAgICBtZW1zZXQgKHAsMCxzKTsK
KyAgcmV0dXJuIHA7Cit9CisKK3ZvaWQKK29wZXJhdG9yIGRlbGV0ZSAodm9p
ZCAqcCkKK3sKKyAgZnJlZSAocCk7Cit9CisKK3ZvaWQgKgorb3BlcmF0b3Ig
bmV3W10gKHNpemVfdCBzKQoreworICByZXR1cm4gOjpvcGVyYXRvciBuZXcg
KHMpOworfQorCit2b2lkCitvcGVyYXRvciBkZWxldGVbXSAodm9pZCAqcCkK
K3sKKyAgOjpvcGVyYXRvciBkZWxldGUgKHApOworfQorCitleHRlcm4gIkMi
IHZvaWQKK19fY3hhX3B1cmVfdmlydHVhbCAodm9pZCkKK3sKKyAgYXBpX2Zh
dGFsICgicHVyZSB2aXJ0dWFsIG1ldGhvZCBjYWxsZWQiKTsKK30K

--1279655-7869-1038307877=:304--
