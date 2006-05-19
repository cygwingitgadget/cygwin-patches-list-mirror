Return-Path: <cygwin-patches-return-5853-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 620 invoked by alias); 19 May 2006 15:56:58 -0000
Received: (qmail 599 invoked by uid 22791); 19 May 2006 15:56:57 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 19 May 2006 15:56:53 +0000
Received: from mail.artimi.com ([192.168.1.3]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 19 May 2006 16:56:51 +0100
Received: from rainbow ([192.168.1.165]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Fri, 19 May 2006 16:56:50 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: Open sockets non-overlapped?
Date: Fri, 19 May 2006 15:56:00 -0000
Message-ID: <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00041.txt.bz2

On 19 May 2006 16:20, Lev Bishop wrote:

> Here's a trivial little patch for your consideration (while I wait for
> my copyright assignment to go through).
> 
> It makes it so that cygwin sockets can be passed usefully to windows
> processes. Eg:
> $ cmd /c dir > /dev/tcp/localhost/5001
> However, it's not perfect -- if the windows process just exits, then
> the connection is reset, not shut down gracefully.  

  Well, if the windows process just exits, that is exactly what it has done.
A socket should be shut down gracefully if the app calls shutdown(), and if it
just calls close() the socket should be reset.  That's what "gracefully"
means.

> Playing with
> SO_LINGER doesn't seem to help here. Only way I can think of to make
> it work would be to have the cygwin stub that waits for windows
> processes to exit, to keep a handle on the socket, poll for when the
> windows process closes the socket (using NtQuerySystemInformation
> SystemHandleInformation?) and when it does, close down the socket
> gracefully.

  It probably shouldn't be made to "work" because that would be altering the
semantics of sockets. 
 
> Anyway, this adds new functionality and doesn't seem to break anything
> that worked before.

  What, you've tested /everything/ that worked before?  ;)

http://cygwin.com/ml/cygwin/2005-03/msg01003.html
------------------------quote------------------------
"If you create a socket using the Winsock 2 WSASocket API and you need to
apply a timeout in receive or send operations on the socket, you must
specify the WSA_FLAG_OVERLAPPED flag in the WSASocket call."

From the MSDN website article
http://support.microsoft.com/default.aspx?scid=kb;en-us;181610.
------------------------quote------------------------

  Are we /sure/ cygwin doesn't *depend* on overlapped sockets?  In particular,
can a non-overlapped read be interrupted by a signal?  Have you tested this
vs. both blocking and non-blocking sockets?  This seems to me to be a highly
risky change; I'd like to know what testing you've done.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
