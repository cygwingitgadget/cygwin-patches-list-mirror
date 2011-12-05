Return-Path: <cygwin-patches-return-7554-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18191 invoked by alias); 5 Dec 2011 10:20:31 -0000
Received: (qmail 18131 invoked by uid 22791); 5 Dec 2011 10:20:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 05 Dec 2011 10:19:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A22EE2C01DE; Mon,  5 Dec 2011 11:19:56 +0100 (CET)
Date: Mon, 05 Dec 2011 10:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add support for creating native windows symlinks
Message-ID: <20111205101956.GB13067@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com> <CAHWeT-a0uH9_qvE9jPWVq7GJ_g2gm8_-JDeQRZ2Nhp3C5iSpAA@mail.gmail.com> <CAL-4N9tUqVa1PTp+nD3+ff5qJsJJX6A5U95nPeRsvF_zABsSAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL-4N9tUqVa1PTp+nD3+ff5qJsJJX6A5U95nPeRsvF_zABsSAA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00044.txt.bz2

On Dec  4 13:07, Russell Davis wrote:
> Hi Andy, thanks for the response.
> 
> > - Native links can't point to special Cygwin paths such as /proc and
> > /dev, although I guess that could be fudged.
> 
> They can, they just won't work when non-cygwin apps try to use them
> (perhaps what you're eluding to with the fudging). This is no worse
> than the status quo with cygwin's non-native symlinks -- non-cygwin
> apps can't follow those either. Verified as working with the original
> patch.
> 
> > - If the meaning of the POSIX path changes due to Cygwin mount point
> > changes, native symlinks won't reflect that and point to the wrong
> > thing.
> 
> Good point, but surely this must already be the case with
> shortcut-style symlinks (via CYGWIN=winsymlinks) as well?

No.  The Cygwin shortcut-style symlinks contain the POSIX path as well
and Cygwin only utilizes the POSIX path.  See symlink_info::check_shortcut.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
