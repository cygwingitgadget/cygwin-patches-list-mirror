Return-Path: <cygwin-patches-return-4142-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 722 invoked by alias); 29 Aug 2003 14:19:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 712 invoked from network); 29 Aug 2003 14:19:18 -0000
Message-ID: <3F4F60EA.4DBB8A51@phumblet.no-ip.org>
Date: Fri, 29 Aug 2003 14:19:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com> <20030829031256.GA18890@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00158.txt.bz2

Christopher Faylor wrote:
> 
> I was heartened to see that zsh did not crash when I sicc'ed this
> program on it -- until I tried to type something at the zsh prompt and
> saw that it was hung.  The reason was that the recursive signal call
> stuff was still not right.  We were restoring the return address
> incorrectly.  AFAICT, we really do have to use the stored
> retaddr_on_stack to rectify setup_handler's inappropriate "fixup" of the
> return address.  Restoring it to 36(%%esp) wasn't right.

Wow. What was wrong? After you noticed that one could remove
        movl    %%esp,%%ebp
        addl    $36,%%ebp       
before the call to set_process_mask, I though eveything made perfect sense.
After returning from the (user) signal handler and pulling off the 
argument, both the esp and ebp should be exactly as before the call.
It that's not true, the whole stack model of programming breaks down. 

>  The excess
> nosync loop would have only introduced a processor load but input should
> have still been functional since the signal handler calls were probably
> handled by the inner loop in wait_sig.

100% Yes.

> So, I ended up checking in the change to use events and am building
> a snapshot now.  With luck, I've solved Corinna's problems and maybe
> I can even release 1.5.3 this weekend.

I surely hope so!

Pierre
