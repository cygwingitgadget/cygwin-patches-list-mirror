Return-Path: <cygwin-patches-return-3750-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29899 invoked by alias); 26 Mar 2003 23:04:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29890 invoked from network); 26 Mar 2003 23:04:22 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Wed, 26 Mar 2003 23:04:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: [PATCH] Trivial pthread testsuite fixes
Message-ID: <Pine.GSO.4.44.0303261659310.29553-200000@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-126398554-1048119469=:6272"
Content-ID: <Pine.GSO.4.44.0303261547321.29553@eos>
X-SW-Source: 2003-q1/txt/msg00399.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-126398554-1048119469=:6272
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0303261547322.29553@eos>
Content-length: 592

Redirected to here from cygwin@cygwin.com since I now have posting
privileges.  Thanks Elfyn McBratney.

2003-03-26  Brian Ford  <ford@vss.fsi.com>

	* winsup.api/pthread/condvar7.c (mythread): Cast pthread_mutex_unlock
	argument of pthread_cleanup_push to void *, preventing a compiler
	warning / testsuite failure.
	* winsup.api/pthread/condvar9.c (mythread): Likewise.
	* winsup.api/pthread/rwlock7.c (main): Use ftime instead of _ftime.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444

---559023410-126398554-1048119469=:6272
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="winsup.api.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0303261559430.29553@eos>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="winsup.api.patch"
Content-length: 3246

