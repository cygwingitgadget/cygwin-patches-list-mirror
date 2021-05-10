Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id C978F3857821
 for <cygwin-patches@cygwin.com>; Mon, 10 May 2021 07:51:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C978F3857821
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1Ofr-1lVbUs15SN-012sFl for <cygwin-patches@cygwin.com>; Mon, 10 May 2021
 09:51:41 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E47C0A80D95; Mon, 10 May 2021 09:51:40 +0200 (CEST)
Date: Mon, 10 May 2021 09:51:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Move source files used in utils/mingw/ into that
 subdirectory
Message-ID: <YJjmDHgz2aAEon03@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
 <20210502152537.32312-3-jon.turney@dronecode.org.uk>
 <YI/VCcOj36ydUiEw@calimero.vinschen.de>
 <0d4d3343-45ec-2e25-0985-e99db9b46c01@dronecode.org.uk>
 <YJOsMrJr+rC8EZHU@calimero.vinschen.de>
 <e95edb29-3a56-70d5-be45-ce68ffec9f0d@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e95edb29-3a56-70d5-be45-ce68ffec9f0d@dronecode.org.uk>
X-Provags-ID: V03:K1:bDeqRwYvCyQKdJDJSMfKXQiUjozGGML3KwG8LV2d3Tw6Cre2Wzx
 L4BhelOJGu3kd0AfBAPVkxChDOeMR53vdVE24mJ8sI+trdJgRzNt2UhnTYJ5U6Y28RWpjUR
 0wMPKizNlrcFX7hnf9EFeYLV5eEmDPv0dl2/AJpfG6Vk+HbZ6T0fecv8ezhq1Ue2ROfwtNB
 GVMqtxAJ9dYocvAQXi1dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6wux2VsWQVA=:5+9iE9LOBa2juWT8N8q4in
 mTgwayivnIQVpbW8TBOnt6g2f9lDxCm1OY15I+vTsdD+rjLLlgLw455OwijQldr4ZwFCt+dYN
 HWWVBXvUgmqhTd2Jp1fUD6xvPABmzzyFILaTp61uMHaUwDobbkQYRI5v+ctbqvao5knv92q41
 sAAOqOssXFCe2Faa08Gvf1HmEZLho8kBov+pjdmAROPcuR+oRQtR3WjQVSYDrrScl0PlF9Yxl
 J3906cZIvAEXbbFY157E/rQ8gPr22pTWv6GlFTh3bka+EmzhZvvkymen3NISyyZoJoTwqX79x
 IvF3CQNErP3haGlA00vjmvQI2SaOPsc7GCJZJ+dJflUmshXyxXpp3CLoILJP7RME4dvkm2Lvl
 07JLrvP9WP6qHqhBfCDw3KQF+Jc8YogKaUxsDnnnf9l9QXDnbkvaoMQ+DrCMYe5iq0ab35PC6
 ny278BbhmLHN8n1Vbste8PnxWTwS8HeHBLHSM6uuLTPodS5wKb8zXTgNOuwMI8orOu+axgRjg
 tre6bdMwW2bswT/CBMXqyI=
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 10 May 2021 07:51:44 -0000

On May  9 16:16, Jon Turney wrote:
> On 06/05/2021 09:43, Corinna Vinschen wrote:
> > On May  4 19:34, Jon Turney wrote:
> > > On 03/05/2021 11:48, Corinna Vinschen wrote:
> > > > What about adding -I../../cygwin -I../../cygwin/include to the build
> > > > rules and get rid of the relative paths inside the sources?
> > > 
> > > That seems fraught as it allows cygwin system headers to be picked up in
> > > preference to mingw ones?
> > > 
> > > Using '-idirafter' gets you a build, but it would be much more work to check
> > > that you've actually built what you wanted to...
> > 
> > Well, ok.  It just looks *so* ugly...  What about at least
> > 
> >    --idirafter ../../cygwin
> > 
> > and then
> > 
> >        #include "include/sys/strace.h"
> >        #include "include/sys/cygwin.h"
> >        #include "include/cygwin/version.h"
> >        #include "cygtls_padsize.h"
> >        #include "gcc_seh.h"
> > That would disallow picking up system headers and still be a bit
> > cleaner, no?
> 
> After thinking about this a bit more, I'm fairly certain that using
> -idirafter with both paths gets us the same build as before, so I've posted
> a patch with that change.
> 
> However, as written it's still a bit dangerous: any includes of system
> headers by those files included from winsup/cygwin will be getting MinGW
> system headers. I don't think that e.g. the value of ULONG_MAX is going be
> used by any of those, but there is a theoretical risk of them not getting
> what is expected...
> 
> Perhaps the only safe way to write this is to put the numeric constants
> which strace uses into a separate header.

That sounds like a really good idea.


Corinna
