Return-Path: <cygwin-patches-return-5293-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14044 invoked by alias); 31 Dec 2004 13:58:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14011 invoked from network); 31 Dec 2004 13:58:23 -0000
Received: from unknown (HELO cs1.cs.huji.ac.il) (132.65.16.10)
  by sourceware.org with SMTP; 31 Dec 2004 13:58:23 -0000
Received: from inferno-01.cs.huji.ac.il ([132.65.32.101])
	by cs1.cs.huji.ac.il with esmtp
	id 1CkNIK-000MnM-Ci
	for cygwin-patches@cygwin.com; Fri, 31 Dec 2004 15:58:20 +0200
Received: from arielez by inferno-01.cs.huji.ac.il with local (Exim 3.36 #1)
	id 1CkNIK-0005Ma-00
	for cygwin-patches@cygwin.com; Fri, 31 Dec 2004 15:58:20 +0200
Date: Fri, 31 Dec 2004 13:58:00 -0000
From: Eizenberg Ariel <arielez@cs.huji.ac.il>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Large processes shared.cc fix
Message-ID: <Pine.LNX.4.56.0412311549120.20233@inferno-01.cs.huji.ac.il>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1099195680-676868883-1104501500=:20233"
X-SW-Source: 2004-q4/txt/msg00294.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1099195680-676868883-1104501500=:20233
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1133

Hi,

This patch fixes a problem I have with running large fortran programs
(actually most programs with a very large image size in memory). The
problem occurs on Windows 2000, XP and 2003.

The problem occurs when a process is large enough so when open_shared()
tries to map the shared memory section to 0x0A000000, it fails, since
0x0A000000 is occupied by the program. Since the
MapViewOfFileEx(h,...,NULL) is preformed on a region smaller than the full
region required for offsets[SH_TOTAL_SIZE], MapViewOfFileEx might allocate
a region at a location which does not have enough free space after it,
so the VirtualAlloc's at the end of open_shared() silently fail
(in my case MapViewOfFileEx() returns 0x3d0000).

The patch fixed the problem by looking for a region large enough for
offsets[SH_TOTAL_SIZE], and using this region as the base address for
offsets[0] instead.

I would greatly appreciate if you could integrate this patch into
mainstream Cygwin.

The `cvs diff -up` patch is attached as TEXT/PLAIN.

The ChangeLog entry is:

* shared.cc (open_shared): Fix allocation of shared region for large
processes.

Thanks.





--1099195680-676868883-1104501500=:20233
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="shared.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.56.0412311558200.20233@inferno-01.cs.huji.ac.il>
Content-Description: 
Content-Disposition: attachment; filename="shared.cc.patch"
Content-length: 2619

SW5kZXg6IHNoYXJlZC5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3NoYXJlZC5jYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuODQNCmRpZmYgLXUgLXAgLXIxLjg0
IHNoYXJlZC5jYw0KLS0tIHNoYXJlZC5jYwkzIERlYyAyMDA0IDAyOjAwOjM3
IC0wMDAwCTEuODQNCisrKyBzaGFyZWQuY2MJMzEgRGVjIDIwMDQgMTI6Mzk6
MDAgLTAwMDANCkBAIC0xMDMsNiArMTAzLDUzIEBAIG9wZW5fc2hhcmVkIChj
b25zdCBjaGFyICpuYW1lLCBpbnQgbiwgSEENCiAJYXBpX2ZhdGFsICgiQ3Jl
YXRlRmlsZU1hcHBpbmcgJXMsICVFLiAgVGVybWluYXRpbmcuIiwgbWFwbmFt
ZSk7DQogICAgIH0NCiANCisgIGlmIChtID09IFNIX0NZR1dJTl9TSEFSRUQg
JiYgd2luY2FwLm5lZWRzX21lbW9yeV9wcm90ZWN0aW9uICgpKQ0KKyAgew0K
KwkgLy8gYXJpZWxfZTogd2UgbmVlZCB0byBtYWtlIHN1cmUgd2UgaGF2ZSBl
bm91Z2ggc3BhY2UgdG8gcmVzZXJ2ZSANCisJIC8vICh3aXRoIFZpcnR1YWxB
bGxvYyhNRU1fUkVTRVJWRSkgYWZ0ZXIgJ3NoYXJlZCcsIHNvIHdlIA0KKwkg
Ly8gYXNrIGZvciBhIG1lbW9yeSBsb2NhdGlvbiBsYXJnZSBlbm91Z2ggdG8g
aG9sZCBhbGwNCisJIC8vIHNoYXJlZCBkYXRhLiBBZnRlciB3ZSBnZXQgYSB2
YWxpZCBsb2NhdGlvbiwNCisJIC8vIHdlIHVubWFwIGl0IGFuZCB0cnkgdG8g
bWFwIG9ubHkgdGhlIGFjdHVhbCBhbW91bnQgY3VycmVudGx5IA0KKwkgLy8g
cmVxdWlyZWQNCisJIA0KKwkgRFdPUkQgc2l6ZV9uZWVkZWQgPSBvZmZzZXRz
W1NIX1RPVEFMX1NJWkVdIC0gb2Zmc2V0c1swXTsNCisJIHZvaWQqIG9sZF9h
ZGRyID0gYWRkcjsNCisNCisJIEhBTkRMRSB0bXBfbWFwID0gQ3JlYXRlRmls
ZU1hcHBpbmcoSU5WQUxJRF9IQU5ETEVfVkFMVUUsDQorCQkJIAkJTlVMTCwg
Ly8gYXR0cmlidXRlcyANCisJCQkJCVBBR0VfUkVBRFdSSVRFIHwgU0VDX1JF
U0VSVkUsDQorCQkJCQkwLCAvLyBtYXggc2l6ZSBoaWdoLA0KKwkJCQkJc2l6
ZV9uZWVkZWQsDQorCQkJCQlOVUxMKTsNCisNCisJIGlmKHRtcF9tYXAgPT0g
TlVMTCkNCisJCWFwaV9mYXRhbCgiRmFpbGVkIHRvIHJlc2VydmUgbWVtb3J5
OiAlRVxuIik7DQorDQorCSBhZGRyID0gTWFwVmlld09mRmlsZUV4ICh0bXBf
bWFwLCBGSUxFX01BUF9SRUFEIHwgRklMRV9NQVBfV1JJVEUsIA0KKwkJCQkg
MCwgMCwgMCwgYWRkcik7DQorDQorCSBpZihhZGRyID09IE5VTEwpDQorCSB7
DQorCQkvLyB0cnkgYWdhaW4gd2l0aG91dCBhIHByZWRldGVybWluZWQgYWRk
cmVzcw0KKyAgICAJCWFkZHIgPSBNYXBWaWV3T2ZGaWxlRXggKHRtcF9tYXAs
IA0KKwkJCQkJRklMRV9NQVBfUkVBRCB8IEZJTEVfTUFQX1dSSVRFLCANCisJ
CQkJCTAsIDAsIDAsIE5VTEwpOw0KKw0KKwkJaWYoYWRkciA9PSBOVUxMKQ0K
KwkJew0KKwkJCS8vIGZhaWxlZCB0byByZXNlcnZlIG1lbW9yeSwgdG8gbWFp
bnRhaW4gb2xkIA0KKwkJCS8vIGNvbXBhdGliaWxpdHkgd2UgdXNlIG9yaWdp
bmFsIGFkZHINCisJCQlhZGRyID0gb2xkX2FkZHI7DQorCQl9DQorCSB9DQor
DQorCVVubWFwVmlld09mRmlsZShhZGRyKTsNCisJQ2xvc2VIYW5kbGUodG1w
X21hcCk7DQorDQorCS8vIG5vdyB3ZSBhcmUgcmVhZHkgdG8gbWFwIHRoZSBh
Y3R1YWwgcmVxdWlyZWQgYW1vdW50IG9mIG1lbW9yeQ0KKwkvLyBhdCB0aGUg
YWRkcmVzcyB3ZSBrbm93IGhhcyBlbm91Z2ggZnJlZSBzcGFjZSBmb3IgZXZl
cnl0aGluZw0KKyAgfQ0KKw0KICAgc2hhcmVkID0gKHNoYXJlZF9pbmZvICop
DQogICAgIE1hcFZpZXdPZkZpbGVFeCAoc2hhcmVkX2gsIEZJTEVfTUFQX1JF
QUQgfCBGSUxFX01BUF9XUklURSwgMCwgMCwgMCwgYWRkcik7DQogDQo=

--1099195680-676868883-1104501500=:20233--
