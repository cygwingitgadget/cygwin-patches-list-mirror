Return-Path: <cygwin-patches-return-7198-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3331 invoked by alias); 15 Feb 2011 16:06:41 -0000
Received: (qmail 2008 invoked by uid 22791); 15 Feb 2011 16:06:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 15 Feb 2011 16:06:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3D6BC2CAB63; Tue, 15 Feb 2011 17:05:59 +0100 (CET)
Date: Tue, 15 Feb 2011 16:06:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/doc ChangeLog new-features.sgml
Message-ID: <20110215160559.GC29654@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20110215153220.24348.qmail@sourceware.org> <4D5AA028.8050304@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D5AA028.8050304@redhat.com>
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
X-SW-Source: 2011-q1/txt/msg00053.txt.bz2

On Feb 15 08:47, Eric Blake wrote:
> On 02/15/2011 08:32 AM, corinna wrote:
> > 	* new-features.sgml (ov-new1.7.8): Document /proc/sys.
> > 
> > Patches:
> > http://sourceware.org/cgi-bin/cvsweb.cgi/src/winsup/doc/ChangeLog.diff?cvsroot=src&r1=1.328&r2=1.329
> > http://sourceware.org/cgi-bin/cvsweb.cgi/src/winsup/doc/new-features.sgml.diff?cvsroot=src&r1=1.64&r2=1.65
> 
> >  File system access via block devices works.  For instance
> > +(note the trailing backslash!)
> > +<screen>
> > +bash$ cd /proc/sys/Device/HarddiskVolumeShadowCopy1/
> 
> That's a trailing slash, not backslash.

Fixed.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
