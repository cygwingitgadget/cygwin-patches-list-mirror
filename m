Return-Path: <cygwin-patches-return-5756-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6777 invoked by alias); 16 Feb 2006 14:58:33 -0000
Received: (qmail 6765 invoked by uid 22791); 16 Feb 2006 14:58:32 -0000
X-Spam-Check-By: sourceware.org
Received: from smtpout12-02.prod.mesa1.secureserver.net (HELO smtpout12-02.prod.mesa1.secureserver.net) (68.178.232.4)     by sourceware.org (qpsmtpd/0.31) with SMTP; Thu, 16 Feb 2006 14:58:30 +0000
Received: (qmail 22562 invoked from network); 16 Feb 2006 14:58:28 -0000
Received: from unknown (HELO webmail13.mesa1.secureserver.net) (64.202.189.54)   by smtpout12-02.prod.mesa1.secureserver.net with SMTP; 16 Feb 2006 14:58:28 -0000
Received: (qmail 961 invoked by uid 99); 16 Feb 2006 14:58:28 -0000
Date: Thu, 16 Feb 2006 14:58:00 -0000
From: "Jerry D. Hedden" <jerry@hedden.us>
Subject: RE: [PATCH] Add -p option to ps command
To: cygwin-patches@cygwin.com
Message-ID: <20060216075828.fb30e530d17747c2b054d625b8945d88.f6da7960fc.wbe@email.secureserver.net>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="-901761347-1158872905-1140101908=:17291"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00065.txt.bz2

---901761347-1158872905-1140101908=:17291
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-length: 732

> On Feb 14 07:12, Jerry D. Hedden wrote:
> > Attached is a patch to add a -p option to the ps command to show
> > information for only a single PID:  ps -p PID

> Corrina Vinschen replied:
> Thanks for the patch.  It's barely short enough so that we decided to
> put it in despite the fact that you have no copyright assignment
> in place.

I will send one in today.

> I applied your patch with some minor changes.

Thanks.  I realized one minor oversight.  Using -p should imply -a so
that even if the PID is not owned by the current user, it will still
get listed.  I've attached a patch for this (just a one line addition)
that builds on top of the previous patch (i.e., apply it against
version 1.20 of ps.cc).  Thanks again.

---901761347-1158872905-1140101908=:17291
Content-Type: TEXT/plain;
	name="ps.cc.patch"; CHARSET=US-ASCII
Content-Transfer-Encoding: BASE64
Content-Disposition: attachment; filename="ps.cc.patch"
Content-length: 354

SW5kZXg6IHNyYy93aW5zdXAvdXRpbHMvcHMuY2MNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCi0tLSBwcy5jYyAgMS4yMA0KKysrIHBzLmNjDQpAQCAtMjg2
LDYgKzI4Niw3IEBADQogCWJyZWFrOw0KICAgICAgIGNhc2UgJ3AnOg0KIAlw
cm9jX2lkID0gYXRvaSAob3B0YXJnKTsNCisJYWZsYWcgPSAxOw0KIAlicmVh
azsNCiAgICAgICBjYXNlICdzJzoNCiAJc2ZsYWcgPSAxOw0K

---901761347-1158872905-1140101908=:17291--
