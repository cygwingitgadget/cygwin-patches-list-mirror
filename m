Return-Path: <cygwin-patches-return-4042-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10734 invoked by alias); 7 Aug 2003 16:34:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10699 invoked from network); 7 Aug 2003 16:34:14 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 07 Aug 2003 16:34:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Remove redundant null check in dump_setup()
Message-ID: <Pine.GSO.4.44.0308071231323.5132-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1254324197-1060274009=:5132"
Content-ID: <Pine.GSO.4.44.0308071233350.5132@slinky.cs.nyu.edu>
X-SW-Source: 2003-q3/txt/msg00058.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1254324197-1060274009=:5132
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0308071233351.5132@slinky.cs.nyu.edu>
Content-length: 739

Hi,
The patch speaks for itself.  I didn't want to include this as part of a
larger patch -- let me know if I should do that instead.
	Igor
==============================================================================
ChangeLog:
2003-08-07  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* dump_setup.cc (dump_setup): Remove redundant null check.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton

---559023410-1254324197-1060274009=:5132
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="cygcheck-redundant-check.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0308071233290.5132@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="cygcheck-redundant-check.patch"
Content-length: 635

SW5kZXg6IGR1bXBfc2V0dXAuY2MNCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL3V0aWxzL2R1bXBfc2V0
dXAuY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjYNCmRpZmYgLXUgLXAg
LXIxLjYgZHVtcF9zZXR1cC5jYw0KLS0tIGR1bXBfc2V0dXAuY2MJNyBGZWIg
MjAwMyAyMTozNDozNCAtMDAwMAkxLjYNCisrKyBkdW1wX3NldHVwLmNjCTcg
QXVnIDIwMDMgMTY6Mjk6NDkgLTAwMDANCkBAIC0xODgsOSArMTg4LDYgQEAg
ZHVtcF9zZXR1cCAoaW50IHZlcmJvc2UsIGNoYXIgKiphcmd2LCBibw0KIAlw
dXRzICgiIik7DQogICAgIH0NCiANCi0gIGlmICghZnApDQotICAgIGdvdG8g
ZXJyOw0KLQ0KICAgaW50IG5saW5lczsNCiAgIG5saW5lcyA9IDA7DQogICBj
aGFyIGJ1Zls0MDk2XTsNCg==

---559023410-1254324197-1060274009=:5132--
