Return-Path: <cygwin-patches-return-3096-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22015 invoked by alias); 1 Nov 2002 01:29:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21978 invoked from network); 1 Nov 2002 01:29:57 -0000
Date: Thu, 31 Oct 2002 17:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: open() not handling previously opened serial port gracefully?
Message-ID: <20021101013136.GA28293@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021031192006.00826c90@mail.attbi.com> <3.0.5.32.20021031192006.00826c90@mail.attbi.com> <3.0.5.32.20021031202037.00829440@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021031202037.00829440@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00047.txt.bz2

On Thu, Oct 31, 2002 at 08:20:37PM -0500, Pierre A. Humblet wrote:
>At 07:33 PM 10/31/2002 -0500, you wrote:
>>
>>Go ahead and check this in, Pierre.
>
>OK, but I still have outstanding questions about the process:
>- Do you expect a specially formatted string in the -m argument
>  of commit?

Look at the cygwin-cvs mailing list archives.

>- Is the ChangeLog updated by a separate commit, or in some 
>  automagic way?

A ChangeLog is just a file.  It gets edited like any other file.  There
is no magic involved.

cgf
