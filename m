Return-Path: <cygwin-patches-return-2763-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13051 invoked by alias); 2 Aug 2002 13:16:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13037 invoked from network); 2 Aug 2002 13:16:41 -0000
Date: Fri, 02 Aug 2002 06:16:00 -0000
From: Michael Hoffman <grouse@mail.utexas.edu>
Subject: Change mount usage, winsup/utils/mount.cc
X-X-Sender: grouse@mail.utexas.edu
To: cygwin-patches@cygwin.com
Message-id: <Pine.WNT.4.44.0208020816340.968-200000@barbecueworld>
Content-id: <Pine.WNT.4.44.0208020816341.968@barbecueworld>
MIME-version: 1.0
Content-type: MULTIPART/Mixed; BOUNDARY="3654154-20862-1028294121=:968"
X-SW-Source: 2002-q3/txt/msg00211.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--3654154-20862-1028294121=:968
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0208020816342.968@barbecueworld>
Content-length: 276

2002-08-02  Michael Hoffman  <grouse@mail.utexas.edu>

* mount.cc (usage): Show usage as [<win32path>] [<posixpath>] since
the two are not always used together, like with --change-cygdrive-prefix.
-- 
Michael Hoffman <grouse@mail.utexas.edu>
The University of Texas at Austin

--3654154-20862-1028294121=:968
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="mount.cc-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0208020815210.968@barbecueworld>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="mount.cc-patch"
Content-length: 737

LS0tIG1vdW50LmNjLW9yaWcJMjAwMi0wOC0wMiAwODowNToyNC4wMDAwMDAw
MDAgLTA1MDANCisrKyBtb3VudC5jYwkyMDAyLTA4LTAyIDA4OjA2OjUxLjAw
MDAwMDAwMCAtMDUwMA0KQEAgLTEzMyw3ICsxMzMsNyBAQCBzdGF0aWMgY2hh
ciBvcHRzW10gPSAiYmNmaG1wc3R1dnhFWCI7DQogc3RhdGljIHZvaWQNCiB1
c2FnZSAoRklMRSAqd2hlcmUgPSBzdGRlcnIpDQogew0KLSAgZnByaW50ZiAo
d2hlcmUsICJVc2FnZTogJXMgW09QVElPTl0gWzx3aW4zMnBhdGg+IDxwb3Np
eHBhdGg+XVxuXA0KKyAgZnByaW50ZiAod2hlcmUsICJVc2FnZTogJXMgW09Q
VElPTl0gWzx3aW4zMnBhdGg+XSBbPHBvc2l4cGF0aD5dXG5cDQogICAtYiwg
LS1iaW5hcnkgICAgICAgICAgICAgICAgICB0ZXh0IGZpbGVzIGFyZSBlcXVp
dmFsZW50IHRvIGJpbmFyeSBmaWxlc1xuXA0KIAkJCQkobmV3bGluZSA9IFxc
bilcblwNCiAgIC1jLCAtLWNoYW5nZS1jeWdkcml2ZS1wcmVmaXggIGNoYW5n
ZSB0aGUgY3lnZHJpdmUgcGF0aCBwcmVmaXggdG8gPHBvc2l4cGF0aD5cblwN
Cg==

--3654154-20862-1028294121=:968--
