Return-Path: <cygwin-patches-return-4019-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3199 invoked by alias); 18 Jul 2003 16:32:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3186 invoked from network); 18 Jul 2003 16:32:14 -0000
Date: Fri, 18 Jul 2003 16:32:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: PATCH: remove -march=i386 from Makfefile.common
Message-ID: <20030718182359.U98824-200000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-902331284-1058545940=:98824"
X-Virus-Scanned: by amavisd-new at sh.cvut.cz
X-SW-Source: 2003-q3/txt/msg00035.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--0-902331284-1058545940=:98824
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 264


Hi,
I would like to apply this tiny patch. The -march=i386 in Makefile.common
defeats any user speciefied flag (-march=athlon for me).

Vaclav Haisman

2003-07-18  Vaclav Haisman  <V.Haisman@sh.cvut.cz>

	* Makefile.common (CFLAGS_COMMON): Remove -march=i386.




--0-902331284-1058545940=:98824
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="Makefile.common.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <20030718183220.M98824@logout.sh.cvut.cz>
Content-Description: Patch
Content-Disposition: attachment; filename="Makefile.common.diff"
Content-length: 1025

SW5kZXg6IHdpbnN1cC9NYWtlZmlsZS5jb21tb24NCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL01ha2Vm
aWxlLmNvbW1vbix2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNDYNCmRpZmYg
LXUgLXIxLjQ2IE1ha2VmaWxlLmNvbW1vbg0KLS0tIHdpbnN1cC9NYWtlZmls
ZS5jb21tb24JMiBKdWwgMjAwMyAwMjozMDoxNiAtMDAwMAkxLjQ2DQorKysg
d2luc3VwL01ha2VmaWxlLmNvbW1vbgkxOCBKdWwgMjAwMyAxNjoyMzozMiAt
MDAwMA0KQEAgLTEwLDcgKzEwLDcgQEANCiANCiAjIFRoaXMgbWFrZWZpbGUg
cmVxdWlyZXMgR05VIG1ha2UuDQogDQotQ0ZMQUdTX0NPTU1PTjo9LW1hcmNo
PWkzODYgLVdhbGwgLVd3cml0ZS1zdHJpbmdzIC1mbm8tY29tbW9uIC1waXBl
IC1mYnVpbHRpbiAtZm1lc3NhZ2UtbGVuZ3RoPTAjIC1maW5saW5lLWZ1bmN0
aW9ucw0KK0NGTEFHU19DT01NT046PS1XYWxsIC1Xd3JpdGUtc3RyaW5ncyAt
Zm5vLWNvbW1vbiAtcGlwZSAtZmJ1aWx0aW4gLWZtZXNzYWdlLWxlbmd0aD0w
IyAtZmlubGluZS1mdW5jdGlvbnMNCiBNQUxMT0NfREVCVUc6PSMtRE1BTExP
Q19ERUJVRyAtSS9jeWdudXMvc3JjL3ViZXJiYXVtL3dpbnN1cC9jeWd3aW4v
ZGxtYWxsb2MNCiBNQUxMT0NfT0JKOj0jL2N5Z251cy9zcmMvdWJlcmJhdW0v
d2luc3VwL2N5Z3dpbi9kbG1hbGxvYy9tYWxsb2Mubw0KIA0K

--0-902331284-1058545940=:98824--
