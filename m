Return-Path: <cygwin-patches-return-3122-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1141 invoked by alias); 5 Nov 2002 16:50:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1128 invoked from network); 5 Nov 2002 16:50:29 -0000
Date: Tue, 05 Nov 2002 08:50:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_socket::recvmsg [WAS: Anyone interested in checking out dgram socket problem (Conrad you still here?)]
Message-ID: <20021105165225.GC5187@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021105050917.GA19118@redhat.com> <Pine.WNT.4.44.0211051101530.322-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0211051101530.322-200000@algeria.intern.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00073.txt.bz2

On Tue, Nov 05, 2002 at 11:19:35AM +0100, Thomas Pfaff wrote:
>On Tue, 5 Nov 2002, Christopher Faylor wrote:
>>There is a thread in cygwin at cygwin entitled:
>>
>>"1.3.13-2 & 1.3.14-1 problem on read() from dgram socket"
>>
>>Is anyone willing to debug the problem and, if it is a cygwin problem,
>>provide a fix?
>>
>>http://cygwin.com/ml/cygwin/2002-10/msg01974.html
>
>It seems that the fromlen in WSARecvFrom must be NULL if from is NULL
>and not a pointer to 0.  Actually msg->msg_name is NULL and
>msg->msg_namelen is 0 which will result in WSAEFAULT.
>
>Thomas
>
>2002-11-05 Thomas Pfaff <tpfaff@gmx.net>
>
>* fhandler_socket.cc (fhandler_socket::recvmsg): If from == NULL call
>WSARecvFrom with fromlen = NULL.


Thank you Thomas!  I'm applying your patch.

I really really appreciate your looking into this.

cgf
