Return-Path: <cygwin-patches-return-5884-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14092 invoked by alias); 12 Jun 2006 13:10:56 -0000
Received: (qmail 14081 invoked by uid 22791); 12 Jun 2006 13:10:55 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 12 Jun 2006 13:10:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 07FE4544008; Mon, 12 Jun 2006 15:10:47 +0200 (CEST)
Date: Mon, 12 Jun 2006 13:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
Message-ID: <20060612131046.GC2129@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00072.txt.bz2

On May 19 16:56, Dave Korn wrote:
> On 19 May 2006 16:20, Lev Bishop wrote:
> > It makes it so that cygwin sockets can be passed usefully to windows
> > processes. Eg:
> > $ cmd /c dir > /dev/tcp/localhost/5001
> > However, it's not perfect -- if the windows process just exits, then
> > the connection is reset, not shut down gracefully.  
> 
>   Well, if the windows process just exits, that is exactly what it has done.
> A socket should be shut down gracefully if the app calls shutdown(), and if it
> just calls close() the socket should be reset.  That's what "gracefully"
> means.
> 
> > Playing with
> > SO_LINGER doesn't seem to help here. Only way I can think of to make
> > it work would be to have the cygwin stub that waits for windows
> > processes to exit, to keep a handle on the socket, poll for when the
> > windows process closes the socket (using NtQuerySystemInformation
> > SystemHandleInformation?) and when it does, close down the socket
> > gracefully.
> 
>   It probably shouldn't be made to "work" because that would be altering the
> semantics of sockets. 
>  
> > Anyway, this adds new functionality and doesn't seem to break anything
> > that worked before.
> 
>   What, you've tested /everything/ that worked before?  ;)
> 
> http://cygwin.com/ml/cygwin/2005-03/msg01003.html
> ------------------------quote------------------------
> "If you create a socket using the Winsock 2 WSASocket API and you need to
> apply a timeout in receive or send operations on the socket, you must
> specify the WSA_FLAG_OVERLAPPED flag in the WSASocket call."
> 
> >From the MSDN website article
> http://support.microsoft.com/default.aspx?scid=kb;en-us;181610.
> ------------------------quote------------------------
> 
>   Are we /sure/ cygwin doesn't *depend* on overlapped sockets?  In particular,
> can a non-overlapped read be interrupted by a signal?  Have you tested this
> vs. both blocking and non-blocking sockets?  This seems to me to be a highly
> risky change; I'd like to know what testing you've done.

I found that using WSASocket(!OVERLAPPED) instead of socket results in
sshd misbehaviour (scp takes a long time to start copying files, an
interactive logon doesn't print the prompt until the user presses the
return key).  I didn't try to debug this, lazy as I am.

Additionally, I'm really curious *why* opening the socket without the
overlapped attribute should create a socket being more useful to native
Windows processes than standard, overlapped attributed sockets.  After
all the only visible difference is that a socket with the overlapped
attribute set can use overlapped operations, which the non-overlapped
socket can't.  It does not mean that overlapping I/O is forced on the
socket.  It's just adding a capability.

Actually, with a matching server listening on port 5001 (nc -l -p 5001),
I don't see any difference between using socket or WSASocket in the `cmd
/c dir > /dev/tcp/localhost/5001' example.  In both cases cmd refuses to
send anything useful to the server, printing "There is not enough space
on the disk."


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
