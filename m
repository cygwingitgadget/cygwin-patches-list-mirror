Return-Path: <cygwin-patches-return-4294-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30269 invoked by alias); 14 Oct 2003 14:55:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30258 invoked from network); 14 Oct 2003 14:55:08 -0000
Date: Tue, 14 Oct 2003 14:55:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Ncurses frame drawing
Message-ID: <20031014145507.GC14344@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031013170602.GN14344@cygbert.vinschen.de> <3F8BDE21.2090206@student.tue.nl> <20031014142447.GA16944@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014142447.GA16944@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00013.txt.bz2

On Tue, Oct 14, 2003 at 10:24:47AM -0400, Christopher Faylor wrote:
> On Tue, Oct 14, 2003 at 01:29:37PM +0200, Micha Nelissen wrote:
> >Corinna Vinschen wrote:
> >>This patch is a nice idea but it's not quite correct.  You can't
> >>rely on "current_codepage" being ansi_cp.  Since the user can set
> >>it to oem_cp in the CYGWIN environment variable, you have to memorize
> >>the old value on \E[11m and to restore to the old value on \E[10m.
> >
> >Ok, that's true.  Attached is a patch with the suggested changes.
> 
> I guess this is ok although it's not thread safe.  It looks like
> fhandler_console isn't thread safe in general, though.
> 
> Corinna do you have time to check this in?

Erm... I was still mulling over this code since I thought there's
something wrong.  It took some time until it occured to me that this
implementation overrides the original value of current_codepage, if
the application accidentally happens to send \E[11m twice.  That
shouldn't be possible.

I'd prefer if the value of original_codepage is set to the same value
as current_codepage in environ.cc (codepage_init).  It should not
be manipulated in fhandler_console.cc (char_command).

Micha, any problem to revise your code accordingly?  Also, I'd like
to ask you to change your ChangeLog entry a bit.  Begin first word
in a sentence with upper case letter, always use present tense and
tabify the entry, like this:

	* fhandler_console.cc (char_command): Add escape sequence for
	codepage ansi <-> oem switching for ncurses frame drawing
	capabilities.

instead of

* fhandler_console.cc (char_command): added escape sequence for codepage
ansi <-> oem switching for ncurses frame drawing capabilities.

Thanks in advance,
Corinna

> >
> >* dcrt0.cc: add local variable original_codepage.
> >
> >* winsup.h: add global external variable original_codepage.
> 
> >Index: dcrt0.cc
> >===================================================================
> >RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
> >retrieving revision 1.187
> >diff -u -w -r1.187 dcrt0.cc
> >--- dcrt0.cc	8 Oct 2003 21:40:33 -0000	1.187
> >+++ dcrt0.cc	14 Oct 2003 11:28:44 -0000
> >@@ -57,6 +57,7 @@
> > bool strip_title_path;
> > bool allow_glob = TRUE;
> > codepage_type current_codepage = ansi_cp;
> >+codepage_type original_codepage;
> > 
> > int cygwin_finished_initializing;
> > 
> >Index: fhandler_console.cc
> >===================================================================
> >RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
> >retrieving revision 1.115
> >diff -u -w -r1.115 fhandler_console.cc
> >--- fhandler_console.cc	27 Sep 2003 02:36:50 -0000	1.115
> >+++ fhandler_console.cc	14 Oct 2003 11:28:44 -0000
> >@@ -1111,6 +1111,13 @@
> > 	     case 9:    /* dim */
> > 	       dev_state->intensity = INTENSITY_DIM;
> > 	       break;
> >+             case 10:   /* end alternate charset */
> >+               current_codepage = original_codepage;
> >+	       break;
> >+             case 11:   /* start alternate charset */
> >+               original_codepage = current_codepage;
> >+               current_codepage = oem_cp;
> >+	       break;
> > 	     case 24:
> > 	       dev_state->underline = FALSE;
> > 	       break;
> >Index: winsup.h
> >===================================================================
> >RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
> >retrieving revision 1.119
> >diff -u -w -r1.119 winsup.h
> >--- winsup.h	25 Sep 2003 00:37:17 -0000	1.119
> >+++ winsup.h	14 Oct 2003 11:28:44 -0000
> >@@ -90,6 +90,7 @@
> > 
> > enum codepage_type {ansi_cp, oem_cp};
> > extern codepage_type current_codepage;
> >+extern codepage_type original_codepage;
> > 
> > UINT get_cp ();
> > 

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
