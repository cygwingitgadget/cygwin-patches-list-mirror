Return-Path: <cygwin-patches-return-3045-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6768 invoked by alias); 25 Sep 2002 08:09:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6748 invoked from network); 25 Sep 2002 08:09:12 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 25 Sep 2002 01:09:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] MTinterface patch part 4
Message-ID: <Pine.WNT.4.44.0209250930220.269-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2413034-13920-1032941347=:269"
X-SW-Source: 2002-q3/txt/msg00493.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2413034-13920-1032941347=:269
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 197


Check for valid pthread object to avoid deletion of Nullpthread.


2002-09-25  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (pthread::destructor): Check for valid pthread object
	prior to delete.

--2413034-13920-1032941347=:269
Content-Type: TEXT/plain; name="mtinterface4.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0209251009070.269@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="mtinterface4.patch"
Content-length: 688

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Mgc3Jj
L3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vdGhyZWFkLmNjCVdlZCBTZXAgMjUgMDk6MjI6MDMgMjAwMgorKysg
c3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCVdlZCBTZXAgMjUgMDk6NTU6
MDkgMjAwMgpAQCAtMjQ4LDcgKzI0OCw3IEBAIHB0aHJlYWQ6OmRlc3RydWN0
b3IgKHZvaWQgKnZhbHVlKQogewogICBwdGhyZWFkICp0aHJlYWQgPSAocHRo
cmVhZCAqKSB2YWx1ZTsKICAgLyogY2xlYW51cCB0aHJlYWQgaWYgdGhyZWFk
IGlzIGRldGFjaGVkIGFuZCBub3Qgam9pbmVkICovCi0gIGlmICh0aHJlYWQg
JiYgX19wdGhyZWFkX2VxdWFsKCZ0aHJlYWQtPmpvaW5lciwgJnRocmVhZCkp
CisgIGlmIChpc0dvb2RPYmplY3QgKCZ0aHJlYWQpICYmIF9fcHRocmVhZF9l
cXVhbCgmdGhyZWFkLT5qb2luZXIsICZ0aHJlYWQpKQogICAgIGRlbGV0ZSB0
aHJlYWQ7CiB9CiAK

--2413034-13920-1032941347=:269--
