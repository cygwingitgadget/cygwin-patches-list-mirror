Return-Path: <cygwin-patches-return-1966-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10738 invoked by alias); 11 Mar 2002 02:54:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10691 invoked from network); 11 Mar 2002 02:54:03 -0000
Date: Mon, 11 Mar 2002 00:35:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: big kill patch (adds list/help/version)
Message-ID: <20020311025406.GA9430@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020311020418.6676.qmail@web20002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311020418.6676.qmail@web20002.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00323.txt.bz2

On Sun, Mar 10, 2002 at 06:04:18PM -0800, Joshua Daniel Franklin wrote:
>As a result of the 'kill -sigN' functionality, kill does not use
>GNU getopt to process options, so this patch required quite a few
>changes. While ./kill.exe works the same as /bin/kill for me, as
>usual I'm not saying it has any MERCHANTABILITY or FITNESS FOR A 
>PARTICULAR PURPOSE. Send me test cases and I will test if you desire.
>
>I also made two "unecessary" changes, which I like to think of as
>improvements. First, I removed the goto statement and moved the 
>code into a new function called sig0 (the label from the goto). This
>and all the other functions now appear above main (). I thought a 
>goto was absolutely necessary (even though I haven't needed one since 
>VAX assembly), until I read:
>
>Edsger W. Dijkstra "Go To Statement Considered Harmful"
>http://www.acm.org/classics/oct95/

No lectures, please.  If you want to get rid of a goto, fine.  This is
not the place for beginners' programming concepts.

For the record, the goto is mine and I am aware of the concept of
goto-less programming.

>No code was harmed in this move. In fact, being lazy I left all the
>variable names the same.

Hmm.  One would hope that you *would* leave the variable names the same.
That would be a truly gratuitous change.

>Second, there is now a -l, --list option that will list signal numbers
>and a *description* of the signal such as:
>
>24: CPU time limit exceeded

I'm sorry but 'kill -l' has an established way of working.  This is not
it.

>I would like to add the symbolic names like XCPU, HUP, etc.  to the
>list option, but I don't know of a dynamic way to do so.  Is there
>something like strsignal for this, or would it have to be hard-coded?

There is a function called strsigno in libiberty but cygwin doesn't
export it.  How does the linux kill program handle this?

>2002-03-10  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>* kill.cc (sig0) New function. Process signals given on command line.
>          (usage) Generalize to allow use for help. Describe options.
>          (list_signals) New fucntion.
>          (print_version) New function. 
>          (main) Accomodate new options. Add long options for each. 
>           Move goto functionality to sig0.

If you are interested in doing this, then do it in steps.  If you think
the goto is horrendous, then submit a patch to remove it.  If you think
that the functions just *have* to be moved before main(), then submit a patch
for that.

I would prefer that getopt still be used for this functionality.  It should
still be possible to parse signals by detecting illegal options and seeing
if they happen to be signal numbers.

So, bottom line is that I can't accept this patch.  Sorry.

cgf
