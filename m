Return-Path: <cygwin-patches-return-2141-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27201 invoked by alias); 2 May 2002 15:51:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27140 invoked from network); 2 May 2002 15:51:31 -0000
Message-ID: <3CD15FBA.8FD5A6B0@ieee.org>
Date: Thu, 02 May 2002 08:51:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: SSH -R problem
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020430073223.007e3e00@mail.attbi.com> <20020430142039.D1214@cygbert.vinschen.de> <3CCEA638.E357EFE2@ieee.org> <20020502173110.A15039@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00125.txt.bz2

Corinna Vinschen wrote:
> I'd propose to try it first as I said in my previous mail:

Corinna, 

did you see my e-mails of last two evenings?
- the blocking is a Win98 problem, the linger helps only for NT
- for NT, linger is (probably) not the "real" solution.

Although what you propose is better than nothing, I would not do
anything until we really understand what's going on.

Here is a summary of the recently characterized Windows TCP bugs 
and of their proposed solutions. I was going to send it this evening, 
with url's to the mails describing the problems and the proposed fixes,
but here it is.

Win98/ME
1) CLOSE_WAIT / WSAENOBUFS
   Application level fix:  fcntl("close on fork")
   Cygwin level fix:       Corinna's socket/pid bookkeeping

2) ssh -R / persisting listen sockets 
   Application level fix: make socket blocking before close
   Cygwin level fix:      make socket blocking before close

3) Unexpected ssh exit
   Application level fix:  fcntl("close on fork")
   Cygwin level fix: (???) do not duplicate "listen" sockets after 
                           an accept() has succeeded

4) Jonathan Kamens, with extra read() hanging while waiting for EOF
   Application level fix:  shutdown()
   Cygwin level fix:       Corinna's socket/pid bookkeeping

NT
1) Jonathan Kamens / linger on close hack
   Application level fix:  shutdown()
   Cygwin level fix:       Corinna's socket/pid bookkeeping

Pierre
