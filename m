Return-Path: <cygwin-patches-return-5206-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24043 invoked by alias); 15 Dec 2004 23:04:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24004 invoked from network); 15 Dec 2004 23:04:14 -0000
Received: from unknown (HELO omzesmtp01.mci.com) (199.249.17.7)
  by sourceware.org with SMTP; 15 Dec 2004 23:04:14 -0000
Received: from pmismtp01.mcilink.com ([166.38.62.36])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0I8S003EDDF1NB@firewall.mci.com> for cygwin-patches@cygwin.com;
 Wed, 15 Dec 2004 23:04:14 +0000 (GMT)
Received: from pmismtp01.mcilink.com by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0I8S00001DF0OT@pmismtp01.mcilink.com> for
 cygwin-patches@cygwin.com; Wed, 15 Dec 2004 23:04:13 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.132.122])
 by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0I8S00MOYDF18J@pmismtp01.mcilink.com> for
 cygwin-patches@cygwin.com; Wed, 15 Dec 2004 23:04:13 +0000 (GMT)
Date: Wed, 15 Dec 2004 23:04:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Patch to allow trailing dots on managed mounts
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0I8S00MOZDF18J@pmismtp01.mcilink.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_5JZmYc+SJ+wBuegQjqvbgw)"
Priority: Normal
X-SW-Source: 2004-q4/txt/msg00207.txt.bz2


--Boundary_(ID_5JZmYc+SJ+wBuegQjqvbgw)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-length: 472

This patch is as trivial as I could get to allow trailing
dots to be used on a managed file system.

Unfortunately, my company will not sign the waiver,
so I cannot sign up for any significant changes to
the cygwin sources.  So, hopefully, this patch is
small enough to squeek under the limit, or it can be a
starting point for discussions on how to fix the original
problem.

    * path.cc (path_conv::check):  retain trailing dots and 
      spaces for managed mounts.


--Boundary_(ID_5JZmYc+SJ+wBuegQjqvbgw)
Content-type: text/plain; CHARSET=us-ascii; name=path.cc.patch.txt
Content-transfer-encoding: base64
Content-disposition: attachment; filename=path.cc.patch.txt
Content-length: 940

LS0tIHBhdGguY2MgICAgIDMgRGVjIDIwMDQgMDI6MDA6MzcgLTAwMDAgICAg
ICAgMS4zMjYNCisrKyBwYXRoLmNjICAgICAxNSBEZWMgMjAwNCAyMjo1Nzoy
NSAtMDAwMA0KQEAgLTU1NSw2ICs1NTUsNyBAQCBwYXRoX2NvbnY6OmNoZWNr
IChjb25zdCBjaGFyICpzcmMsIHVuc2lnDQogICAgICAgICAgICB9DQogICAg
ICAgICAgLyogUmVtb3ZlIHRyYWlsaW5nIGRvdHMgYW5kIHNwYWNlcyB3aGlj
aCBhcmUgaWdub3JlZCBieSBXaW4zMiBmdW5jdGlvbg0KcyBidXQNCiAgICAg
ICAgICAgICBub3QgYnkgbmF0aXZlIE5UIGZ1bmN0aW9ucy4gKi8NCisgICAg
ICAgICBjaGFyICp0bXBUYWlsID0gdGFpbDsNCiAgICAgICAgICB3aGlsZSAo
dGFpbFstMV0gPT0gJy4nIHx8IHRhaWxbLTFdID09ICcgJykNCiAgICAgICAg
ICAgIHRhaWwtLTsNCiAgICAgICAgICBpZiAodGFpbCA+IHBhdGhfY29weSAr
IDEgJiYgaXNzbGFzaCAodGFpbFstMV0pKQ0KQEAgLTU2Miw2ICs1NjMsNyBA
QCBwYXRoX2NvbnY6OmNoZWNrIChjb25zdCBjaGFyICpzcmMsIHVuc2lnDQog
ICAgICAgICAgICAgIGVycm9yID0gRU5PRU5UOw0KICAgICAgICAgICAgICBy
ZXR1cm47DQogICAgICAgICAgICB9DQorICAgICAgICAgdGFpbCA9IHRtcFRh
aWw7DQogICAgICAgIH0NCiAgICAgICBwYXRoX2VuZCA9IHRhaWw7DQogICAg
ICAgKnRhaWwgPSAnXDAnOw0K

--Boundary_(ID_5JZmYc+SJ+wBuegQjqvbgw)--
