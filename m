Return-Path: <cygwin-patches-return-5116-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19139 invoked by alias); 11 Nov 2004 01:49:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19098 invoked from network); 11 Nov 2004 01:49:37 -0000
Received: from unknown (HELO green.qinip.net) (62.100.30.36)
  by sourceware.org with SMTP; 11 Nov 2004 01:49:37 -0000
Received: from buzzy-box (hmm-dca-ap03-d13-105.dial.freesurf.nl [62.100.12.105])
	by green.qinip.net (Postfix) with SMTP
	id 43F6D42FF; Thu, 11 Nov 2004 02:49:35 +0100 (MET)
Message-ID: <n2m-g.cmuj3k.3vv9c9d.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: Re: [Patch] cygcheck: Make keyeprint more versatile.
References: <n2m-g.cmu9aj.3vvcqe5.1@buzzy-box.bavag> <20041111003551.GA6196@trixie.casa.cgf.cx>
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
User-Agent: slrn/0.9.8.1 (Win32) Hamster/2.0.6.0 Korrnews/4.2
To: cygwin-patches@cygwin.com
In-Reply-To: <20041111003551.GA6196@trixie.casa.cgf.cx>
Date: Thu, 11 Nov 2004 01:49:00 -0000
X-SW-Source: 2004-q4/txt/msg00117.txt.bz2

Op Wed, 10 Nov 2004 19:35:51 -0500 schreef Christopher Faylor
in <20041111003551.GA6196@trixie.casa.cgf.cx>:
[...]
: > 	* cygcheck.cc (keyeprint): New optional parameters: show_error and
: > 	print_failed.
:
:   Please check in.  Thanks.

Done.

:  Have I mentioned that I don't like the name 'keyeprint'?  It seems like an odd
:  name to me.

Well, why don't you change it to something sensible, then?
May I suggest:

sed -i -e 's/keyeprint/display_error/' src/winsup/utils/cygcheck.cc

(I'd post a patch, but am afraid it'd be too large...)


	* cygcheck.cc (keyeprint): Rename to display_error.
	(display_error): Renamed from keyeprint.
	(add_path): keyeprint is now called display_error.
	(init_paths): ditto.
	(find_on_path): ditto.
	(get_word): ditto.
	(get_dword): ditto.
	(rva_to_offset): ditto.
	(cygwin_info): ditto.
	(init_paths): ditto.
	(dll_info): ditto.
	(track_down): ditto.
	(ls): ditto.
	(scan_registry): ditto.
	(dump_sysinfo): ditto.
	(check_keys): ditto.


L8r,

Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
