Return-Path: <cygwin-patches-return-3044-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20284 invoked by alias); 24 Sep 2002 17:16:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20269 invoked from network); 24 Sep 2002 17:16:42 -0000
Date: Tue, 24 Sep 2002 10:16:00 -0000
From: Steve O <bub@io.com>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] fhandler_tty doecho change
Message-ID: <20020924121608.A27693@hagbard.io.com>
References: <20020924015053.A21742@eris.io.com> <20020924092143.J29920@cygbert.vinschen.de> <20020924143723.GB918@redhat.com> <20020924105431.A3758@fnord.io.com> <16288646311.20020924201427@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16288646311.20020924201427@logos-m.ru>; from deo@logos-m.ru on Tue, Sep 24, 2002 at 08:14:27PM +0400
X-SW-Source: 2002-q3/txt/msg00492.txt.bz2

On Tue, Sep 24, 2002 at 08:14:27PM +0400, egor duda wrote:
> Hi!
> 
> Tuesday, 24 September, 2002 Steve O bub@io.com wrote:
> 
> SO> I was thinking about the deadlock problem some more last night,
> SO> and it occured to me that if termios processing were done on 
> SO> the slave side, some of the buffering and tricky bits of 
> SO> flushing the write buffer would go away (maybe).  And you wouldn't
> SO> need this patch.
> 
> What do you mean exactly by "termios processing"?

fhandler_termios::line_edit which is currently called by 
fhandler_pty_master::write could be instead called when the 
slave either selects or reads.  Some modification would be
needed.

> And did you take into account the possibility that process which owns
> slave side of tty forks and child gets handle to slave too. Then child
> does some "termios processing". Will parent use old or new termios
> settings?

In my limited understand of this code, the line_edit processing
handles cooking the data for the child.  What settings to use 
would depend on what the child requests.  The parent doesn't seem
to be involved.

My area of fuzziness in this is what happens when the child forks
and both children select on reading the tty.  In order to know
if there's something to be read the select has to run the line_edit
processing and check the readahead buffer.  The result being that
one child would return from select and the other wouldn't.
The readahead buffer could be shared if this is indeed a problem.

-steve
