Return-Path: <cygwin-patches-return-2068-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8530 invoked by alias); 17 Apr 2002 07:08:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8481 invoked from network); 17 Apr 2002 07:07:48 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 17 Apr 2002 00:08:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] dtors run twice on dll detach (update)
Message-ID: <F0E13277A26BD311944600500454CCD050807A-101000@antarctica.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="299144-25001-1019027082=:422"
Content-ID: <Pine.WNT.4.44.0204170905310.422@algeria.intern.net>
X-SW-Source: 2002-q2/txt/msg00052.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--299144-25001-1019027082=:422
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.WNT.4.44.0204170905311.422@algeria.intern.net>
Content-length: 940

I am sorry for the previous patch, it was incomplete. This is hopefully a
better one:

On Tue, 16 Apr 2002, Thomas Pfaff wrote:

> I ran into a problem when is was trying to build STLPort-4.5.3 as dll
> (if
> somebody is interested i can send him my patches). A program build with
> this dll crashed in _free_r on termination. After testing a while i
> discovered that the dtors were run twice, the first time from
> dll_global_dtors, the second time from dll_list::detach which resulted
> in
> a duplicated free for the same pointer.
> Since i can not judge which function is obsolete (i guess
> dll_global_dtors
> is) i have attached a small patch that will make sure that the dtors run
> only once.
>
> Regards
> Thomas
>
> 2002-04-16  Thomas Pfaff  <tpfaff@gmx.net>
>
> 	* dll_init.h (per_process::dtors_run): New member.
> 	* dll_init.cc (per_module::run_dtors): Run dtors only once.
> 	(dll::init): Initialize dtors_run flag.
>
>
>



--299144-25001-1019027082=:422
Content-Type: APPLICATION/OCTET-STREAM; name="run_dtors.patch"
Content-Transfer-Encoding: BASE64
Content-ID: Pine.WNT.4.44.0204170904420.422@algeria.intern.net
Content-Description: 
Content-Disposition: attachment; filename="run_dtors.patch"
Content-length: 1387

ZGlmZiAtdXJwIGN5Z3dpbi5vbGQvd2luc3VwL2N5Z3dpbi9kbGxfaW5pdC5j
YyBjeWd3aW4vd2luc3VwL2N5Z3dpbi9kbGxfaW5pdC5jYwotLS0gY3lnd2lu
Lm9sZC93aW5zdXAvY3lnd2luL2RsbF9pbml0LmNjCVRodSBOb3YgIDEgMDE6
MzA6MDMgMjAwMQorKysgY3lnd2luL3dpbnN1cC9jeWd3aW4vZGxsX2luaXQu
Y2MJV2VkIEFwciAxNyAwODo0NDoyMyAyMDAyCkBAIC01OSw2ICs1OSwxMSBA
QCB2b2lkCiBwZXJfbW9kdWxlOjpydW5fZHRvcnMgKCkKIHsKICAgdm9pZCAo
KipwZnVuYykoKSA9IGR0b3JzOworCisgIGlmKCBkdG9yc19ydW4gKQorICAg
ICByZXR1cm47CisgIGR0b3JzX3J1biA9IHRydWU7CisKICAgZm9yIChpbnQg
aSA9IDE7IHBmdW5jW2ldOyBpKyspCiAgICAgKHBmdW5jW2ldKSAoKTsKIH0K
QEAgLTcxLDYgKzc2LDggQEAgZGxsOjppbml0ICgpCiAKICAgLyogV2h5IGRp
ZG4ndCB3ZSBqdXN0IGltcG9ydCB0aGlzIHZhcmlhYmxlPyAqLwogICAqKHAu
ZW52cHRyKSA9IF9fY3lnd2luX2Vudmlyb247CisKKyAgcC5kdG9yc19ydW4g
PSBmYWxzZTsKIAogICAvKiBEb24ndCBydW4gY29uc3RydWN0b3JzIG9yIHRo
ZSAibWFpbiIgaWYgd2UndmUgZm9ya2VkLiAqLwogICBpZiAoIWluX2Zvcmtl
ZSkKZGlmZiAtdXJwIGN5Z3dpbi5vbGQvd2luc3VwL2N5Z3dpbi9kbGxfaW5p
dC5oIGN5Z3dpbi93aW5zdXAvY3lnd2luL2RsbF9pbml0LmgKLS0tIGN5Z3dp
bi5vbGQvd2luc3VwL2N5Z3dpbi9kbGxfaW5pdC5oCVN1biBOb3YgIDQgMjI6
Mzk6MzggMjAwMQorKysgY3lnd2luL3dpbnN1cC9jeWd3aW4vZGxsX2luaXQu
aAlXZWQgQXByIDE3IDA4OjQzOjUzIDIwMDIKQEAgLTEzLDYgKzEzLDcgQEAg
c3RydWN0IHBlcl9tb2R1bGUKICAgY2hhciAqKiplbnZwdHI7CiAgIHZvaWQg
KCoqY3RvcnMpKHZvaWQpOwogICB2b2lkICgqKmR0b3JzKSh2b2lkKTsKKyAg
Ym9vbCBkdG9yc19ydW47CiAgIHZvaWQgKmRhdGFfc3RhcnQ7CiAgIHZvaWQg
KmRhdGFfZW5kOwogICB2b2lkICpic3Nfc3RhcnQ7Cg==

--299144-25001-1019027082=:422--
