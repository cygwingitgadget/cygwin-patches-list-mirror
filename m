Return-Path: <cygwin-patches-return-2066-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25222 invoked by alias); 16 Apr 2002 10:43:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25208 invoked from network); 16 Apr 2002 10:43:34 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 16 Apr 2002 03:43:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] dtors run twice on dll detach
Message-ID: <Pine.WNT.4.44.0204161217320.89-101000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1542962-15020-1018953785=:89"
X-SW-Source: 2002-q2/txt/msg00050.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1542962-15020-1018953785=:89
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 765

I ran into a problem when is was trying to build STLPort-4.5.3 as dll (if
somebody is interested i can send him my patches). A program build with
this dll crashed in _free_r on termination. After testing a while i
discovered that the dtors were run twice, the first time from
dll_global_dtors, the second time from dll_list::detach which resulted in
a duplicated free for the same pointer.
Since i can not judge which function is obsolete (i guess dll_global_dtors
is) i have attached a small patch that will make sure that the dtors run
only once.

Regards
Thomas

2002-04-16  Thomas Pfaff  <tpfaff@gmx.net>

	* dll_init.h (per_process::dtors_run): New member.
	* dll_init.cc (per_module::run_dtors): Run dtors only once.
	(dll::init): Initialize dtors_run flag.


--1542962-15020-1018953785=:89
Content-Type: APPLICATION/octet-stream; name="run_dtors.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0204161243050.89@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="run_dtors.patch"
Content-length: 1684

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9kbGxfaW5pdC5jYyBz
cmMvd2luc3VwL2N5Z3dpbi9kbGxfaW5pdC5jYwotLS0gc3JjLm9sZC93aW5z
dXAvY3lnd2luL2RsbF9pbml0LmNjCVRodSBOb3YgIDEgMDE6MzA6MDMgMjAw
MQorKysgc3JjL3dpbnN1cC9jeWd3aW4vZGxsX2luaXQuY2MJVHVlIEFwciAx
NiAxMTo0MTowMyAyMDAyCkBAIC01OSw2ICs1OSwxNCBAQCB2b2lkCiBwZXJf
bW9kdWxlOjpydW5fZHRvcnMgKCkKIHsKICAgdm9pZCAoKipwZnVuYykoKSA9
IGR0b3JzOworCisgIGlmKCBkdG9yc19ydW4gKQorICB7CisgICAgIHJldHVy
bjsKKyAgfQorCisgIGR0b3JzX3J1biA9IHRydWU7CisKICAgZm9yIChpbnQg
aSA9IDE7IHBmdW5jW2ldOyBpKyspCiAgICAgKHBmdW5jW2ldKSAoKTsKIH0K
QEAgLTcxLDYgKzc5LDggQEAgZGxsOjppbml0ICgpCiAKICAgLyogV2h5IGRp
ZG4ndCB3ZSBqdXN0IGltcG9ydCB0aGlzIHZhcmlhYmxlPyAqLwogICAqKHAu
ZW52cHRyKSA9IF9fY3lnd2luX2Vudmlyb247CisKKyAgcC5kdG9yc19ydW4g
PSBmYWxzZTsKIAogICAvKiBEb24ndCBydW4gY29uc3RydWN0b3JzIG9yIHRo
ZSAibWFpbiIgaWYgd2UndmUgZm9ya2VkLiAqLwogICBpZiAoIWluX2Zvcmtl
ZSkKZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9kbGxfaW5pdC5o
IHNyYy93aW5zdXAvY3lnd2luL2RsbF9pbml0LmgKLS0tIHNyYy5vbGQvd2lu
c3VwL2N5Z3dpbi9kbGxfaW5pdC5oCVN1biBOb3YgIDQgMjI6Mzk6MzggMjAw
MQorKysgc3JjL3dpbnN1cC9jeWd3aW4vZGxsX2luaXQuaAlUdWUgQXByIDE2
IDExOjQyOjU3IDIwMDIKQEAgLTEzLDYgKzEzLDcgQEAgc3RydWN0IHBlcl9t
b2R1bGUKICAgY2hhciAqKiplbnZwdHI7CiAgIHZvaWQgKCoqY3RvcnMpKHZv
aWQpOwogICB2b2lkICgqKmR0b3JzKSh2b2lkKTsKKyAgYm9vbCBkdG9yc19y
dW47CiAgIHZvaWQgKmRhdGFfc3RhcnQ7CiAgIHZvaWQgKmRhdGFfZW5kOwog
ICB2b2lkICpic3Nfc3RhcnQ7CkBAIC0yMyw2ICsyNCw3IEBAIHN0cnVjdCBw
ZXJfbW9kdWxlCiAgICAgZW52cHRyID0gcC0+ZW52cHRyOwogICAgIGN0b3Jz
ID0gcC0+Y3RvcnM7CiAgICAgZHRvcnMgPSBwLT5kdG9yczsKKyAgICBkdG9y
c19ydW4gPSBwLT5kdG9yc19ydW47CiAgICAgZGF0YV9zdGFydCA9IHAtPmRh
dGFfc3RhcnQ7CiAgICAgZGF0YV9lbmQgPSBwLT5kYXRhX2VuZDsKICAgICBi
c3Nfc3RhcnQgPSBwLT5ic3Nfc3RhcnQ7Cg==

--1542962-15020-1018953785=:89--
