Return-Path: <cygwin-patches-return-4222-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7802 invoked by alias); 16 Sep 2003 19:58:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7781 invoked from network); 16 Sep 2003 19:58:55 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Tue, 16 Sep 2003 19:58:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: gethostid and GetDiskFreeSpaceEx on NT4
Message-ID: <Pine.GSO.4.56.0309161447260.685@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1215378052-1063742334=:685"
X-SW-Source: 2003-q3/txt/msg00238.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1215378052-1063742334=:685
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 432

The attached patch fixes the Cygwin testsuite failure I mentioned here:

http://www.cygwin.com/ml/cygwin-developers/2003-09/msg00019.html

2003-09-16  Brian Ford <ford@vss.fsi.com>

	* syscalls.cc (gethostid): GetDiskFreeSpaceEx call on NT4
	requires lpFreeBytesAvailable argument.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-1215378052-1063742334=:685
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="gethostid.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0309161458540.685@eos>
Content-Description: 
Content-Disposition: attachment; filename="gethostid.patch"
Content-length: 1233

SW5kZXg6IHN5c2NhbGxzLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vc3lzY2FsbHMu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjI4OQ0KZGlmZiAtdSAtcCAt
dSAtdyAtcCAtcjEuMjg5IHN5c2NhbGxzLmNjDQotLS0gc3lzY2FsbHMuY2MJ
MTYgU2VwIDIwMDMgMDA6NDU6NTAgLTAwMDAJMS4yODkNCisrKyBzeXNjYWxs
cy5jYwkxNiBTZXAgMjAwMyAxOTo0NjowMyAtMDAwMA0KQEAgLTI4ODQsNyAr
Mjg4NCwxMCBAQCBsb25nIGdldGhvc3RpZCh2b2lkKQ0KICAga2V5LmdldF9z
dHJpbmcgKCJQcm9kdWN0SWQiLCAoY2hhciAqKSZkYXRhWzZdLCAyNCwgIjAw
MDAwLTAwMC0wMDAwMDAwLTAwMDAwIik7DQogICBkZWJ1Z19wcmludGYgKCJX
aW5kb3dzIFByb2R1Y3QgSUQ6ICVzIiwgKGNoYXIgKikmZGF0YVs2XSk7DQog
DQotICBHZXREaXNrRnJlZVNwYWNlRXggKCJDOlxcIiwgTlVMTCwgKFBVTEFS
R0VfSU5URUdFUikgJmRhdGFbMTFdLCBOVUxMKTsNCisgIC8qIENvbnRyYXJ5
IHRvIE1TRE4sIE5UNCByZXF1aXJlcyB0aGUgc2Vjb25kIGFyZ3VtZW50DQor
ICAgICBvciBhIFNUQVRVU19BQ0NFU1NfVklPTEFUSU9OIGlzIGdlbmVyYXRl
ZCAqLw0KKyAgVUxBUkdFX0lOVEVHRVIgYXZhaWxiOw0KKyAgR2V0RGlza0Zy
ZWVTcGFjZUV4ICgiQzpcXCIsICZhdmFpbGIsIChQVUxBUkdFX0lOVEVHRVIp
ICZkYXRhWzExXSwgTlVMTCk7DQogICBpZiAoR2V0TGFzdEVycm9yICgpID09
IEVSUk9SX1BST0NfTk9UX0ZPVU5EKQ0KICAgICBHZXREaXNrRnJlZVNwYWNl
ICgiQzpcXCIsIE5VTEwsIE5VTEwsIE5VTEwsIChEV09SRCAqKSZkYXRhWzEx
XSk7DQogDQo=

---559023410-1215378052-1063742334=:685--
