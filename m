Return-Path: <cygwin-patches-return-3066-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24667 invoked by alias); 20 Oct 2002 02:26:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24652 invoked from network); 20 Oct 2002 02:26:13 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 19 Oct 2002 19:26:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup cvs HEAD build broken
Message-ID: <Pine.GSO.4.44.0210192212110.6818-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-654246144-1035080772=:6818"
X-SW-Source: 2002-q4/txt/msg00017.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-654246144-1035080772=:6818
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 825

Hi,
The winsup cvs HEAD doesn't build.  The error is in winsup/mingw/crt1.c --
gcc chokes on _onexit_t.  Further investigation identified the culprit:
http://www.cygwin.com/ml/cygwin-cvs/2002-q4/msg00056.html , in particular,
the following change:
	crt1.c: Don't include fcntrl.h, stdlib.h.
_onexit_t is defined in stdlib.h.
I've attached the patch to include stdlib.h back, which fixes the build.
	Igor

ChangeLog:
2002-10-19  Igor Pechtchanski <pechtcha@cs.nyu.edu>

	* crt1.c: Include stdlib.h.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Water molecules expand as they grow warmer" (C) Popular Science, Oct'02, p.51

---559023410-654246144-1035080772=:6818
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="mingw-crt1-stdlib.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0210192226120.6818@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="mingw-crt1-stdlib.patch"
Content-length: 570

SW5kZXg6IHdpbnN1cC9taW5ndy9jcnQxLmMNCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL21pbmd3L2Ny
dDEuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNA0KZGlmZiAtdSAtcCAt
cjEuNCBjcnQxLmMNCi0tLSB3aW5zdXAvbWluZ3cvY3J0MS5jCTE5IE9jdCAy
MDAyIDIwOjI2OjI2IC0wMDAwCTEuNA0KKysrIHdpbnN1cC9taW5ndy9jcnQx
LmMJMjAgT2N0IDIwMDIgMDI6MjI6NTIgLTAwMDANCkBAIC0yNiw2ICsyNiw3
IEBADQogICoNCiAgKi8NCiANCisjaW5jbHVkZSA8c3RkbGliLmg+DQogI2lu
Y2x1ZGUgPHN0ZGlvLmg+DQogI2luY2x1ZGUgPGlvLmg+DQogI2luY2x1ZGUg
PHByb2Nlc3MuaD4NCg==

---559023410-654246144-1035080772=:6818--
