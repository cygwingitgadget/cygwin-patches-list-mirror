Return-Path: <cygwin-patches-return-3324-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1170 invoked by alias); 16 Dec 2002 13:40:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1138 invoked from network); 16 Dec 2002 13:39:57 -0000
From: "Hartmut Honisch" <hartmut_honisch@web.de>
To: <cygwin-patches@cygwin.com>
Subject: RE: Minor additions to winbase.h and ntdll.def
Date: Mon, 16 Dec 2002 05:40:00 -0000
Message-ID: <NFBBLLCAILKHOEOHEFMHCEBECEAA.hartmut_honisch@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3DFDD027.8080300@yahoo.com>
X-SW-Source: 2002-q4/txt/msg00275.txt.bz2

> > Winbase.h
> > - Changed NMPWAIT_WAIT_FOREVER constant from (-1) to 0xffffffff (like in
> Why?

I have a piece of own code that passes NMPWAIT_WAIT_FOREVER as a parameter
to CallNamedPipe. The compiler gave me a warning because the function
prototype expected a DWORD value which by definition cannot be negative. So
it's obviously a (minor) bug in cygwin's header files, which I thought the
cygwin folks might be interested in to fix.

> Looking at Microsoft's header files and making changes to w32api is not
> allowed.

Technically, I didn't do it that way. I just mentioned that to avoid
discussions like that one, since cygwin's headers shouldn't differ from
Microsoft's headers regarding the value of numeric constants.

> You'll have to find the MSDN documentation and provide the
> references.

There are no references in MSDN that show the numeric value of that
constant - at least I can't find any. So I wonder how (-1) got there in the
first place.

Hartmut
