Return-Path: <cygwin-patches-return-1799-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23351 invoked by alias); 28 Jan 2002 15:53:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23166 invoked from network); 28 Jan 2002 15:53:21 -0000
Message-ID: <096001c1a812$755580a0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <keith_starsmeare@yahoo.co.uk>,
	<cygwin-patches@cygwin.com>
References: <005401c1a4da$c93e3e90$30313c3e@Obsession>
Subject: Re: setup.exe command line options
Date: Mon, 28 Jan 2002 07:53:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 28 Jan 2002 15:42:50.0230 (UTC) FILETIME=[7107D160:01C1A812]
X-SW-Source: 2002-q1/txt/msg00156.txt.bz2

Sorry about the delay getting back to you...


===
----- Original Message -----
From: "keith_starsmeare@yahoo.co.uk" <kxs@breathemail.net>
To: <cygwin-patches@cygwin.com>
Sent: Friday, January 25, 2002 12:25 AM
Subject: setup.exe command line options


> I've attached the diffs for the work in progress implementation of
command
> line options. I've tried to copy the dialog's terminology when
choosing the
> options and the variables used within WinMain.

Cool.

> I'm using the PropertyPage Create functions as my interface. In many
> instances the Create function can do all the work for that dialog, and
can
> return false - so no dialog will be created.
>
> I'm having problems with the packagedir and the rootdir Create
functions, I
> must be missing something. Most importantly I'm having difficulty
getting
> yyparse called. :(

Simply populate the sites array and the source, and the parsing will
happen in the ini dialog automatically. IMO you are better off using the
_same_ code -> command line parameters != windowless.

> Much work still to be done, but have a look and let me know how
appalled you
> all are at my strategy!

Shock! Horror!. :].

Seriously though, some feedback.

* I think that the default window constructors should be left intact -
add new constructors,or better yet methods that accept parameters. This
will result in cleaner code in main.cc IMO. (i.e. create all the
windows, then pass in all the parameters).
* (optional) It'd be really neat to have the command line options
register themselves, rather than all put in one place. Thats a more OOP
approach, but more initial effort required. It also means that the
parameter passing methods above wouldn't be needed per se - the
registered code would do that on the callback.
* for SourcePage, use an enum, not three bools - they are mutually
exclusive after all.
* Rather than skipping all the pages completely, I'd  suggest having the
page thread/function post a message that the dialog has finished after
your options are  processed. This is both simpler (no need to fiddle
with what pages exist) and easier (greater ability to leverage the
existing code).

Other than that, good work.

Cheers,
Rob
