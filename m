Return-Path: <cygwin-patches-return-4587-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11855 invoked by alias); 8 Mar 2004 21:05:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11826 invoked from network); 8 Mar 2004 21:05:19 -0000
X-Authentication-Warning: thing1-200.fsi.com: ford owned process doing -bs
Date: Mon, 08 Mar 2004 21:05:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@thing1-200
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: sigproc.cc (proc_subproc): make -j hang
Message-ID: <Pine.GSO.4.58.0403081435020.11361@thing1-200>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-758783491-1078778739=:11361"
Content-ID: <Pine.GSO.4.58.0403081446180.11361@thing1-200>
X-SW-Source: 2004-q1/txt/msg00077.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-758783491-1078778739=:11361
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.58.0403081446181.11361@thing1-200>
Content-length: 805

While trying to analyze my own strace example of a "make -j hang" ala this
ugly thread:

http://www.cygwin.com/ml/cygwin/2004-03/msg00376.html

My last strace output from the hung make process was:
   69 1576822 [proc] make 6724 proc_subproc: pid 7524[0], reparented old
hProcess 0x698, new 0x63C

So, looking there, I stumbled onto the following:

2004-03-08  Brian Ford  <ford@vss.fsi.com>

	* sigproc.cc (proc_subproc): Only call sync_proc_subproc->release()
	once for exec().

I'm not sure this is a bug, and it doesn't appear to fix the make hang I
was looking at, but I thought it deserved a quick review by someone who
knows that code :).  Thanks.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-758783491-1078778739=:11361
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="sigproc.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0403081445390.11361@thing1-200>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="sigproc.cc.patch"
Content-length: 859

SW5kZXg6IHNpZ3Byb2MuY2MNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJD
UyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9zaWdwcm9jLmNj
LHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4xODkNCmRpZmYgLXUgLXAgLXIx
LjE4OSBzaWdwcm9jLmNjDQotLS0gc2lncHJvYy5jYwkyNiBGZWIgMjAwNCAw
NToxMDo0NyAtMDAwMAkxLjE4OQ0KKysrIHNpZ3Byb2MuY2MJOCBNYXIgMjAw
NCAyMDo0MjoyNCAtMDAwMA0KQEAgLTM0OCw3ICszNDgsNyBAQCBwcm9jX3N1
YnByb2MgKERXT1JEIHdoYXQsIERXT1JEIHZhbCkNCiAJICBGb3JjZUNsb3Nl
SGFuZGxlMSAoaCwgY2hpbGRoUHJvYyk7DQogCSAgUHJvdGVjdEhhbmRsZTEg
KHBjaGlsZHJlblt2YWxdLT5oUHJvY2VzcywgY2hpbGRoUHJvYyk7DQogCSAg
cmMgPSAwOw0KLQkgIGdvdG8gb3V0OwkJCS8vIFRoaXMgd2FzIGFuIGV4ZWMo
KQ0KKwkgIGdvdG8gb3V0MTsJCQkvLyBUaGlzIHdhcyBhbiBleGVjKCkNCiAJ
fQ0KIA0KICAgICAgIHNpZ3Byb2NfcHJpbnRmICgicGlkICVkWyVkXSB0ZXJt
aW5hdGVkLCBoYW5kbGUgJXAsIG5jaGlsZHJlbiAlZCwgbnpvbWJpZXMgJWQi
LA0K

---559023410-758783491-1078778739=:11361--
