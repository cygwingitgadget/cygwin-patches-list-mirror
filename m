Return-Path: <cygwin-patches-return-3062-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18864 invoked by alias); 18 Oct 2002 08:30:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18850 invoked from network); 18 Oct 2002 08:30:30 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 18 Oct 2002 01:30:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] verifyable_object_isvalid
Message-ID: <Pine.WNT.4.44.0210181019190.265-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="671501-19375-1034929821=:265"
X-SW-Source: 2002-q4/txt/msg00013.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--671501-19375-1034929821=:265
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 239


Rob,

the location for the static test is wrong. I have moved it 2 lines down.

Thomas

2002-10-18  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (verifyable_object_isvalid): Test for a valid object
	pointer before testing for static ptr.

--671501-19375-1034929821=:265
Content-Type: TEXT/plain; name="verifyable_object_isvalid.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0210181030210.265@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="verifyable_object_isvalid.patch"
Content-length: 789

LS0tIHRocmVhZC5jYy5vcmcJVGh1IE9jdCAxNyAxMDoyODozMiAyMDAyCisr
KyB0aHJlYWQuY2MJRnJpIE9jdCAxOCAxMDoxNzo1NCAyMDAyCkBAIC0xMzU2
LDEwICsxMzU2LDEwIEBAIHZlcmlmeWFibGVfb2JqZWN0X3N0YXRlCiB2ZXJp
ZnlhYmxlX29iamVjdF9pc3ZhbGlkICh2b2lkIGNvbnN0ICogb2JqZWN0cHRy
LCBsb25nIG1hZ2ljLCB2b2lkICpzdGF0aWNfcHRyKQogewogICB2ZXJpZnlh
YmxlX29iamVjdCAqKm9iamVjdCA9ICh2ZXJpZnlhYmxlX29iamVjdCAqKilv
YmplY3RwdHI7Ci0gIGlmIChzdGF0aWNfcHRyICYmICpvYmplY3QgPT0gc3Rh
dGljX3B0cikKLSAgICByZXR1cm4gVkFMSURfU1RBVElDX09CSkVDVDsKICAg
aWYgKGNoZWNrX3ZhbGlkX3BvaW50ZXIgKG9iamVjdCkpCiAgICAgcmV0dXJu
IElOVkFMSURfT0JKRUNUOworICBpZiAoc3RhdGljX3B0ciAmJiAqb2JqZWN0
ID09IHN0YXRpY19wdHIpCisgICAgcmV0dXJuIFZBTElEX1NUQVRJQ19PQkpF
Q1Q7CiAgIGlmICghKm9iamVjdCkKICAgICByZXR1cm4gSU5WQUxJRF9PQkpF
Q1Q7CiAgIGlmIChjaGVja192YWxpZF9wb2ludGVyICgqb2JqZWN0KSkK

--671501-19375-1034929821=:265--
