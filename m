Return-Path: <cygwin-patches-return-1969-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6216 invoked by alias); 11 Mar 2002 15:02:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6141 invoked from network); 11 Mar 2002 15:02:02 -0000
Message-ID: <20020311150159.48027.qmail@web20005.mail.yahoo.com>
Date: Mon, 11 Mar 2002 07:12:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: big kill patch (adds list/help/version)
To: cygwin-patches@cygwin.com
In-Reply-To: <20020311025406.GA9430@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00326.txt.bz2

--- Christopher Faylor <cgf@redhat.com> wrote:
> No lectures, please.  If you want to get rid of a goto, fine. 
'twas a joke. Sorry. 

> I'm sorry but 'kill -l' has an established way of working.  
> How does the linux kill program handle this?
RedHat's prints a list like
 1) SIGHUP       2) SIGINT       3) SIGQUIT      4) SIGILL
 5) SIGTRAP      6) SIGABRT      7) SIGBUS       8) SIGFPE
...
Looks hard-coded to me, but I didn't look at the sources. I'll hard-code 
the list in the print_list () function.

> If you think that the functions just *have* to be moved before main(), then 
> submit a patch for that.
OK. I was just trying to have the sources be consistant, but main followed by
functions is fine.

> I would prefer that getopt still be used for this functionality.  It should
> still be possible to parse signals by detecting illegal options and seeing
> if they happen to be signal numbers.
I really don't think it's possible since getopt does the illegal-option
parsing. I'm not a getopt expert, but GNU getopt
won't recognize anything that's not in the "ab:cdef". I think the only way
would be to put all possible signals in the long_options struct like:
  { "HUP", no_argument, NULL, SIGHUP},
in which case I *think* the numbers would be recognized, but stuff like -HUP
would have to be --HUP. The problem is that getopt will only parse the first
character after a single dash (and then, if it's another dash, proceed).

Well, I have no political views about goto so I'll probably leave it for
simplicity in a new patch. I'll probably leave out the -l option, too, and 
just stick with adding -h and -v.

__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
