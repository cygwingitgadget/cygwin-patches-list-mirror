Return-Path: <cygwin-patches-return-2335-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4927 invoked by alias); 6 Jun 2002 10:13:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4906 invoked from network); 6 Jun 2002 10:13:21 -0000
Date: Thu, 06 Jun 2002 03:13:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda  <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <13970794877.20020606141146@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: regtool support for remote registry
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------103C49C38112E52"
X-SW-Source: 2002-q2/txt/msg00318.txt.bz2

------------103C49C38112E52
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 239

Hi!

  Attached patch allows regtool to access registry on remote hosts,
e.g.:

regtool get \\bumba\machine\software\microsoft\windows\currentVersion\programFilesDir

egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
------------103C49C38112E52
Content-Type: application/octet-stream; name="regtool-remote-registry-support.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="regtool-remote-registry-support.diff"
Content-length: 2839

SW5kZXg6IHV0aWxzL3JlZ3Rvb2wuY2MKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQpSQ1MgZmlsZTogL2N2cy91YmVyYmF1bS93aW5zdXAvdXRpbHMvcmVndG9v
bC5jYyx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS45CmRpZmYgLXUgLXAgLTIg
LXIxLjkgcmVndG9vbC5jYwotLS0gdXRpbHMvcmVndG9vbC5jYwkzIEp1biAy
MDAyIDAyOjU3OjU1IC0wMDAwCTEuOQorKysgdXRpbHMvcmVndG9vbC5jYwk2
IEp1biAyMDAyIDEwOjA2OjAyIC0wMDAwCkBAIC01MSw0ICs1MSw1IEBAIGlu
dCBxdWlldCA9IDA7CiBjaGFyICoqYXJndjsKIAorY2hhciAqbWFjaGluZTsK
IEhLRVkga2V5OwogY2hhciAqdmFsdWU7CkBAIC05Miw4ICs5Myw5IEBAIHVz
YWdlIChGSUxFICp3aGVyZSA9IHN0ZGVycikKICAgaWYgKHdoZXJlID09IHN0
ZG91dCkKICAgICBmcHJpbnRmICh3aGVyZSwgIiIKLSAgICAiS0VZIGlzIGlu
IHRoZSBmb3JtYXQgXFxwcmVmaXhcXEtFWVxcS0VZXFxWQUxVRSwgd2hlcmUg
cHJlZml4IGlzIGFueSBvZjpcbiIKLSAgICAiICBcXHJvb3QgICAgIEhLQ1Ig
IEhLRVlfQ0xBU1NFU19ST09UXG4iCi0gICAgIiAgXFxjb25maWcgICBIS0ND
ICBIS0VZX0NVUlJFTlRfQ09ORklHXG4iCi0gICAgIiAgXFx1c2VyICAgICBI
S0NVICBIS0VZX0NVUlJFTlRfVVNFUlxuIgorICAgICJLRVkgaXMgaW4gdGhl
IGZvcm1hdCBbXFxcXGhvc3RdXFxwcmVmaXhcXEtFWVxcS0VZXFxWQUxVRSwg
d2hlcmUgaG9zdCBpcyBvcHRpb25hbFxuIgorICAgICJyZW1vdGUgaG9zdCBh
bmQgcHJlZml4IGlzIGFueSBvZjpcbiIKKyAgICAiICBcXHJvb3QgICAgIEhL
Q1IgIEhLRVlfQ0xBU1NFU19ST09UIChsb2NhbCBvbmx5KVxuIgorICAgICIg
IFxcY29uZmlnICAgSEtDQyAgSEtFWV9DVVJSRU5UX0NPTkZJRyAobG9jYWwg
b25seSlcbiIKKyAgICAiICBcXHVzZXIgICAgIEhLQ1UgIEhLRVlfQ1VSUkVO
VF9VU0VSIChsb2NhbCBvbmx5KVxuIgogICAgICIgIFxcbWFjaGluZSAgSEtM
TSAgSEtFWV9MT0NBTF9NQUNISU5FXG4iCiAgICAgIiAgXFx1c2VycyAgICBI
S1UgICBIS0VZX1VTRVJTXG4iCkBAIC0yNTIsMTAgKzI1NCwxNyBAQCB2b2lk
CiBmaW5kX2tleSAoaW50IGhvd21hbnlwYXJ0cywgUkVHU0FNIGFjY2VzcykK
IHsKKyAgSEtFWSBiYXNlOworICBpbnQgcnY7CiAgIGNoYXIgKm4gPSBhcmd2
WzBdLCAqZSwgYzsKICAgaW50IGk7CiAgIGlmICgqbiA9PSAnLycpCiAgICAg
dHJhbnNsYXRlIChuKTsKLSAgd2hpbGUgKCpuID09ICdcXCcpCisgIGlmIChu
WzBdID09ICdcXCcgJiYgblsxXSA9PSAnXFwnKQorICAgIHsKKyAgICAgIG1h
Y2hpbmUgPSBuOyBuICs9IDI7CisgICAgfQorICB3aGlsZSAoKm4gIT0gJ1xc
JykKICAgICBuKys7CisgICpuKysgPSAwOwogICBmb3IgKGUgPSBuOyAqZSAm
JiAqZSAhPSAnXFwnOyBlKyspOwogICBjID0gKmU7CkBAIC0yOTMsMTIgKzMw
MiwyMSBAQCBmaW5kX2tleSAoaW50IGhvd21hbnlwYXJ0cywgUkVHU0FNIGFj
Y2VzCiAJfQogICAgIH0KKyAgaWYgKG1hY2hpbmUpCisgICAgeworICAgICAg
cnYgPSBSZWdDb25uZWN0UmVnaXN0cnkgKG1hY2hpbmUsICB3a3ByZWZpeGVz
W2ldLmtleSwgJmJhc2UpOworICAgICAgaWYgKHJ2ICE9IEVSUk9SX1NVQ0NF
U1MpCisJRmFpbCAocnYpOworICAgIH0KKyAgZWxzZQorICAgIGJhc2UgPSB3
a3ByZWZpeGVzW2ldLmtleTsKKwogICBpZiAoblswXSA9PSAwKQorICAgIGtl
eSA9IGJhc2U7CisgIGVsc2UKICAgICB7Ci0gICAgICBrZXkgPSB3a3ByZWZp
eGVzW2ldLmtleTsKLSAgICAgIHJldHVybjsKKyAgICAgIHJ2ID0gUmVnT3Bl
bktleUV4IChiYXNlLCBuLCAwLCBhY2Nlc3MsICZrZXkpOworICAgICAgaWYg
KHJ2ICE9IEVSUk9SX1NVQ0NFU1MpCisJRmFpbCAocnYpOwogICAgIH0KLSAg
aW50IHJ2ID0gUmVnT3BlbktleUV4ICh3a3ByZWZpeGVzW2ldLmtleSwgbiwg
MCwgYWNjZXNzLCAma2V5KTsKLSAgaWYgKHJ2ICE9IEVSUk9SX1NVQ0NFU1Mp
Ci0gICAgRmFpbCAocnYpOwogICAvL3ByaW50Zigia2V5IGAlcycgdmFsdWUg
YCVzJ1xuIiwgbiwgdmFsdWUpOwogfQo=

------------103C49C38112E52
Content-Type: application/octet-stream; name="regtool-remote-registry-support.ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="regtool-remote-registry-support.ChangeLog"
Content-length: 175

MjAwMi0wNi0wNiAgRWdvciBEdWRhIDxkZW9AbG9nb3MtbS5ydT4KCgkqIHJl
Z3Rvb2wuY2MgKGZpbmRfa2V5KTogQWRkIHN1cHBvcnQgZm9yIHJlbW90ZSBy
ZWdpc3RyeSBhY2Nlc3MuCgkodXNhZ2UpOiBEb2N1bWVudCBpdC4K

------------103C49C38112E52--