SW5kZXg6IHdpbnN1cC5hcGkvcHRocmVhZC9jb25kdmFyNy5jDQo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1
cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhyZWFkL2NvbmR2YXI3LmMsdg0K
cmV0cmlldmluZyByZXZpc2lvbiAxLjENCmRpZmYgLXUgLXAgLXIxLjEgY29u
ZHZhcjcuYw0KLS0tIHdpbnN1cC5hcGkvcHRocmVhZC9jb25kdmFyNy5jCTE4
IE1hciAyMDAzIDE5OjUxOjU4IC0wMDAwCTEuMQ0KKysrIHdpbnN1cC5hcGkv
cHRocmVhZC9jb25kdmFyNy5jCTI2IE1hciAyMDAzIDIxOjQ1OjQ3IC0wMDAw
DQpAQCAtOTcsNyArOTcsNyBAQCBteXRocmVhZCh2b2lkICogYXJnKQ0KICNp
ZmRlZiBfTVNDX1ZFUg0KICNwcmFnbWEgaW5saW5lX2RlcHRoKDApDQogI2Vu
ZGlmDQotICBwdGhyZWFkX2NsZWFudXBfcHVzaChwdGhyZWFkX211dGV4X3Vu
bG9jaywgKHZvaWQgKikgJmN2dGhpbmcubG9jayk7DQorICBwdGhyZWFkX2Ns
ZWFudXBfcHVzaCgodm9pZCAqKSBwdGhyZWFkX211dGV4X3VubG9jaywgKHZv
aWQgKikgJmN2dGhpbmcubG9jayk7DQogDQogICB3aGlsZSAoISAoY3Z0aGlu
Zy5zaGFyZWQgPiAwKSkNCiAgICAgYXNzZXJ0KHB0aHJlYWRfY29uZF90aW1l
ZHdhaXQoJmN2dGhpbmcubm90YnVzeSwgJmN2dGhpbmcubG9jaywgJmFic3Rp
bWUpID09IDApOw0KSW5kZXg6IHdpbnN1cC5hcGkvcHRocmVhZC9jb25kdmFy
OS5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9z
cmMvc3JjL3dpbnN1cC90ZXN0c3VpdGUvd2luc3VwLmFwaS9wdGhyZWFkL2Nv
bmR2YXI5LmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjENCmRpZmYgLXUg
LXAgLXIxLjEgY29uZHZhcjkuYw0KLS0tIHdpbnN1cC5hcGkvcHRocmVhZC9j
b25kdmFyOS5jCTE4IE1hciAyMDAzIDE5OjUxOjU4IC0wMDAwCTEuMQ0KKysr
IHdpbnN1cC5hcGkvcHRocmVhZC9jb25kdmFyOS5jCTI2IE1hciAyMDAzIDIx
OjQ1OjQ3IC0wMDAwDQpAQCAtMTAyLDcgKzEwMiw3IEBAIG15dGhyZWFkKHZv
aWQgKiBhcmcpDQogI2lmZGVmIF9NU0NfVkVSDQogI3ByYWdtYSBpbmxpbmVf
ZGVwdGgoMCkNCiAjZW5kaWYNCi0gIHB0aHJlYWRfY2xlYW51cF9wdXNoKHB0
aHJlYWRfbXV0ZXhfdW5sb2NrLCAodm9pZCAqKSAmY3Z0aGluZy5sb2NrKTsN
CisgIHB0aHJlYWRfY2xlYW51cF9wdXNoKCh2b2lkICopIHB0aHJlYWRfbXV0
ZXhfdW5sb2NrLCAodm9pZCAqKSAmY3Z0aGluZy5sb2NrKTsNCiANCiAgIHdo
aWxlICghIChjdnRoaW5nLnNoYXJlZCA+IDApKQ0KICAgICBhc3NlcnQocHRo
cmVhZF9jb25kX3RpbWVkd2FpdCgmY3Z0aGluZy5ub3RidXN5LCAmY3Z0aGlu
Zy5sb2NrLCAmYWJzdGltZSkgPT0gMCk7DQpJbmRleDogd2luc3VwLmFwaS9w
dGhyZWFkL3J3bG9jazcuYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvdGVzdHN1aXRlL3dpbnN1cC5h
cGkvcHRocmVhZC9yd2xvY2s3LmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAx
LjENCmRpZmYgLXUgLXAgLXIxLjEgcndsb2NrNy5jDQotLS0gd2luc3VwLmFw
aS9wdGhyZWFkL3J3bG9jazcuYwkxOCBNYXIgMjAwMyAyMDowNDoyNCAtMDAw
MAkxLjENCisrKyB3aW5zdXAuYXBpL3B0aHJlYWQvcndsb2NrNy5jCTI2IE1h
ciAyMDAzIDIxOjQ1OjQ3IC0wMDAwDQpAQCAtMTMxLDcgKzEzMSw3IEBAIG1h
aW4gKGludCBhcmdjLCBjaGFyICphcmd2W10pDQogICAgICAgYXNzZXJ0KHB0
aHJlYWRfcndsb2NrX2luaXQgKCZkYXRhW2RhdGFfY291bnRdLmxvY2ssIE5V
TEwpID09IDApOw0KICAgICB9DQogDQotICBfZnRpbWUoJmN1cnJTeXNUaW1l
MSk7DQorICBmdGltZSgmY3VyclN5c1RpbWUxKTsNCiANCiAgIC8qDQogICAg
KiBDcmVhdGUgVEhSRUFEUyB0aHJlYWRzIHRvIGFjY2VzcyBzaGFyZWQgZGF0
YS4NCkBAIC0xNzcsNyArMTc3LDcgQEAgbWFpbiAoaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSkNCiAgIHByaW50ZiAoIiVkIHRocmVhZCB1cGRhdGVzLCAlZCBk
YXRhIHVwZGF0ZXNcbiIsDQogICAgICAgICAgIHRocmVhZF91cGRhdGVzLCBk
YXRhX3VwZGF0ZXMpOw0KIA0KLSAgX2Z0aW1lKCZjdXJyU3lzVGltZTIpOw0K
KyAgZnRpbWUoJmN1cnJTeXNUaW1lMik7DQogDQogICBwcmludGYoICJcbnN0
YXJ0OiAlbGQvJWQsIHN0b3A6ICVsZC8lZCwgZHVyYXRpb246JWxkXG4iLA0K
ICAgICAgICAgICBjdXJyU3lzVGltZTEudGltZSxjdXJyU3lzVGltZTEubWls
bGl0bSwNCg==

---559023410-126398554-1048119469=:6272--
