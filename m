Return-Path: <cygwin-patches-return-3042-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26319 invoked by alias); 24 Sep 2002 15:56:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26304 invoked from network); 24 Sep 2002 15:56:04 -0000
Date: Tue, 24 Sep 2002 08:56:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_tty doecho change
Message-ID: <20020924105431.A3758@fnord.io.com>
References: <20020924015053.A21742@eris.io.com> <20020924092143.J29920@cygbert.vinschen.de> <20020924143723.GB918@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020924143723.GB918@redhat.com>; from cgf@redhat.com on Tue, Sep 24, 2002 at 10:37:23AM -0400
X-SW-Source: 2002-q3/txt/msg00490.txt.bz2

On Tue, Sep 24, 2002 at 10:37:23AM -0400, Christopher Faylor wrote:
> On Tue, Sep 24, 2002 at 09:21:43AM +0200, Corinna Vinschen wrote:
> >This looks interesting but is actually missing a ChangeLog entry.

Here's the ChangeLog patch.

> I don't think we have an assignment on file for Steve, either.

Crud.  Anyone want to write a few patches to the tty code?  

I was thinking about the deadlock problem some more last night, 
and it occured to me that if termios processing were done on 
the slave side, some of the buffering and tricky bits of 
flushing the write buffer would go away (maybe).  And you wouldn't
need this patch. 

-steve

Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.1497
diff -r1.1497 ChangeLog
0a1,19
> 2002-09-23  Steve Osborn  <bub@io.com>
> 
>       * fhandler.h: (fhandler_pty_master::get_echobuf_valid): Added.
>       (fhandler_pty_master::get_echobuf_into_buffer): Added.  
>       (fhandler_pty_master::clear_echobuf): Added.    
>       (fhandler_pty_master::ebbuf): Added pointer to echobuf.
>       (fhandler_pty_master::ebixget): Added echobuf get index.
>       (fhandler_pty_master::ebixput): Added echobuf put index.
>       (fhandler_pty_master::ebbuflen): Added echobuf length.
>       (fhandler_pty_master::ebguard): Added handle for guard mutex.
>       * fhandler_tty.cc: (fhandler_pty_master::get_echobuf_valid): Added.
>       (fhandler_pty_master::get_echobuf_into_buffer): Added.  
>       (fhandler_pty_master::clear_echobuf): Added.
>       (fhandler_pty_master::process_slave_output): prime read with echobuf.
>       (fhandler_pty_master::fhandler_pty_master): initializers for echobuf.
>       (fhandler_pty_master::open): calls clear_echobuf.
>       (fhandler_pty_master::close): calls clear_echobuf.
>       * select.cc: (peek_pipe): check for echobuf valid.
> 
