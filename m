Return-Path: <cygwin-patches-return-2293-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26200 invoked by alias); 3 Jun 2002 14:27:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26184 invoked from network); 3 Jun 2002 14:27:56 -0000
Message-ID: <20020603142753.6790.qmail@web20005.mail.yahoo.com>
Date: Mon, 03 Jun 2002 07:27:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: regtool help/version patch
To: cygwin-patches@cygwin.com
In-Reply-To: <20020603032114.GA8750@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00276.txt.bz2


--- Christopher Faylor <cgf@redhat.com> wrote:
> On Sun, Jun 02, 2002 at 10:58:33PM -0400, Christopher Faylor wrote:
> >On Sun, Jun 02, 2002 at 09:45:30PM -0500, Joshua Daniel Franklin wrote:
> >>2002-06-02  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
> >>
> >>	* regtool.cc (prog_name): New global variable.
> >>	(longopts): Ditto.
> >>	(opts): Ditto.
> >>	(usage): Standardize usage output. Rearrange/add descriptions.
> >>	(print_version): New function.
> >>	(main): Accomodate longopts and new --help, --version options.
> >>	Add check for (_argv[optind+1] == NULL).
> >
> >Applied.
> >
> >Thanks, as always.
> 
> Joshua, it just occurred to me that you don't seem to be patching the
> .sgml documentation when you make a change to a utility.
> 
> Do you think you could take a run over the utils.sgml file and see
> if there are missing options that could be added?  Also, if you're
> adding examples to the output then utils.sgml would be a good place
> for that, too.
> 
> cgf

I was going to try to get all the --help/--version patches in for the
next release, then patch utils.sgml at leisure. My logic is that the
binaries are hard to change, but the using-utils.html page and the
cygwin-doc package (which I have full control over) are easy. Also I
may have a lot of questions on certain explanations in utils.sgml
(about, for example, setfacl or strace) that really are not related to
the patches but could slow down the patching if I were working on it at 
the same time.

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
