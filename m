Return-Path: <cygwin-patches-return-2123-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26701 invoked by alias); 30 Apr 2002 01:02:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26673 invoked from network); 30 Apr 2002 01:02:50 -0000
Message-Id: <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Mon, 29 Apr 2002 18:02:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: SSH -R problem
Cc: schew@interzone.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00107.txt.bz2

In the thread
http://sources.redhat.com/ml/cygwin/2002-04/msg00515.html
Steve Chew, Chris and Corinna discuss a listen()
problem with ssh -R. Here is the explanation.

1) In Windows, a connect() always creates a listen socket
with the same port number as the connect socket.
That's easy to verify, e.g. with Windows telnet.
Note that the listen socket address is 0.0.0.0:ThePort 
To the contrary the Cygwin select() call creates a 
listening socket 127.0.0.1:yyy where yyy is arbitrary.

2) The reason the sockets persist is that they are 
non-blocking. On Win95/98/ME close() doesn't work 
correctly for non-blocking sockets, as reported in
http://cygwin.com/ml/cygwin-patches/2002-q2/msg00095.html 

The patch in fhandler_socket::close() would be something like:
/* HACK */
If the socket is non blocking
  then make it blocking 
       set linger to Off 
         (which will make close() non-blocking, as desired)
  else set linger to On, as done currently
The WSAEWOULDBLOCK stuff could go away.

I don't have the time to test and submit a real patch for the 
moment, perhaps Steve could help.
My rough test code basically adds
 int request = 0;
 ioctl (FIONBIO, &request);
 linger.l_onoff = 0; 
I have made > 500 calls into a connection created by ssh -R 
from WinME to WinME and > 100 calls into ssh -L from a client 
on WinME to a server on Win98. 

Of course we are then exposed to the issue that Cygwin was trying
to fix by setting linger to On, i.e. the case of a process 
exiting just after the close(). Fortunately sockets are usually 
non blocking in situations where there is some kind of persistent 
daemon handling several connections (or so I hope, otherwise ???).

Also in
http://cygwin.com/ml/cygwin-patches/2002-q2/msg00095.html 
I was speculating that my proposed patch to sshd would not take
care of the CLOSE_WAIT bug for ssh -R or -L.
This was unduly pessimistic. The bug does not occur in these
cases because no subprocess is forked.

Pierre
