Return-Path: <cygwin-patches-return-2125-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14057 invoked by alias); 30 Apr 2002 11:33:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14042 invoked from network); 30 Apr 2002 11:33:52 -0000
Message-Id: <3.0.5.32.20020430073223.007e3e00@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Tue, 30 Apr 2002 04:33:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: SSH -R problem
In-Reply-To: <20020430103200.C18891@cygbert.vinschen.de>
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
 <3.0.5.32.20020429205809.007f2920@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00109.txt.bz2

At 10:32 AM 4/30/2002 +0200, Corinna Vinschen wrote:
>> Of course we are then exposed to the issue that Cygwin was trying
>> to fix by setting linger to On, i.e. the case of a process 
>> exiting just after the close(). Fortunately sockets are usually 
>
>...why cant we keep that, i. e.
>
>   If the socket is non blocking
>     then make it blocking
>    set linger to On, as done currently

because in the case of a server handling many connections at once
(ssh or sshd, among others) you don't want to block the whole operation 
when closing one socket.

Pierre
 
