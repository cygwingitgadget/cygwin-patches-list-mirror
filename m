Return-Path: <cygwin-patches-return-5496-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32687 invoked by alias); 31 May 2005 00:18:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32675 invoked by uid 22791); 31 May 2005 00:18:06 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 31 May 2005 00:18:06 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 1CCFC13CA7E; Mon, 30 May 2005 20:18:04 -0400 (EDT)
Date: Tue, 31 May 2005 00:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: link(2) fails on mounted network shares
Message-ID: <20050531001804.GB17217@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <8768.1117496344@www52.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8768.1117496344@www52.gmx.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00092.txt.bz2

On Tue, May 31, 2005 at 01:39:04AM +0200, Martin Koeppe wrote:
>Hello,
>
>I recently found out that you cannot create hardlinks
>on mounted network shares with cygwin
>(error: No such file or directory),
>but you can do it with the ln.exe from Interix.
>
>So I looked at it and found that the Windows API
>function CreateHardLink() causes the trouble, it apparently
>only works for local drives.
>
>There is another API function, however, which creates hardlinks
>correctly on local and network drives (tested on Win2003 shares
>and Samba shares):
>
>MoveFileEx() with parameter:
>#define MOVEFILE_CREATE_HARDLINK 16

I've found two references to this in MSDN.  Both say:

MOVEFILE_CREATE_HARDLINK 	Reserved for future use.

That doesn't sound too encouraging as far as compatibility is concerned.

cgf
