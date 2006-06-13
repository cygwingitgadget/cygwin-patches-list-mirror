Return-Path: <cygwin-patches-return-5886-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31422 invoked by alias); 13 Jun 2006 01:43:32 -0000
Received: (qmail 31409 invoked by uid 22791); 13 Jun 2006 01:43:31 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.181)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 13 Jun 2006 01:43:29 +0000
Received: by py-out-1112.google.com with SMTP id c30so1745506pyc         for <cygwin-patches@cygwin.com>; Mon, 12 Jun 2006 18:43:27 -0700 (PDT)
Received: by 10.35.96.7 with SMTP id y7mr5206287pyl;         Mon, 12 Jun 2006 18:43:27 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Mon, 12 Jun 2006 18:43:27 -0700 (PDT)
Message-ID: <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com>
Date: Tue, 13 Jun 2006 01:43:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
In-Reply-To: <20060612131046.GC2129@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> 	 <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM> 	 <20060612131046.GC2129@calimero.vinschen.de>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00074.txt.bz2

On 6/12/06, Corinna Vinschen wrote:
>
> I found that using WSASocket(!OVERLAPPED) instead of socket results in
> sshd misbehaviour (scp takes a long time to start copying files, an
> interactive logon doesn't print the prompt until the user presses the
> return key).  I didn't try to debug this, lazy as I am.

Strange. I don't run sshd, but I've been using this patch for a while
now and not noticed any problems. Maybe I'll try installing sshd one
of these days and see if I see those issues you describe.

> Additionally, I'm really curious *why* opening the socket without the
> overlapped attribute should create a socket being more useful to native
> Windows processes than standard, overlapped attributed sockets.  After
> all the only visible difference is that a socket with the overlapped
> attribute set can use overlapped operations, which the non-overlapped
> socket can't.  It does not mean that overlapping I/O is forced on the
> socket.  It's just adding a capability.

It doesn't make it any less useful to native processes _as a socket
handle_ but it does make a difference when the native processes use it
_as a file handle_. As you know, the semantics of WriteFile() et al
change completely depending on whether they get an overlapped handle
or not (eg the LPOVERLAPPED parameter either _must_ be null or _must
not_ be null, on 95/98/Me) . And there seems to be no way to tell
whether a handle you've inherited was opened overlapped or not (short
of using the NT API: NtQueryInformationFile FILE_MODE_INFORMATION) and
no way to reset the mode once the file has been opened. So
applications are effectively forced to assume their GetStdHandle()s'
are non-overlapped.

> Actually, with a matching server listening on port 5001 (nc -l -p 5001),
> I don't see any difference between using socket or WSASocket in the `cmd
> /c dir > /dev/tcp/localhost/5001' example.  In both cases cmd refuses to
> send anything useful to the server, printing "There is not enough space
> on the disk."

Hmph. It works for me. Must be some difference in our configurations,
windows versions, etc. I note that msdn warns that using socket
handles as file handles is an optional feature and not all providers
support it. I guess the provider must be both a Winsock provider and
also a file-system driver in order to make this work. Maybe you have
some LSPs on your machine or something?

Lev
