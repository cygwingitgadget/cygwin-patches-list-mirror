Return-Path: <cygwin-patches-return-6810-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7710 invoked by alias); 2 Nov 2009 16:38:07 -0000
Received: (qmail 7699 invoked by uid 22791); 2 Nov 2009 16:38:07 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Nov 2009 16:38:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id F25F06D41A0; Mon,  2 Nov 2009 17:37:51 +0100 (CET)
Date: Mon, 02 Nov 2009 16:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch: Protect tcsh init scripts against home dirs with spaces  in  	them
Message-ID: <20091102163751.GB2749@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <51e5f6120911020821h3c3f1273sffa9107e22099eaa@mail.gmail.com>  <51e5f6120911020831p61107af8u4193cbd1d81cb38c@mail.gmail.com>  <51e5f6120911020832g715ce5c7v2bb0d60d8e662698@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51e5f6120911020832g715ce5c7v2bb0d60d8e662698@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00141.txt.bz2

On Nov  2 08:32, Jeremy Elson wrote:
> Hi,
> I'm not sure if this is a cygwin bug or an upstream bug, but I've
> found a bug in the latest
> cygwin 1.7 beta that prevents tcsh from initializing correctly in home
> directories with spaces

Very wrong mailing list.  See http://cygwin.com/lists.html

This is an upstream bug which has been fixed long ago.  The
/etc/defaults/etc/profile.d/complete.tcsh of tcsh in the 1.7 distro does
not have the bug.  Just replace your /etc/profile.d/complete.tcsh with
that one.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
