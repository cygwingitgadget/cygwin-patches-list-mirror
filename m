Return-Path: <cygwin-patches-return-2394-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24039 invoked by alias); 12 Jun 2002 11:03:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23656 invoked from network); 12 Jun 2002 11:03:56 -0000
Date: Wed, 12 Jun 2002 04:03:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <63184716087.20020612150326@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: Need documentation for dumper.exe
In-Reply-To: <28181617301.20020612141147@logos-m.ru>
References: <20020611145443.GA352@redhat.com>
 <28181617301.20020612141147@logos-m.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------251831DB2D349EB0"
X-SW-Source: 2002-q2/txt/msg00377.txt.bz2

------------251831DB2D349EB0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 421

Hi!

ed> Tuesday, 11 June, 2002 Christopher Faylor cgf@redhat.com wrote:

CF>> I just noticed that dumper.exe is not documented in utils.sgml.

CF>> Is anyone interested in taking a stab at it?  There should be lots of
CF>> info in the mailing list archives.

Patch attached. Can anybody with sgml tools installed please check if
formatting is ok?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
------------251831DB2D349EB0
Content-Type: application/octet-stream; name="dumper-docs.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dumper-docs.diff"
Content-length: 3116

SW5kZXg6IHdpbnN1cC91dGlscy91dGlscy5zZ21sCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvdWJlcmJhdW0vd2luc3VwL3V0aWxz
L3V0aWxzLnNnbWwsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjUKZGlmZiAt
dSAtcCAtMiAtcjEuMjUgdXRpbHMuc2dtbAotLS0gd2luc3VwL3V0aWxzL3V0
aWxzLnNnbWwJNyBKdW4gMjAwMiAxOToyNToyNiAtMDAwMAkxLjI1CisrKyB3
aW5zdXAvdXRpbHMvdXRpbHMuc2dtbAkxMiBKdW4gMjAwMiAxMDo1ODo1MCAt
MDAwMApAQCAtNzY2LDQgKzc2Niw1MCBAQCBwcmludCB0aGUgbWVzc2FnZSBi
dXQgZG9lcyByZXR1cm4gdGhlIG5vCiA8L3NlY3QyPgogCis8c2VjdDIgaWQ9
ImR1bXBlciI+PHRpdGxlPmR1bXBlcjwvdGl0bGU+CisKKzxzY3JlZW4+CitV
c2FnZTogZHVtcGVyIFtPUFRJT05dIEZJTEVOQU1FIFdJTjMyUElECitEdW1w
IGNvcmUgZnJvbSBXSU4zMlBJRCB0byBGSUxFTkFNRS5jb3JlCisgLWQsIC0t
dmVyYm9zZSAgYmUgdmVyYm9zZSB3aGlsZSBkdW1waW5nCisgLWgsIC0taGVs
cCAgICAgb3V0cHV0IGhlbHAgaW5mb3JtYXRpb24gYW5kIGV4aXQKKyAtcSwg
LS1xdWlldCAgICBiZSBxdWlldCB3aGlsZSBkdW1waW5nIChkZWZhdWx0KQor
IC12LCAtLXZlcnNpb24gIG91dHB1dCB2ZXJzaW9uIGluZm9ybWF0aW9uIGFu
ZCBleGl0Cis8L3NjcmVlbj4KKworPHBhcmE+VGhlIDxjb21tYW5kPmR1bXBl
cjwvY29tbWFuZD4gdXRpbGl0eSBjYW4gYmUgdXNlZCB0byBjcmVhdGUKK2Nv
cmUgZHVtcCBvZiBydW5uaW5nIHdpbmRvd3MgcHJvY2Vzcy4gVGhpcyBjb3Jl
IGR1bXAgY2FuIGJlIGxhdGVyIGxvYWRlZAordG8gZ2RiIGFuIGFuYWx5emVk
LiBPbmUgY29tbW9uIHdheSB0byB1c2UgPGNvbW1hbmQ+ZHVtcGVyPC9jb21t
YW5kPiBpcyB0bworcGx1ZyBpdCBpbnRvIGN5Z3dpbidzIEp1c3QtSW4tVGlt
ZSBkZWJ1Z2dpbmcgZmFjaWxpdHkgYnkgYWRkaW5nCisKKzxzY3JlZW4+Citl
cnJvcl9zdGFydD14OlxwYXRoXHRvXGR1bXBlci5leGUKKzwvc2NyZWVuPgor
Cit0byA8ZW0+Q1lHV0lOPC9lbT4gZW52aXJvbm1lbnQgdmFyaWFibGUuIFBs
ZWFzZSBub3RlIHRoYXQKKzxsaXRlcmFsPng6XHBhdGhcdG9cZHVtcGVyLmV4
ZTwvbGl0ZXJhbD4gaXMgd2luMzItc3R5bGUgYW5kIG5vdCBjeWd3aW4KK3Bh
dGguIElmIDxsaXRlcmFsPmVycm9yX3N0YXJ0PC9saXRlcmFsPiBpcyBzZXQg
dGhpcyB3YXksIHRoZW4gZHVtcGVyIHdpbGwKK2JlIHN0YXJ0ZWQgd2hlbmV2
ZXIgc29tZSBwcm9ncmFtIGVuY291bnRlcnMgZmF0YWwgZXJyb3IuCis8L3Bh
cmE+CisKKzxwYXJhPgorPGNvbW1hbmQ+ZHVtcGVyPC9jb21tYW5kPiBjYW4g
YmUgYWxzbyBiZSBzdGFydGVkIGZyb20gY29tbWFuZCBsaW5lIHRvIGNyZWF0
ZQorY29yZSBkdW1wIG9mIGFueSBydW5uaW5nIHByb2Nlc3MuIFVuZm9ydHVu
YXRlbHksIGJlY2F1c2Ugb2Ygd2luZG93cyBBUEkKK2xpbWl0YXRpb24sIHdo
ZW4gY29yZSBkdW1wIGlzIGNyZWF0ZWQgYW5kIDxjb21tYW5kPmR1bXBlcjwv
Y29tbWFuZD4gZXhpdHMsCit0aGUgdGFyZ2V0IHByb2Nlc3MgaXMgdGVybWlu
YXRlZCB0b28uCis8L3BhcmE+CisKKzxwYXJhPgorVG8gc2F2ZSB0aGUgc3Bh
Y2UgaW4gY29yZSBkdW1wLCA8Y29tbWFuZD5kdW1wZXI8L2NvbW1hbmQ+IGRv
ZXNuJ3Qgd3JpdGUgdGhvc2UKK3BvcnRpb25zIG9mIHRhcmdldCBwcm9jZXNz
JyBtZW1vcnkgc3BhY2UgdGhhdCBhcmUgbG9hZGVkIGZyb20gZXhlY3V0YWJs
ZSBhbmQKK2RsbCBmaWxlcyBhbmQgYXJlIHVuY2hhbmdlYWJsZSwgc3VjaCBh
cyBwcm9ncmFtIGNvZGUgYW5kIGRlYnVnIGluZm8uIEluc3RlYWQsCis8Y29t
bWFuZD5kdW1wZXI8L2NvbW1hbmQ+IHNhdmVzIHBhdGhzIHRvIGZpbGVzIHdo
aWNoIGNvbnRhaW4gdGhhdCBkYXRhLiBXaGVuCitjb3JlIGR1bXAgaXMgbG9h
ZGVkIGludG8gZ2RiLCBpdCB1c2VzIHRoZXNlIHBhdGhzIHRvIGxvYWQgYXBw
cm9wcmlhdGUgZmlsZXMuCitUaGF0IG1lYW5zIHRoYXQgaWYgeW91IGNyZWF0
ZSBjb3JlIGR1bXAgb24gb25lIG1hY2hpbmUgYW5kIHRyeSB0byBkZWJ1ZyBp
dCBvbgorb3RoZXIsIHlvdSdsbCBuZWVkIHRvIHBsYWNlIGlkZW50aWNhbCBj
b3BpZXMgb2YgZXhlY3V0YWJsZSBhbmQgZGxscyBpbiB0aGUgc2FtZQorZGly
ZWN0b3JpZXMgYXMgb24gbWFjaGluZSB3aGVyZSBjb3JlIGR1bXAgaGFzIGJl
ZW4gY3JlYXRlZC4KKzwvcGFyYT4KKworPC9zZWN0Mj4KKwogPC9zZWN0MT4K
IAo=

------------251831DB2D349EB0
Content-Type: application/octet-stream; name="dumper-docs.ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dumper-docs.ChangeLog"
Content-length: 110

MjAwMi0wNi0xMiAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiB1
dGlscy5zZ21sOiBBZGQgc2VjdGlvbiBmb3IgZHVtcGVyLgo=

------------251831DB2D349EB0--
