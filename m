Return-Path: <cygwin-patches-return-4845-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4587 invoked by alias); 23 Jun 2004 16:05:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4328 invoked from network); 23 Jun 2004 16:05:43 -0000
Message-ID: <40D9AA56.8040802@etr-usa.com>
Date: Wed, 23 Jun 2004 16:05:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7) Gecko/20040616
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: rlogin problems
References: <3.0.5.32.20040622225313.008093a0@incoming.verizon.net> <20040623073630.GA15652@cygbert.vinschen.de>
In-Reply-To: <20040623073630.GA15652@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00197.txt.bz2

Corinna Vinschen wrote:

>>	WSASetLastError last.
> 
> Thanks for this patch!  I've just applied it.  Very weird that this
> only affected 9x.

The difference happens because on the Win9x kernels, the Winsock errors 
are kind of a bastard hack-on to the system error subsystem 
(GetLastError() and such).  On WinNT they're integrated, but there are 
still limitations, such as FormatMessage() not working on WSA error 
codes.  With Win2K, WSA errors are totally integrated into the system 
error code scheme.

So, under Win2K+ and possibly WinNT as well, any system call should 
reset the system error code, as happens with errno on that other class 
of OSes.  That's why you have to set it after the WSACloseEvent() call.
