Return-Path: <cygwin-patches-return-3240-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7977 invoked by alias); 29 Nov 2002 08:19:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7968 invoked from network); 29 Nov 2002 08:19:52 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 29 Nov 2002 00:19:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Remove libstdc++ from cygwin1.dll build
In-Reply-To: <Pine.WNT.4.44.0211261130120.304-200000@algeria.intern.net>
Message-ID: <Pine.WNT.4.44.0211290900020.301-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1195410-5361-1038557968=:301"
X-SW-Source: 2002-q4/txt/msg00191.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1195410-5361-1038557968=:301
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1900


I have changed cxx.cc a bit because it is only needed when the dll is
build via gcc3. gcc2 does not need libstdc++ at all because the
operators are contained in libgcc.

BTW, if someone is interested why better use sjlj instead of dwarf2
exceptions there is actually a thread on the mingw users mailing list
called "DLLs and Exceptions" discussing the pros and cons of sjlj and
dwarf2.

Whatever exception type is preferred by the cygwin gcc package i do not
think that the cygwin1.dll should ever throw an exception.

2002-11-26  Thomas Pfaff  <tpfaff@gmx.net>

	* cxx.cc: New file. Implement new, new[], delete and delete[]
	operators and  __cxa_pure_virtual if compiled by gcc >=3.
	* Makefile.in (DLL_OFILES): Add cxx.o.
	Remove libstdc++.a from cygwin1.dll link step.


On Tue, 26 Nov 2002, Thomas Pfaff wrote:

>
> I had some problems building the cygwin1.dll after i changed gcc to use
> sjlj exceptions. The resulting dll was unusable.
>
> I have discovered that this is due to the fact that cygwin1 is linked
> against libstdc++. The only reasons why cygwin1 is linked against stdc++
> are the operators new and delete and __cxa_pure_virtual.
>
> IMHO this is not acceptable because the new and new[] operators will throw
> exceptions if the memory allocation has failed. C programs will terminate
> via abort because the exception is not caught, C++ programs might behave
> unpredictable.
>
> A possible solution might be to use the nothrow new operators, i think
> that the cleanest way is to define own operators. As a side effect the
> cygwin1 dll can be build with an sjlj gcc and the dll is
> significantly smaller.
>
> Thomas
>
> 2002-11-26  Thomas Pfaff  <tpfaff@gmx.net>
>
> 	* cxx.cc: New file. Implement new, new[], delete and delete[]
> 	operators. Implement  __cxa_pure_virtual.
> 	* Makefile.in (DLL_OFILES): Add cxx.o.
> 	Remove libstdc++.a from cygwin1.dll link step.
>
>
>

--1195410-5361-1038557968=:301
Content-Type: TEXT/plain; name="cxx.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0211290919280.301@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="cxx.patch"
Content-length: 2843

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
MDEwMAorKysgc3JjL3dpbnN1cC9jeWd3aW4vY3h4LmNjCTIwMDItMTEtMjgg
MTc6MDM6NDAuMDAwMDAwMDAwICswMTAwCkBAIC0wLDAgKzEsNDkgQEAKKy8q
IGN4eC5jYworCisgICBDb3B5cmlnaHQgMjAwMiBSZWQgSGF0LCBJbmMuCisK
K1RoaXMgZmlsZSBpcyBwYXJ0IG9mIEN5Z3dpbi4KKworVGhpcyBzb2Z0d2Fy
ZSBpcyBhIGNvcHlyaWdodGVkIHdvcmsgbGljZW5zZWQgdW5kZXIgdGhlIHRl
cm1zIG9mIHRoZQorQ3lnd2luIGxpY2Vuc2UuICBQbGVhc2UgY29uc3VsdCB0
aGUgZmlsZSAiQ1lHV0lOX0xJQ0VOU0UiIGZvcgorZGV0YWlscy4gKi8KKwor
I2lmIChfX0dOVUNfXyA+PSAzKQorCisjaW5jbHVkZSAid2luc3VwLmgiCisj
aW5jbHVkZSA8c3RkbGliLmg+CisKK3ZvaWQgKgorb3BlcmF0b3IgbmV3IChz
aXplX3QgcykKK3sKKyAgdm9pZCAqcCA9IG1hbGxvYyAocyk7CisgIGlmIChw
KQorICAgIG1lbXNldCAocCwwLHMpOworICByZXR1cm4gcDsKK30KKwordm9p
ZAorb3BlcmF0b3IgZGVsZXRlICh2b2lkICpwKQoreworICBmcmVlIChwKTsK
K30KKwordm9pZCAqCitvcGVyYXRvciBuZXdbXSAoc2l6ZV90IHMpCit7Cisg
IHJldHVybiA6Om9wZXJhdG9yIG5ldyAocyk7Cit9CisKK3ZvaWQKK29wZXJh
dG9yIGRlbGV0ZVtdICh2b2lkICpwKQoreworICA6Om9wZXJhdG9yIGRlbGV0
ZSAocCk7Cit9CisKK2V4dGVybiAiQyIgdm9pZAorX19jeGFfcHVyZV92aXJ0
dWFsICh2b2lkKQoreworICBhcGlfZmF0YWwgKCJwdXJlIHZpcnR1YWwgbWV0
aG9kIGNhbGxlZCIpOworfQorCisjZW5kaWYK

--1195410-5361-1038557968=:301--
