Return-Path: <cygwin-patches-return-3907-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3119 invoked by alias); 26 May 2003 16:10:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3083 invoked from network); 26 May 2003 16:10:41 -0000
Message-Id: <3.0.5.32.20030526121109.0080ca30@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Mon, 26 May 2003 16:10:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: df and ls for root directories on Win9X
In-Reply-To: <20030526155440.GA12907@redhat.com>
References: <3.0.5.32.20030525175432.00807100@incoming.verizon.net>
 <20030525091901.GA875@cygbert.vinschen.de>
 <3.0.5.32.20030523183423.008059c0@mail.attbi.com>
 <20030525091901.GA875@cygbert.vinschen.de>
 <3.0.5.32.20030525175432.00807100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00134.txt.bz2

At 11:54 AM 5/26/2003 -0400, Christopher Faylor wrote:
>On Sun, May 25, 2003 at 05:54:32PM -0400, Pierre A. Humblet wrote:
>>At 12:48 PM 5/25/2003 -0400, Christopher Faylor wrote:

>>>Um.  I am still reviewing the fstat_by_name stuff.  I will be making
>>>changes to this.
>>>
>>I hope you find a more elegant way to determine when it's a root directory.
>
>The previous code obviously went out of its way to handle a special
>case.  It was not a "bug" that it filled out an array and changed "c:\"
>to "c:\*".

Except that it didn't work. FindFirstFile( subdir/*) returns first a handle
to subdir and then to all files in subdir. That's the behavior the code
was relying on.
However FindFirstFile(rootdir/*) only returns handles to the files in 
rootdir. That caused aliasing as my original e-mail illustrated.
Also the original code was not noticing root dirs with UNC paths.
 
>I'm away from my computer now so I can't easily check to see what you
>did but it looks like you made the root directory always assume today's
>date.

No, Dec 31 1969. That's the same on my WinNT (which calls fstat_by_handle).
 
>I also had a problem with this:
>+  else if (pc->isdir () && strlen (*pc) <= strlen (pc->root_dir ()))
>
>Isn't the strlen check just a more expensive and less clear way of doing
>a strcmp?  i.e.,
>
>+  else if (pc->isdir () && strcmp (*pc, pc->root_dir () == 0)

That's why I refered to "more elegant" above. The strcmp works for
c:\ but not for UNC paths. An "isprefix()" function would be just what we
need. 
The pc->isdir () is unnecessary, I only put it there to reduce the cost
of the strlen(). Another idea is to handle that special case after 
FindFirstFile has failed with winerror 2.

Pierre
