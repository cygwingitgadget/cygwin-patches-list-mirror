Return-Path: <cygwin-patches-return-3913-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15618 invoked by alias); 26 May 2003 18:39:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15608 invoked from network); 26 May 2003 18:39:22 -0000
Date: Mon, 26 May 2003 18:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: df and ls for root directories on Win9X
Message-ID: <20030526183920.GC16861@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030525175432.00807100@incoming.verizon.net> <20030525091901.GA875@cygbert.vinschen.de> <3.0.5.32.20030523183423.008059c0@mail.attbi.com> <20030525091901.GA875@cygbert.vinschen.de> <3.0.5.32.20030525175432.00807100@incoming.verizon.net> <3.0.5.32.20030526121109.0080ca30@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030526121109.0080ca30@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00140.txt.bz2

On Mon, May 26, 2003 at 12:11:09PM -0400, Pierre A. Humblet wrote:
>At 11:54 AM 5/26/2003 -0400, Christopher Faylor wrote:
>>On Sun, May 25, 2003 at 05:54:32PM -0400, Pierre A. Humblet wrote:
>>>At 12:48 PM 5/25/2003 -0400, Christopher Faylor wrote:
>
>>>>Um.  I am still reviewing the fstat_by_name stuff.  I will be making
>>>>changes to this.
>>>>
>>>I hope you find a more elegant way to determine when it's a root directory.
>>
>>The previous code obviously went out of its way to handle a special
>>case.  It was not a "bug" that it filled out an array and changed "c:\"
>>to "c:\*".
>
>Except that it didn't work. FindFirstFile( subdir/*) returns first a handle
>to subdir and then to all files in subdir. That's the behavior the code
>was relying on.

The code was relying on the fact that *something* was returned.  It wasn't
relying on any other behavior than that.  It probably should have cleared
out the size though, at least.

>However FindFirstFile(rootdir/*) only returns handles to the files in 
>rootdir. That caused aliasing as my original e-mail illustrated.
>Also the original code was not noticing root dirs with UNC paths.

Yep.  There should have been a FIXME comment to that effect.
 
>>I'm away from my computer now so I can't easily check to see what you
>>did but it looks like you made the root directory always assume today's
>>date.
>
>No, Dec 31 1969. That's the same on my WinNT (which calls fstat_by_handle).

Ugh.
 
>>I also had a problem with this:
>>+  else if (pc->isdir () && strlen (*pc) <= strlen (pc->root_dir ()))
>>
>>Isn't the strlen check just a more expensive and less clear way of doing
>>a strcmp?  i.e.,
>>
>>+  else if (pc->isdir () && strcmp (*pc, pc->root_dir () == 0)
>
>That's why I refered to "more elegant" above. The strcmp works for
>c:\ but not for UNC paths. An "isprefix()" function would be just what we
>need. 

Actually, I meant strncmp but you'd end up doing more work with strncmp.

We have an isprefix function already but it also needs a length field
and so would be no faster.

So, nevermind, the patch is fine.

cgf
