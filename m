Return-Path: <cygwin-patches-return-7220-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18388 invoked by alias); 29 Mar 2011 08:02:52 -0000
Received: (qmail 18378 invoked by uid 22791); 29 Mar 2011 08:02:50 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 29 Mar 2011 08:02:39 +0000
Received: by iyi20 with SMTP id 20so5164413iyi.2        for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2011 01:02:38 -0700 (PDT)
Received: by 10.42.140.9 with SMTP id i9mr8793044icu.227.1301385758719;        Tue, 29 Mar 2011 01:02:38 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id gx2sm3493924ibb.9.2011.03.29.01.02.36        (version=SSLv3 cipher=OTHER);        Tue, 29 Mar 2011 01:02:38 -0700 (PDT)
Subject: Re: Provide sys/xattr.h
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110329075313.GF15349@calimero.vinschen.de>
References: <1301384629.4524.24.camel@YAAKOV04>	 <20110329075313.GF15349@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-9q/OdwZqWxzlLH3gSSue"
Date: Tue, 29 Mar 2011 08:02:00 -0000
Message-ID: <1301385758.4524.29.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00075.txt.bz2


--=-9q/OdwZqWxzlLH3gSSue
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 768

On Tue, 2011-03-29 at 09:53 +0200, Corinna Vinschen wrote:
> On Mar 29 02:43, Yaakov (Cygwin/X) wrote:
> > I see two ways to resolve this:
> > 
> > 1) Move include/attr/xattr.h to include/sys/xattr.h, and ship libattr's
> > attr/xattr.h in libattr-devel, exactly as is done on Linux:
> > 
> > 2) Install a copy of include/attr/xattr.h as <sys/xattr.h>, as in the
> > attached patch.
> 
> What about just creating a file sys/attr.h which includes attr/attr.h?

Right, that should do it as well.  I was so fixed on the Linux situation
(where you have two practically identical headers from different
sources) that I couldn't think of anything else.  I think it's time for
bed.

2011-03-29  Yaakov Selkowitz  <yselkowitz@...>

	* include/sys/xattr.h: New file.


Yaakov


--=-9q/OdwZqWxzlLH3gSSue
Content-Disposition: attachment; filename="xattr.h"
Content-Type: text/x-chdr; name="xattr.h"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 316

/* sys/xattr.h

   Copyright 2011 Red Hat, Inc.

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#ifndef _SYS_XATTR_H
#define _SYS_XATTR_H

#include <attr/xattr.h>

#endif /* _SYS_XATTR_H */

--=-9q/OdwZqWxzlLH3gSSue--
