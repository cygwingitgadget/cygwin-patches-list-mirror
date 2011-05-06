Return-Path: <cygwin-patches-return-7316-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11180 invoked by alias); 6 May 2011 08:51:57 -0000
Received: (qmail 11143 invoked by uid 22791); 6 May 2011 08:51:55 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-iw0-f171.google.com (HELO mail-iw0-f171.google.com) (209.85.214.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 May 2011 08:51:35 +0000
Received: by iwn8 with SMTP id 8so3464518iwn.2        for <cygwin-patches@cygwin.com>; Fri, 06 May 2011 01:51:35 -0700 (PDT)
Received: by 10.42.115.202 with SMTP id l10mr2095887icq.360.1304671894997;        Fri, 06 May 2011 01:51:34 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id y10sm1271907iba.12.2011.05.06.01.51.33        (version=SSLv3 cipher=OTHER);        Fri, 06 May 2011 01:51:33 -0700 (PDT)
Subject: Re: [PATCH] sysinfo
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110506081114.GH8245@calimero.vinschen.de>
References: <1304658552.5468.7.camel@YAAKOV04>	 <20110506081114.GH8245@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 06 May 2011 08:51:00 -0000
Message-ID: <1304671899.5468.11.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00082.txt.bz2

On Fri, 2011-05-06 at 10:11 +0200, Corinna Vinschen wrote:
> On May  6 00:09, Yaakov (Cygwin/X) wrote:
> > This implements sysinfo(2), a GNU extension:
> > 
> > http://www.kernel.org/doc/man-pages/online/pages/man2/sysinfo.2.html
> > 
> > The code is partially based on our /proc/meminfo and /proc/uptime code.
> > (My next patch will port the former to use sysinfo(2), but the latter
> > cannot as it uses .01s resolution, more than sysinfo's 1s.  That patch
> > will also fix /proc/meminfo and /proc/swaps for RAM and paging files
> > larger than 4GB.)
> > 
> > Patches for winsup/cygwin and winsup/doc, plus a test program, attached.
> > 
> > 
> > Yaakov
> > 
> 
> > 2011-05-05  Yaakov Selkowitz  <yselkowitz@...>
> > 
> > 	* sysconf.cc (sysinfo): New function.
> > 	* cygwin.din (sysinfo): Export.
> > 	* posix.sgml (std-gnu): Add sysinfo.
> > 	* include/sys/sysinfo.h (struct sysinfo): Define.
> > 	(sysinfo): Declare.
> > 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
> 
> That looks good to me.  Just a question...
> 
> > +  /* FIXME: unsupported */
> > +  info->loads[0] = 0UL;
> > +  info->loads[1] = 0UL;
> > +  info->loads[2] = 0UL;
> > +  info->sharedram = 0UL;
> > +  info->bufferram = 0UL;
> 
> Isn't bufferram the sum of paged and non-paged pool?

The comment alongside the bufferram member of struct sysinfo, as defined
in the manpage above, says "Memory used by buffers".  A similar meaning
is given for the Buffers: line of Linux's /proc/meminfo:

http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s2-proc-meminfo.html

So IIUC, no.


Yaakov

