Return-Path: <cygwin-patches-return-4847-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22960 invoked by alias); 23 Jun 2004 16:26:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22949 invoked from network); 23 Jun 2004 16:26:04 -0000
Message-ID: <40D9AF19.1774032B@phumblet.no-ip.org>
Date: Wed, 23 Jun 2004 16:26:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: Warren Young <warren@etr-usa.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [Patch]: rlogin problems
References: <3.0.5.32.20040622225313.008093a0@incoming.verizon.net> <20040623073630.GA15652@cygbert.vinschen.de> <40D9AA56.8040802@etr-usa.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00199.txt.bz2



Warren Young wrote:
> 
> Corinna Vinschen wrote:
> 
> >>      WSASetLastError last.
> >
> > Thanks for this patch!  I've just applied it.  Very weird that this
> > only affected 9x.
> 
> The difference happens because on the Win9x kernels, the Winsock errors
> are kind of a bastard hack-on to the system error subsystem
> (GetLastError() and such).  On WinNT they're integrated, but there are
> still limitations, such as FormatMessage() not working on WSA error
> codes.  With Win2K, WSA errors are totally integrated into the system
> error code scheme.
> 
> So, under Win2K+ and possibly WinNT as well, any system call should
> reset the system error code, as happens with errno on that other class
> of OSes.  That's why you have to set it after the WSACloseEvent() call.

Well, it's kind of the opposite that happened.
On NT the successful WSACloseEvent() didn't affect the WSALastError,
which kept its old value (EINTR).
On 9x the successful WSACloseEvent() did reset WSALastError. rlogin
bailed out when the read failed for no good reason.

Pierre
